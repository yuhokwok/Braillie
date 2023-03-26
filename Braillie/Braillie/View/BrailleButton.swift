//
//  BrailleView.swift
//  Braillie
//
//  Created by Yu Ho Kwok on 23/3/2023.
//

import SwiftUI

struct BrailleButton: View {

    @State var article : BraillArticle
    
    var mode = BrailleView.Mode.display
    var scale = 0.3
    
    var action : (()->(Void))
    
    var body: some View {
        
        ZStack {
            BrailleView(article:$article, mode: mode, scale: scale)
                .background(.gray.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 15))
        }.onTapGesture(count:2) {
            action()
        }
        
    }
}
