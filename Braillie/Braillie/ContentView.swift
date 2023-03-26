//
//  ContentView.swift
//  Braillie
//
//  Created by Yu Ho Kwok on 23/3/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var brailleDisplay = BrailleDisplay()
    
    @State var brailleArticle = BraillArticle(string: "WWDC23")
    
    @State var brailly = BraillArticle(string: "Brailly")
    
    var intro = "Stay hungry, Stay Foolish. Steve Jobs"
    
    @State var isEnter = false
    
    @State var selection = 0
    var body: some View {
        
        ZStack {
            VStack (alignment: .center) {
                
                if isEnter == true {
                    BrailleGridView(article: intro.braille, mode: .display, scale: 0.5, gridItemLayout: [GridItem(.adaptive(minimum: 100 * 0.5))])
                } else {
                    VStack (alignment: .center) {
                        BrailleView(article: $brailleArticle)
                    }
                    TextField("Braille", text: $brailleArticle.article)
                        .foregroundColor(.gray)
                        .font(Font.system(size: 40))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                
                
                BrailleButton(article: "Click".braille,
                              scale: 0.3,
                              action: {
                    isEnter.toggle()
                })

            }
            
            VStack {
                Spacer()
                Image(systemName: "hand.point.up.braille")
                    .font(Font.system(size: 18))
                    .padding(5)
                Text("Drag slowly on the braille text to reveal the message  | Double Tap to click the button")
                    .font(Font.system(size: 12))
                    .padding(5)
                HStack {
                    Text("Select Display Mode: ").font(Font.system(size: 12))
                    Picker("Display Mode", selection: $brailleDisplay.displayLevel) {
                        Text("⠃⠗⠁⠊⠇⠇⠑").tag(0).font(Font.system(size: 12))
                        Text("Semi - ⠃⠗⠁⠊⠇⠇⠑").tag(1).font(Font.system(size: 12))
                        Text("Full Text").tag(2).font(Font.system(size: 12))
                    }.font(Font.system(size: 12))
                }
            }
        }.environmentObject(brailleDisplay)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
