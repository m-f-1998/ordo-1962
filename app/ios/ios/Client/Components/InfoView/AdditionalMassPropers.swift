//
//  AdditionalMassPropers.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 28/01/2024.
//

import SwiftUI

struct AdditionalMassPropers: View {
    @Environment(ActiveData.self) var activeData

    var body: some View {
        ScrollView ( .vertical, showsIndicators: false ) {
            VStack ( spacing: 8 ) {
                ForEach(activeData.votives ?? [], id: \.id) { info in
                    if let days = info.days {
                        VotiveDays ( days: days )
                    } else if let masses = info.masses {
                        SectionHeader ( title: info.title )
                        VotiveMasses ( votives: masses )
                    }
                }
            }
            .padding ( .top, 16 )
            .padding ( .bottom, 40 )
        }
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text ( title.uppercased ( ) )
            .font ( .system ( size: 13, weight: .bold, design: .serif ) )
            .foregroundStyle ( .red )
            .tracking ( 1.2 )
            .frame ( maxWidth: .infinity, alignment: .leading )
            .padding ( .horizontal, 16 )
            .padding ( .top, 14 )
    }
}

struct VotiveMasses: View {
    let votives: [ Masses ]
    
    var body: some View {
        ForEach(votives, id: \.id) { mass in
            NavigationLink {
                let celeb = CelebrationData(rank: mass.rank, title: mass.title, colors: mass.colors, propers: mass.propers.map { x in
                    return PropersData ( title: x.title, english: x.english, latin: x.latin )
                }, commemorations: [])
                DisplayPropers(celebrations: [celeb])
            } label: {
                SleekVotiveRow ( mass: mass )
            }
            .buttonStyle ( .plain )
        }
    }
}

struct SleekVotiveRow: View {
    let mass: Masses

    var body: some View {
        VStack ( alignment: .leading, spacing: 8 ) {
            HStack {
                Text ( "CLASS \(mass.rank)" )
                    .font ( .system ( size: 10, weight: .bold, design: .serif ) )
                    .foregroundStyle ( Color ( red: 0.65, green: 0.08, blue: 0.08 ) )
                    .tracking ( 1.2 )
                
                Spacer ( )
                
                // Color Indicators
                let colors = mass.colors.components ( separatedBy: "," )
                HStack ( spacing: 4 ) {
                    ForEach ( colors, id: \.self ) { colorName in
                        Circle ( )
                            .strokeBorder ( .primary.opacity ( 0.3 ), lineWidth: 1 )
                            .background (
                                Circle ( )
                                    .foregroundStyle ( Color ( word: colorName ) ?? .white )
                            )
                            .frame ( width: 12, height: 12 )
                    }
                }
            }
            .padding ( .top, 14 )
            .padding ( .horizontal, 16 )
            
            Divider ( )
                .background ( Color ( red: 0.65, green: 0.08, blue: 0.08 ).opacity ( 0.15 ) )
                .padding ( .horizontal, 16 )
            
            Text ( mass.title )
                .font ( .system ( size: 14, weight: .semibold, design: .serif ) )
                .foregroundStyle ( .primary )
                .multilineTextAlignment ( .leading )
                .padding ( .horizontal, 16 )
                .padding ( .bottom, 14 )
        }
        .frame ( maxWidth: .infinity, alignment: .leading )
        .background ( Color ( .secondarySystemBackground ) )
        .clipShape ( RoundedRectangle ( cornerRadius: 16 ) )
        .padding ( .horizontal, 16 )
        .padding ( .vertical, 6 )
    }
}

struct VotiveDays: View {
    let days: [ DayGroup ]

    var body: some View {
        ForEach(days, id: \.self) { day in
            SectionHeader ( title: day.day )
            VotiveMasses(votives: day.votives)
        }
    }
}
