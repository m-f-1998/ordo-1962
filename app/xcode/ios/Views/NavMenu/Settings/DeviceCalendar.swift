//
//  Calendar.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI
import EventKitUI

enum DeviceCalError: Error {
    case calendar
}

enum DeviceCalRes {
    case success ( String ), failure ( String )
}

struct DeviceCalendar: View {
    @Binding var ical_success: Bool
    @Binding var save_ical_res: DeviceCalRes?

    @State var permissions: Bool = false
    @State var store: EKEventStore = EKEventStore ( )
    @EnvironmentObject var ordo: OrdoAPI

    var title: String = "Liturgical Ordo (1962)"

    var body: some View {
        Section {
            Button {
                Task {
                    await self.permission ( )
                    await self.ical ( ) { res in
                        self.save_ical_res = res
                        self.ical_success.toggle ( )
                    }
                }
            } label: {
                Text ( "Create \( CurrentYear ( ) ) Liturgical Ordo iCal" )
            }
        } header: {
            Text ( "Calendar" )
        } footer: {
            Text ( "If the iCal already exists, a duplicate will be created." )
        }
    }

    func getEKCalendar ( title: String ) throws -> EKCalendar {
        let calendar = EKCalendar ( for: .event, eventStore: self.store )
        calendar.title = title
        calendar.source = self.store.defaultCalendarForNewEvents!.source
        
        do {
            try self.store.saveCalendar ( calendar, commit: true )
            return calendar
        } catch {
            throw DeviceCalError.calendar
        }
    }
    
    func permission ( ) async {
        switch EKEventStore.authorizationStatus ( for: .event ) {
        case .authorized:
            self.permissions = true
        case .notDetermined:
            do {
                self.permissions = try await self.store.requestAccess ( to: .event )
            } catch {
                self.permissions = false
            }
        default:
            self.permissions = false
        }
    }
    
    func ical ( completion: @escaping ( ( DeviceCalRes ) -> Void ) ) async {
        if ( self.permissions ) {
            do {
                let calendar = try getEKCalendar ( title: self.title )
                await withTaskGroup ( of: Void.self ) { group in
                    let data = await API ( ).GetData ( just_cache: true, wait: false, file: "ordo.data", url: "ordo.php", type: OrdoData.self )
                    if case let .success ( res ) = data {
                        for month in Calendar.current.monthSymbols {
                            for day in res [ month ]! {
                                group.addTask {
                                    let event = await EKEvent ( eventStore: self.store )
                                    event.title = day.celebration [ 0 ].title
                                    event.isAllDay = true
                                    event.startDate = FormatDate ( ).date ( from: "\(day.date) \(month) \(CurrentYear ( ))" )
                                    event.endDate = event.startDate
                                    event.calendar = calendar
                                    do {
                                        try await self.store.save ( event, span: .futureEvents, commit: false )
                                    } catch {
                                        completion ( .failure ( "Could Not Save Events" ) )
                                    }
                                }
                            }
                        }
                    } else if case let .failure ( error ) = ordo.res {
                        completion ( .failure ( error ) )
                    }
                }
                do {
                    try self.store.commit ( )
                    completion ( .success ( "Calendar Successfully Created" ) )
                } catch {
                    completion ( .failure ( "Could Not Commit Events" ) )
                }
            } catch {
                completion ( .failure ( "1962 Liturgical Ordo could not be Saved" ) )
            }
        } else {
            completion ( .failure ( "Permissions Failed" ) )
        }
    }
}
