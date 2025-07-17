//
//  AdditionalMassPropers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct AdditionalMassPropers: View {
    @EnvironmentObject var activeData: ActiveData

    var body: some View {
        List {
            ForEach(activeData.votives ?? [], id: \.id) { info in
                if let days = info.days {
                    VotiveDays ( days: days )
                } else if let masses = info.masses {
                    Section(header: Text(info.title), footer: Text("")) {
                        VotiveMasses ( votives: masses )
                    }
                }
            }
        }
        .listRowSpacing(0)
    }
}

struct VotiveMasses: View {
    @Environment(\.colorScheme) var colorScheme
    let votives: [ Masses ]
    
    var body: some View {
        ForEach(votives, id: \.id) { mass in
            NavigationLink {
                let celeb = CelebrationData(rank: mass.rank, title: mass.title, colors: mass.colors, propers: mass.propers.map { x in
                    return PropersData ( title: x.title, english: x.english, latin: x.latin )
                }, commemorations: [])
                DisplayPropers(celebrations: [celeb])
            } label: {
                MassRow(key: mass.title, colorsString: mass.colors, colorScheme: colorScheme)
            }
        }
    }
}

struct VotiveDays: View {
    let days: [ DayGroup ]

    var body: some View {
        ForEach(days, id: \.self) { day in
            Section(header: Text(day.day == "Monday" ? "The Most Fitting Votive Masses for Particular Days of the Week" : ""), footer: Text(day.day)) {
                VotiveMasses(votives: day.votives)
            }
        }
    }
}

struct MassRow: View {
    let key: String
    let colorsString: String
    let colorScheme: ColorScheme

    var body: some View {
        HStack {
            Text(key)
            let colors = colorsString.components(separatedBy: ",")
            ForEach(colors, id: \.self) { colorName in
                Circle()
                    .strokeBorder(colorScheme == .dark ? .white : .black, lineWidth: 1)
                    .background(
                        Circle()
                            .foregroundColor(Color(word: colorName))
                    )
                    .frame(width: 15, height: 15)
            }
        }
    }
}
