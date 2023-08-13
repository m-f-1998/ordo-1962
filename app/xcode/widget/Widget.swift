//
//  CalendarWidget.swift
//  ordo-1962-widget
//
//  Created by Matthew Frankland on 10/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @ObservedObject var api: API = API ( )
    
    func getEntry ( ) async -> [ SimpleEntry ] {
        await api.GetData ( )
        switch api.res {
        case .success ( let data ):
            let json = data [ 0 ].celebrations [ 0 ]
            let entry = SimpleEntry ( date: .now, feast: json, loading: false, alternative: data [ 0 ].celebrations.count > 1 )
            return [ entry ]
        case .failure ( _ ):
            fatalError ( "No Data Retrieved" )
        default:
            fatalError ( "No Data Retrieved" )
        }
    }

    /*
     Provides a timeline entry representing a placeholder version of the widget.
     */
    func placeholder ( in context: Context ) -> SimpleEntry {
        SimpleEntry ( date: .now, feast: FeastData ( id: UUID().uuidString, title: "", rank: 1, colors: "r", options: "", commemorations: [] ), loading: true, alternative: false )
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
            completion ( Timeline ( entries: await getEntry ( ), policy: .atEnd ) )
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let feast: FeastData
    let loading: Bool
    let alternative: Bool
}

struct SystemWidget : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text ( entry.feast.title )
                .padding ( [ .bottom ], 1 )
                .font ( .system ( size: 15 ) )
                .redacted ( reason: entry.loading ? .placeholder : [ ] )
            if entry.alternative {
                Text ( "Alternatives Available" )
                    .italic ( )
                    .padding ( [ .bottom ], 1 )
            }
            Text ( "Class \( entry.feast.rank )" )
                .padding ( [ .bottom ], 1 )
            Text ( .now, style: .date )
        }
            .font ( .system ( size: 12 ) )
            .padding ( )
            .frame ( maxWidth: .infinity, maxHeight: .infinity )
            .bold ( )
            .multilineTextAlignment ( .center )
            .foregroundColor ( entry.feast.colors.components ( separatedBy: "," ) [ 0 ] == "b" ? .white : .black )
            .background ( Color ( word: entry.feast.colors.components ( separatedBy: "," ) [ 0 ] ) )
    }
}

struct RectangularWidgetView : View {
    var entry: Provider.Entry

    var body: some View {
        Text ( "\(entry.feast.title) (Class \(entry.feast.rank))" )
            .font ( .system ( size: 15 ) )
            .redacted ( reason: entry.loading ? .placeholder : [ ] )
            .multilineTextAlignment ( .center )
            .bold ( )
    }
}

struct InlineWidgetView : View {
    var entry: Provider.Entry

    var body: some View {
        Text ( entry.feast.title )
            .redacted ( reason: entry.loading ? .placeholder : [ ] )
            .bold ( )
            .multilineTextAlignment ( .center )
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
