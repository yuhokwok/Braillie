//
//  BrailleView.swift
//  Braillie
//
//  Created by Yu Ho Kwok on 23/3/2023.
//

import SwiftUI

struct BrailleView: View {

    enum Mode {
        case display //no touch for each dot
        case experience //with haptic effect
    }
    
    @Binding var article : BraillArticle
    
    var mode = Mode.experience
    var scale = 1.0
    
    var body: some View {
        
        //LazyVGrid(columns: gridItemLayout) {
            HStack (spacing: 10 * scale) {
                ForEach(0..<article.characters.count, id:\.self) {
                    i in
                    
                    BrailleCharView(article: $article, position: i, character:
                                        $article.characters[i], mode: mode, scale: self.scale)
                }
            }
        //}
        .gesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .global)
                .onChanged {
                    value in
                    
                    article.touch(value.location, for: mode)
                    
                }
                .onEnded{
                    value in
                    
                    article.reset()
                    
                }
        )
        .padding()
    }
}
