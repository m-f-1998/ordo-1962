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

enum iCalState {
    case success, failure, loading, not_showing
}

struct iCalResult {
    var data: String = ""
    var state: iCalState
}

struct iCal: View {
    @EnvironmentObject var ordo: OrdoAPI
    @EnvironmentObject var net: NetworkMonitor
    @State private var permissions: Bool = false
    @Binding var res: iCalResult

    private let title: String = "Liturgical Ordo (1962)"
    private let store: EKEventStore = EKEventStore ( )

    var body: some View {
        if ( net.connected ) {
            Section {
                Button {
                    Task {
                        try await self.Loading ( )
                        await self.GenerateCalendar ( )
                        try await self.NotShowing ( )
                    }
                } label: {
                    Text ( "Create \( CurrentYear ( ) ) Liturgical Ordo iCal" )
                }
            } header: {
                Text ( "Calendar" )
            }.task {
                await self.Permissions ( )
            }
        }
    }
    
    // Show Loading AlertToast Widget, Delay For n Seconds After
    private func Loading ( seconds: Double = 2.0 ) async throws {
        self.res = iCalResult ( state: .loading )
        try await Task.sleep ( nanoseconds: UInt64 ( seconds * Double ( NSEC_PER_SEC ) ) )
    }
    
    // Hide All AlertToast Widgets, Delay n Seconds Before Hiding
    private func NotShowing ( seconds: Double = 2.0 ) async throws {
        try await Task.sleep ( nanoseconds: UInt64 ( seconds * Double ( NSEC_PER_SEC ) ) )
        self.res = iCalResult ( state: .not_showing )
    }
    
    // Are Calendar Permissions Turned On?
    private func Permissions ( ) async {
        do {
            self.permissions = try await self.store.requestAccess ( to: .event )
        } catch {
            self.permissions = false
        }
    }

    // Get The EKCalendar Object, Check If Duplicates Exist
    private func GetCalendar ( title: String ) throws -> EKCalendar {
        if let id = UserDefaults.standard.string ( forKey: "calendar_id" ) {
            if self.store.calendar ( withIdentifier: id ) != nil {
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
    
    // Generate Calendar
    func GenerateCalendar ( ) async {
        if ( self.permissions ) {
            do {
                let calendar = try GetCalendar ( title: self.title )
                let data: ResultAPI <OrdoData> = await self.ordo.GetCache ( )
                
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
                    self.res = iCalResult ( data: "iCal Successfully Created", state: .success )
                } else if case let .failure ( error ) = data {
                    self.res = iCalResult ( data: error, state: .failure )
                }
            } catch iCalError.duplicate {
                self.res = iCalResult ( data: "iCal Already Exists", state: .failure )
            } catch {
                self.res = iCalResult ( data: "iCal Could Not Be Saved", state: .failure )
            }
        } else {
            self.res = iCalResult ( data: "Calendar Permissions Failed", state: .failure )
        }
    }
}
