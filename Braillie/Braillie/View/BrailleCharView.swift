//
//  BrailleCharView.swift
//  Braillie
//
//  Created by Yu Ho Kwok on 23/3/2023.
//

import SwiftUI


/// A view that show a single braille character
struct BrailleCharView: View {
    
    //this braile article
    @Binding var article : BraillArticle
    //present crash
    var position : Int
    //the braille character to display
    @Binding var character : BrailleCharacter
    //the braille mode - display or experience
    var mode : BrailleView.Mode
    //scale of the braille tile
    var scale = 1.0
    
    @EnvironmentObject var brailleDisplay: BrailleDisplay
    
    var body: some View {
        ZStack {

            if mode == .display {

                HStack(spacing:5 * scale){
                    ForEach(0...1, id:\.self) {
                        i in
                        VStack(spacing: 0) {
                            ForEach(0...2, id:\.self) {
                                j in
                                
                                let index = i * 3 + (j)
                                
                                if brailleDisplay.displayLevel >= 1 {
                                    Circle()
                                        .fill(character.dots[index] == 1 ? .black : .clear)
                                        .frame(width: 10 * scale)
                                        .padding(5 * scale)
                                        .opacity(0.0)
                                } else {
                                    Circle()
                                        .fill(character.dots[index] == 1 ? .black : .clear)
                                        .frame(width: 10 * scale)
                                        .padding(5 * scale)
                                        .opacity(character.consumed[0] == 1 ? 0.0 : 0.5)
                                        .animation(.easeOut(duration: 0.5), value: character.consumed[0])
                                }
                            }
                        }
                    }
                }
                .padding()
                .background( character.consumed[0] == 1 ? .gray.opacity(0.05) : .gray.opacity(0.01))
                .animation(.easeOut(duration: 1.0), value: character.consumed[0])
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay (
                    GeometryReader(content: {
                        geometry in
                        Color.clear.onAppear(){
                            character.frames[0] = geometry.frame(in: .global)
                        }
                    })
                )
                
                if brailleDisplay.displayLevel == 0 {
                    Text("\(character.character)")
                        .foregroundColor(.black)
                        .font(Font.system(size: 65 * scale)).fontWeight(.semibold)
                        .opacity(character.consumed[0] == 1 ? 1.0 : 0.0)
                        .padding()
                        .background(.white.opacity(character.consumed[0] == 1 ? 1.0 : 0.0))
                        .animation(.easeOut(duration: 1.0), value: character.consumed[0])
                } else if brailleDisplay.displayLevel >= 1 {
                    Text("\(character.character)")
                }
                
            } else {
                
                if brailleDisplay.displayLevel > 1 {
                    Text("\(character.character)")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 24 * scale))
                }
                
                HStack(spacing:5 * scale){
                    ForEach(0...1, id:\.self) {
                        i in
                        VStack(spacing: 0) {
                            ForEach(0...2, id:\.self) {
                                j in
                                
                                let index = i * 3 + (j)
                                
                                Circle()
                                    .fill(character.dots[index] == 1 ? .black : .clear)
                                    .frame(width: 10 * scale)
                                    .padding(5 * scale)
                                    .overlay (
                                        GeometryReader(content: {
                                            geometry in
                                            Color.clear.onAppear(){
                                                character.frames[index] = geometry.frame(in: .global)
                                            }.onChange(of: article.randomSeed, perform: {
                                                value in
                                                
                                                if position >= article.article.count {
                                                    print("\(position) - \(article.characters.count)")
                                                    return
                                                }
                                                character.frames[index] = geometry.frame(in: .global)
                                                
                                            })
                                        })
                                    )
                            }
                        }
                    }
                }
                .padding()
                .background(.gray.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 10 * scale))
                
            }
        }
    }
}

//struct BrailleCharView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrailleCharView(character: Binding.constant(.T), mode: .display)
//        BrailleCharView(character: Binding.constant(.A), mode: .experience)
//    }
//}
