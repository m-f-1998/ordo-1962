//
//  CalendarWidget.swift
//  ordo-1962-widget
//
//  Created by Matthew Frankland on 10/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @ObservedObject var activeData: ActiveData
    @State var api: API
    @ObservedObject var net: NetworkMonitor = NetworkMonitor ( )

    init ( ) {
        let activeData = ActiveData ( )
        self.activeData = activeData
        self.api = API ( activeData: activeData )
    }
        
    func getEntry ( ) async -> [ SimpleEntry ] {
        do {
            let current = CurrentYear ( )
            let data = try self.api.cache.GetOrdo ( predicate: #Predicate<OrdoYear> { year in
                year.year == current
            } )
            if data.count > 0 {
                let entry = SimpleEntry ( date: .now, feast: data [ 0 ].getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) ).celebrations [ 0 ], loading: false )
                return [ entry ]
            }
        } catch {
            print ( error )
        }
        return [ SimpleEntry ( date: .now, feast: CelebrationData ( ), loading: true ) ]
    }

    /*
     Provides a timeline entry representing a placeholder version of the widget.
     */
    func placeholder ( in context: Context ) -> SimpleEntry {
        SimpleEntry ( date: .now, feast: CelebrationData ( ), loading: true )
    }

    /*
        Provides a timeline entry that represents the current time and state of a widget.
     */
    func getSnapshot ( in context: Context, completion: @escaping ( SimpleEntry ) -> ( ) ) {
        Task {
            completion ( await getEntry ( ) [ 0 ] )
        }
    }

    /*
     Refreshes after last element in timeline has passed i.e. per day
     */
    func getTimeline ( in context: Context, completion: @escaping ( Timeline<Entry> ) -> ( ) ) {
        Task {
            let entry = await getEntry ( )
            let entryDate = Calendar.current.date ( byAdding: .minute, value: 1, to: .now )!
            completion ( Timeline ( entries: entry, policy: entry [ 0 ].loading ? .after ( entryDate ) : .atEnd ) )
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let feast: CelebrationData
    let loading: Bool
}

struct SystemWidget : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text ( entry.feast.title )
                .padding ( [ .bottom ], 1 )
                .font ( .system ( size: 14 ) )
                .redacted ( reason: entry.loading ? .placeholder : [ ] )
            Text ( "Class \( entry.feast.rank )" )
                .padding ( [ .bottom ], 1 )
                .redacted ( reason: entry.loading ? .placeholder : [ ] )
            Text ( .now, style: .date )
        }
            .font ( .system ( size: 12 ) )
            .frame ( maxWidth: .infinity, maxHeight: .infinity )
            .bold ( )
            .multilineTextAlignment ( .center )
            .foregroundColor ( entry.feast.colors.components ( separatedBy: "," ) [ 0 ] == "b" ? .white : .black )
            .containerBackground ( Color ( word: entry.feast.colors.components ( separatedBy: "," ) [ 0 ] )!, for: .widget )
    }
}

struct RectangularWidgetView : View {
    var entry: Provider.Entry

    var body: some View {
        Text ( entry.feast.title )
            .font ( .system ( size: 15 ) )
            .redacted ( reason: entry.loading ? .placeholder : [ ] )
            .multilineTextAlignment ( .center )
            .bold ( )
            .containerBackground ( Color ( word: entry.feast.colors.components ( separatedBy: "," ) [ 0 ] )!, for: .widget )
    }
}

struct InlineWidgetView : View {
    var entry: Provider.Entry

    var body: some View {
        Text ( entry.feast.title )
            .redacted ( reason: entry.loading ? .placeholder : [ ] )
            .bold ( )
            .multilineTextAlignment ( .center )
            .containerBackground ( Color ( word: entry.feast.colors.components ( separatedBy: "," ) [ 0 ] )!, for: .widget )
    }
}

struct EntryView: View {
    // Obtain the widget family value
    @Environment(\.widgetFamily) var family
    let entry: SimpleEntry

    var body: some View {
        switch family {
        case .accessoryRectangular:
            // Rectangular Lock Screen UI
            RectangularWidgetView ( entry: entry )
        case .accessoryInline:
            // Inline Lock Screen  UI
            InlineWidgetView ( entry: entry )
        default:
            // UI for Home Screen widget
            SystemWidget ( entry: entry )
        }
    }
}

struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration ( kind: kind, provider: Provider ( ) ) { entry in
            EntryView ( entry: entry )
        }
            .supportedFamilies ( [ .systemSmall, .systemMedium, .accessoryRectangular, .accessoryInline ] )
            .configurationDisplayName ( "Liturgical Calendar" )
            .description ( "Feast of the Day" )
    }
}

@main
struct OrdoWidget: WidgetBundle {
    var body: some Widget {
        CalendarWidget ( )
    }
}
