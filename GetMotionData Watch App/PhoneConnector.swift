//
//  PhoneConnector.swift
//  GetMotionData Watch App
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import UIKit
import WatchConnectivity

class PhoneConnector: NSObject, ObservableObject, WCSessionDelegate {
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state= \(activationState.rawValue)")
    }
    
    func send(filePath: URL?) {
        if let path = filePath {
            print("send = \(path)")
            WCSession.default.transferFile(path, metadata: nil)
        }
    }
}
