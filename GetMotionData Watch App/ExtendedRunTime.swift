//
//  ExtendedRunTime.swift
//  GetMotionData Watch App
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import SwiftUI

class ExtendedRunTime: NSObject, WKExtendedRuntimeSessionDelegate {
    
    static let shared = ExtendedRunTime()
    
    var session: WKExtendedRuntimeSession
    
    override init() {
        
        // Create the session object.
        session = WKExtendedRuntimeSession()
        
        super.init()

        // Assign the delegate.
        session.delegate = self
    }
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("didInvalidateWithReason: \(reason)")
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("extendedRuntimeSessionDidStart")
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("extendedRuntimeSessionWillExpire")
    }
    
    func start() {
        session = WKExtendedRuntimeSession()
        session.delegate = self
        session.start()
    }
    
    func stop() {
        session.invalidate()
    }
}
