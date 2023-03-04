//
//  ContentView.swift
//  GetMotionData Watch App
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var connector = PhoneConnector()
    @ObservedObject var outputMotionData = OutputMotionData()
    let manager = MotionDataFileManager()
    var body: some View {
        VStack {
            self.outputMotionData.isStarted ?
            Text("Getting your motion data...")
                .font(.title3)
                .foregroundColor(.orange)
                .bold():
            Text("Try to get your motion data!!")
                .font(.title3)
                .foregroundColor(.orange)
                .bold()
            Button(action: {
                self.outputMotionData.isStarted ? self.outputMotionData.stop() : self.outputMotionData.start()
            }) {
                self.outputMotionData.isStarted ? Text("STOP") : Text("START")
            }
            Button(action: {
                manager.removeAllFile(dirPath: manager.getTmpPath())
            }) {
                Text("REMOVE ALL FILE")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
