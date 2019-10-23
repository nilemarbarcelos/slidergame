//
//  ContentView.swift
//  SliderGame
//
//  Created by Nilemar de Barcelos on 22/10/2019.
//  Copyright © 2019 Nilemar Barcelos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0 / 255.0, green: 51.0 / 255.0, blue: 102 / 255.0)
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.modifier(Shadow())
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
            
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.modifier(Shadow())
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Button(action: {
                self.alertIsVisible = true
                
            }) {
                Text("Hit me").modifier(ButtonLargeTextStyle())
            }.alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded())\n" +
                    "You scored \(pointsForCurrentRound()) points this round"), dismissButton: .default(Text("Awesome")) {
                        self.updateScore()
                        self.target = Int.random(in: 1...100)
                        self.updateRound()
                    })
                }.background(Image("Button")).modifier(Shadow())
            Spacer()
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                    }
                }.background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                Button(action: {}) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                    }
                    
                }.background(Image("Button")).modifier(Shadow())
            }.padding(.bottom, 20)
        }.background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
    }
    
    func updateRound() {
        round += 1
    }
    
    func updateScore() {
        score += pointsForCurrentRound()
    }
    
    func amountOff() -> Int {
        return abs(target - sliderValueRounded())
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        let points = 100 - amountOff()
        let bonus: Int
        
        if points == 100 {
            bonus = 100
        } else if points == 99 {
            bonus = 50
        } else {
            bonus = 0
        }
        
        return points + bonus
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad"
        } else {
            title = "Are you even trying?"
        }
        
        return title
    }
    
    func resetGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
