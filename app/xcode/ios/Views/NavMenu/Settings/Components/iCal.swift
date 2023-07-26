//
//  Calendar.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI
import EventKitUI

enum iCalError: Error {
    case calendar, duplicate
}

enum iCalResult {
    case success ( String ), failure ( String )
}

struct DeviceCalendar: View {
    var store: EKEventStore = EKEventStore ( )
    
    @EnvironmentObject var ordo: OrdoAPI
    @EnvironmentObject var net: NetworkMonitor
    
    @State var permissions: Bool = false
    @Binding var ical_success: Bool
    @Binding var ical_loading: Bool
    @Binding var save_ical_res: iCalResult

    var title: String = "Liturgical Ordo (1962)"

    var body: some View {
        if ( net.connected ) {
            Section {
                Button {
                    self.ical_loading.toggle ( )
                    Task {
                        try await Task.sleep ( nanoseconds: UInt64 ( 1.5 * Double ( NSEC_PER_SEC ) ) )
                        await self.ical ( ) { res in
                            self.ical_loading.toggle ( )
                            self.save_ical_res = res
                            self.ical_success.toggle ( )
                        }
                    }
                } label: {
                    Text ( "Create \( CurrentYear ( ) ) Liturgical Ordo iCal" )
                }
            } header: {
                Text ( "Calendar" )
            }.task {
                await self.CalendarPermissions ( )
            }
        }
    }

    func getEKCalendar ( title: String ) throws -> EKCalendar {
        let identifier_exists = UserDefaults.standard.string ( forKey: "calendar_id" ) != nil
        
        if identifier_exists {
            if self.store.calendar ( withIdentifier: UserDefaults.standard.string ( forKey: "calendar_id" )! ) != nil {
                throw iCalError.duplicate
            }
            UserDefaults.standard.removeObject ( forKey: "calendar_id" )
        }

        let calendar = EKCalendar ( for: .event, eventStore: self.store )
        calendar.title = title
        calendar.source = self.store.defaultCalendarForNewEvents!.source
        do {
            try self.store.saveCalendar ( calendar, commit: true )
        } catch {
            throw iCalError.calendar
        }
        
        UserDefaults.standard.set ( calendar.calendarIdentifier, forKey: "calendar_id" )
        return calendar
    }
    
    func CalendarPermissions ( ) async {
        do {
            self.permissions = try await self.store.requestAccess ( to: .event )
        } catch {
            self.permissions = false
        }

    }
    
    func ical ( completion: @escaping ( ( iCalResult ) -> Void ) ) async {
        if ( self.permissions ) {
            do {
                let calendar = try getEKCalendar ( title: self.title )
                let data = await self.ordo.GetCache ( )
                if case let .success ( res ) = data {
                    for month in Calendar.current.monthSymbols {
                        for day in res [ month ]! {
                            for feast in day.celebrations {
                                let event = EKEvent ( eventStore: self.store )
                                event.title = feast.title + " (Class \(String(feast.rank)))"
                                event.isAllDay = true
                                event.startDate = FormatDate ( ).date ( from: "\(day.date) \(month) \(CurrentYear ( ))" )
                                event.endDate = event.startDate
                                var notes = ""
                                if let commemoration = feast.commemorations {
                                    for x in commemoration {
                                        notes += "Commemoration Today: " + x.title + "\n"
                                    }
                                }
                                event.notes = notes
                                event.calendar = calendar
                                try self.store.save ( event, span: .futureEvents )
                            }
                        }
                    }
                    completion ( .success ( "Calendar Successfully Created" ) )
                } else if case let .failure ( error ) = data {
                    completion ( .failure ( error ) )
                }
            } catch iCalError.duplicate {
                completion ( .failure ( "Calendar Already Exists" ) )
            } catch {
                completion ( .failure ( "1962 Liturgical Ordo could not be Saved" ) )
            }
        } else {
            completion ( .failure ( "Permissions Failed" ) )
        }
    }
}
