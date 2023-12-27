//
//  TextDisplay.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 26/07/2023.
//

import SwiftUI

struct DisplayText: View {
    var text: String
    var display_ordo_info: Bool = false
    var ordo_info = """
    **External Solemnities**
    Feasts are not transferred in the 1962 Missal unlike the Ordinary Form of the Roman Liturgy; it is obligatory to celebrate both the Mass and Divine Office on the traditional days. The “external solemnity” is a pastoral provision which may be made, but is not obligatory, in cases where a reasonable number of the faithful are unable to attend the feast on the day itself.

    There are only two feasts to which an external solemnity is automatically granted, those of the Sacred Heart and the Holy Rosary.

    **Feasts In Certain Locations**
    Certain feasts may have a higher rank or exist only in a particular country, diocese or congregation. Examples include the Dedication of a Cathedral or the Mass of a Patron Saint. These will appear as geographical data is added however they will not appear by default in the Universal Calendar.

    **Neo-Galacian Prefaces**
    The "Neo-Galacian" prefaces are taken from 17th century French Altar Missals, though the texts themselves are far more ancient. They were, once, proper to France and have slowly become incorporated into the Roman Rite.
    
    Some are dead set against their use, however, in new editions of the 1962 Missale Romanum they are included. They are “ad libitum”, which means that the priest can choose whether to use them. The "Neo-Galacian" prefaces are shown by default in this app and the alternative is listed in the options for the days feast.
    """

    var body: some View {
        GeometryReader { proxy in
            ScrollView ( .vertical, showsIndicators: false ) {
                Text ( try! AttributedString ( markdown: "\n" + ( self.display_ordo_info ? self.ordo_info : self.text ) + "\n", options: .init ( interpretedSyntax: .inlineOnlyPreservingWhitespace ) ) )
                    .lineSpacing ( 10 )
                    .font ( .system ( .body, design: .monospaced ) )
                    .frame(minHeight: proxy.size.height)
            }
                .multilineTextAlignment ( .center )
                .frame ( maxWidth: .infinity, maxHeight: proxy.size.height )
        }
            .navigationBarTitleDisplayMode ( .inline )
            .padding ( [ .leading, .trailing ], 15 )
    }
}
