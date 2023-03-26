//
//  BrailleLabel.swift
//  Braillie
//
//  Created by Yu Ho Kwok on 24/3/2023.
//

import SwiftUI

struct BrailleLabel: View {

    @State var article : BraillArticle

    var mode = BrailleView.Mode.display
    var scale = 0.3
    
    var action : (()->(Void))
    
    var body: some View {
        BrailleView(article:$article, mode: mode, scale: scale)
            .background(.gray.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
