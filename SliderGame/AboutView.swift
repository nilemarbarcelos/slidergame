//
//  AboutView.swift
//  SliderGame
//
//  Created by Nilemar de Barcelos on 24/10/2019.
//  Copyright © 2019 Nilemar Barcelos. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 255 / 255.0, green: 214 / 255.0, blue: 179 / 255.0)
    
    struct headingStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.bottom, 20)
                .padding(.top, 20)
        }
    }
    
    struct textStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(headingStyle())
                Text("This is Bullseye, the game where you can win points by dragging a slider").modifier(textStyle())
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam accumsan auctor imperdiet. Lorem ipsum dolor sit amet, consectetur adipiscing elit.").modifier(textStyle())
                Text("Enjoy").modifier(textStyle())
            }.navigationBarTitle("About Bullseye")
            .background(beige)
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
