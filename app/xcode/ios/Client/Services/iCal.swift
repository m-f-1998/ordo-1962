//
//  Calendar.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/05/2023.
//

import SwiftUI
import EventKitUI
import AlertToast

enum iCalError: Error {
    case calendar, duplicate
}

class iCal {
    var current_ordo: OrdoYear
    private let title: String = "Liturgical Ordo (1962)"
    private let store: EKEventStore = EKEventStore ( )
    @ObservedObject public var status: AlertViewModel

    init ( current_ordo: OrdoYear, alert: AlertViewModel ) {
        self.current_ordo = current_ordo
        self.status = alert
    }

    private func Permissions ( completion: @escaping ( Bool ) -> Void ) {
        self.store.requestFullAccessToEvents { ( granted, error ) in
            if let error = error {
                print ( "EventKit Permissions Error: \( error.localizedDescription )" )
            }
            completion ( granted )
        }
    }

    private func GetCalendar ( title: String ) throws -> EKCalendar {
        if let id = UserDefaults.standard.string ( forKey: "calendar_id" ) {
            if self.store.calendar ( withIdentifier: id ) != nil {
                throw iCalError.duplicate // Calendar Already Exists On Device
            }
            UserDefaults.standard.removeObject ( forKey: "calendar_id" ) // Calendar Has Been Removed Since Last Check
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

    func GenerateCalendar ( completion: @escaping ( ) -> Void ) {
        self.Permissions ( ) { permissions in
            print ( "EventKit Permissions: \(permissions)" )
            if permissions {
                do {
                    let calendar = try self.GetCalendar ( title: self.title )
                    Task {
                        for MonthName in Calendar.current.shortMonthSymbols {
                            let month = self.current_ordo.getMonth ( month: MonthName )
                            for day in month {
                                for feast in day.celebrations {
                                    let event = EKEvent ( eventStore: self.store )
                                    event.title = feast.title + " (Class \(String(feast.rank)))"
                                    event.isAllDay = true
                                    event.startDate = FormatDate ( date: .short, time: .none ).date ( from: "\(day.date.day) \(day.date.month) \(CurrentYear ( ))" )
                                    event.endDate = event.startDate
                                    event.notes = feast.commemorations.map { ( x ) -> String in
                                        return "Commemoration Today: " + x.title
                                    }.joined ( separator: "\n" )
                                    event.calendar = calendar
                                    try self.store.save ( event, span: .futureEvents )
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.status.alertToast = AlertToast ( type: .complete ( .green ), title: "iCal Successfully Created" )
                            completion ( )
                        }
                    }
                } catch iCalError.duplicate {
                    DispatchQueue.main.async {
                        self.status.alertToast = AlertToast ( type: .error ( .red ), title: "iCal Already Exists" )
                        completion ( )
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.status.alertToast = AlertToast ( type: .error ( .red ), title: "iCal Could Not Be Saved" )
                        completion ( )
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.status.alertToast = AlertToast ( type: .error ( .red ), title: "Calendar Permissions Failed" )
                    completion ( )
                }
            }
        }
    }
}
