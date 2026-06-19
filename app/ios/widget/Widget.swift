//
//  CalendarWidget.swift
//  ordo-1962-widget
//
//  Created by Matthew Frankland on 10/06/2023.
//

import WidgetKit
import SwiftUI

// MARK: - Timeline Provider

struct Provider: TimelineProvider {
    func placeholder ( in context: Context ) -> SimpleEntry {
        SimpleEntry ( date: .now, day: nil )
    }

    func getSnapshot ( in context: Context, completion: @escaping ( SimpleEntry ) -> Void ) {
        Task {
            completion ( SimpleEntry ( date: .now, day: await fetchToday ( ) ) )
        }
    }

    func getTimeline ( in context: Context, completion: @escaping ( Timeline<SimpleEntry> ) -> Void ) {
        Task {
            let day = await fetchToday ( )
            let entry = SimpleEntry ( date: .now, day: day )
            // Refresh at midnight so the widget updates to the new day automatically
            let midnight = Calendar.current.startOfDay ( for: Date ( timeIntervalSinceNow: 86400 ) )
            completion ( Timeline ( entries: [ entry ], policy: .after ( midnight ) ) )
        }
    }

    private func fetchToday ( ) async -> OrdoDay? {
        let activeData = await ActiveData ( )
        let api = API ( activeData: activeData )
        do {
            let current = CurrentYear ( )
            let data = try await api.FetchOrdo ( year: String ( current ) )
            return data.getDay ( month: CurrentMonth ( ), day: CurrentDay ( ) )
        } catch {
            print ( "Widget local fetch failed: \(error)" )
            return nil
        }
    }
}

// MARK: - Entry

struct SimpleEntry: TimelineEntry {
    let date: Date
    let day: OrdoDay?

    var feast: CelebrationData { day?.celebrations.first ?? CelebrationData ( ) }
    var isLoading: Bool { day == nil }
    var theme: LiturgicalTheme { day.map { LiturgicalTheme ( day: $0 ) } ?? LiturgicalTheme ( colors: "g" ) }
}

// MARK: - Widget Views

struct SystemWidgetView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: SimpleEntry

    var body: some View {
        let isLightModeWhite = (colorScheme == .light && entry.theme.isWhite)

        VStack ( alignment: .leading, spacing: 6 ) {
            // Header: Today's date with thin tracked design using liturgical color
            HStack {
                Text ( Date.now.formatted ( .dateTime.weekday ( .abbreviated ).day ( ).month ( .abbreviated ) ).uppercased ( ) )
                    .font ( .system ( size: 10, weight: .bold, design: .serif ) )
                    .foregroundStyle ( isLightModeWhite ? Color.primary : entry.theme.accent )
                    .tracking ( 1.2 )
                Spacer ( )
            }
            
            Divider ( )
                .background ( isLightModeWhite ? Color.secondary.opacity ( 0.25 ) : entry.theme.accent.opacity ( 0.25 ) )
            
            Text ( entry.feast.title )
                .font ( .system ( size: 13, weight: .semibold, design: .serif ) )
                .foregroundStyle ( .primary )
                .lineLimit ( 3 )
                .redacted ( reason: entry.isLoading ? .placeholder : [ ] )
            
            Spacer ( minLength: 0 )
            
            Text ( "CLASS \(entry.feast.rank)" )
                .font ( .system ( size: 10, weight: .bold, design: .serif ) )
                .foregroundStyle ( isLightModeWhite ? Color.primary : entry.theme.accent )
                .redacted ( reason: entry.isLoading ? .placeholder : [ ] )
        }
        .frame ( maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading )
        .padding ( 14 )
        .containerBackground ( isLightModeWhite ? Color.white : entry.theme.accentSubtle, for: .widget )
    }
}

struct RectangularWidgetView: View {
    let entry: SimpleEntry

    var body: some View {
        VStack ( alignment: .leading, spacing: 2 ) {
            Text ( entry.feast.title )
                .font ( .system ( .caption, design: .serif ) )
                .fontWeight ( .semibold )
                .lineLimit ( 2 )
                .redacted ( reason: entry.isLoading ? .placeholder : [ ] )
            Text ( "Class \(entry.feast.rank)" )
                .font ( .caption2 )
                .foregroundStyle ( .secondary )
                .redacted ( reason: entry.isLoading ? .placeholder : [ ] )
        }
        .frame ( maxWidth: .infinity, alignment: .leading )
        .containerBackground ( .clear, for: .widget )
    }
}

struct InlineWidgetView: View {
    let entry: SimpleEntry

    var body: some View {
        Text ( entry.feast.title )
            .font ( .system ( .caption2, design: .serif ) )
            .redacted ( reason: entry.isLoading ? .placeholder : [ ] )
            .containerBackground ( .clear, for: .widget )
    }
}

struct CircularWidgetView: View {
    let entry: SimpleEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground ( )
            VStack ( spacing: 1 ) {
                Text ( entry.feast.title )
                    .font ( .system ( size: 9, design: .serif ) )
                    .fontWeight ( .semibold )
                    .lineLimit ( 3 )
                    .multilineTextAlignment ( .center )
                    .redacted ( reason: entry.isLoading ? .placeholder : [ ] )
            }
            .padding ( 4 )
        }
        .containerBackground ( .clear, for: .widget )
    }
}

// MARK: - Entry Router

struct EntryView: View {
    @Environment( \.widgetFamily ) var family
    let entry: SimpleEntry

    var body: some View {
        switch family {
        case .accessoryRectangular:
            RectangularWidgetView ( entry: entry )
        case .accessoryInline:
            InlineWidgetView ( entry: entry )
        case .accessoryCircular:
            CircularWidgetView ( entry: entry )
        default:
            SystemWidgetView ( entry: entry )
        }
    }
}

// MARK: - Widget Declaration

struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration ( kind: kind, provider: Provider ( ) ) { entry in
            EntryView ( entry: entry )
        }
        .supportedFamilies ( [ .systemSmall, .systemMedium, .accessoryRectangular, .accessoryInline, .accessoryCircular ] )
        .configurationDisplayName ( "Liturgical Calendar" )
        .description ( "Today's feast from the 1962 Roman Rite." )
        .contentMarginsDisabled ( )
    }
}

@main
struct OrdoWidget: WidgetBundle {
    var body: some Widget {
        CalendarWidget ( )
    }
}
