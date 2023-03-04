//
//  ContentView.swift
//  GetMotionData
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var connector = WatchConnector()
    let manager = MotionDataFileManager()
    var body: some View {
        VStack {
            HStack {
                Text("Receiving your motion data...")
            }
            HStack {
                Button(action: {
                    manager.removeAllFile(dirPath: manager.getTmpPath())
                }) {
                    Text("DELETE ALL FILES")
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
