//
//  ContentView.swift
//  intervalTimer
//
//  Created by Thomas Wong on 3/19/22.
//

import SwiftUI
import AVFoundation

func speak(word: String) -> Void {
    let utterance = AVSpeechUtterance(string: word)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.rate = 0.3
    
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
}

struct ContentView: View {
    @State private var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showStart = true
    @State private var startTimer = false
    
    var body: some View {
        VStack {
            if showStart {
                Button(role: .destructive) {
                    timeRemaining = 10
                    showStart = false
                    startTimer = true
                } label: {
                    Text("Start").font(.system(size: 40)).fontWeight(.bold).foregroundColor(Color.blue)
                }.buttonStyle(.borderedProminent)
            } else {
                Button(role: .destructive) {
                    timeRemaining = 10
                    showStart = true
                    startTimer = false
                } label: {
                    Text("Stop").font(.system(size: 40)).fontWeight(.bold).foregroundColor(Color.blue)
                }.buttonStyle(.borderedProminent)
                
                HStack(spacing: 16) {
                    Text("\(timeRemaining)").font(.system(size: 80)).fontWeight(.bold)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                                
                                
                                if (timeRemaining > 3 && timeRemaining < 7) {
                                    speak(word: String(timeRemaining - 3))
                                } else if (timeRemaining > 0 && timeRemaining < 3) {
                                    speak(word: String(timeRemaining))
                                } else if timeRemaining == 3 {
                                    speak(word: "Down")
                                } else if timeRemaining == 0 {
                                    speak(word: "Up")
                                }
                                
                                if timeRemaining == 0 {
                                    timeRemaining = 10
                                }
                            }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
