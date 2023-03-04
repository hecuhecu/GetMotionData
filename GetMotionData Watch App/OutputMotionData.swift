//
//  OutputMotionData.swift
//  GetMotionData Watch App
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import CoreMotion

class OutputMotionData: NSObject, ObservableObject {
    
    @Published var isStarted = false
    let manager = MotionDataFileManager()
        
    let motionManager = CMMotionManager()
    
    func start() {
        manager.open(manager.makeFilePath())
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1/200
            ExtendedRunTime.shared.start()
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.writeMotionData(deviceMotion: motion!)
            })
        }
        isStarted = true
    }
    
    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
        ExtendedRunTime.shared.stop()
        manager.close()
    }
    
    private func writeMotionData(deviceMotion:CMDeviceMotion) {
        manager.write(deviceMotion)
    }
}
