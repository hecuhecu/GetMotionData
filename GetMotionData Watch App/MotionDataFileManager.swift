//
//  MotionDataFileManager.swift
//  GetMotionData Watch App
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import CoreMotion

class MotionDataFileManager {
    let connector = PhoneConnector()
    
    var file: FileHandle?
    var filePath: URL?
    var sample: Int = 0
    var fileCount: Int = 0
    
    func open(_ filePath: URL) {
        do {
            FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
            let file = try FileHandle(forWritingTo: filePath)
            var header = ""
            header += "acceleration_x,"
            header += "acceleration_y,"
            header += "acceleration_z,"
            header += "attitude_pitch,"
            header += "attitude_roll,"
            header += "attitude_yaw,"
            header += "gravity_x,"
            header += "gravity_y,"
            header += "gravity_z,"
            header += "quaternion_x,"
            header += "quaternion_y,"
            header += "quaternion_z,"
            header += "quaternion_w,"
            header += "rotation_x,"
            header += "rotation_y,"
            header += "rotation_z"
            header += "\n"
            file.write(header.data(using: .utf8)!)
            self.file = file
            self.filePath = filePath
        } catch let error {
            print(error)
        }
    }
    
    func write(_ motion: CMDeviceMotion) {
        guard let file = self.file else { return }
        var text = ""
        text += "\(motion.userAcceleration.x),"
        text += "\(motion.userAcceleration.y),"
        text += "\(motion.userAcceleration.z),"
        text += "\(motion.attitude.pitch),"
        text += "\(motion.attitude.roll),"
        text += "\(motion.attitude.yaw),"
        text += "\(motion.gravity.x),"
        text += "\(motion.gravity.y),"
        text += "\(motion.gravity.z),"
        text += "\(motion.attitude.quaternion.x),"
        text += "\(motion.attitude.quaternion.y),"
        text += "\(motion.attitude.quaternion.z),"
        text += "\(motion.attitude.quaternion.w),"
        text += "\(motion.rotationRate.x),"
        text += "\(motion.rotationRate.y),"
        text += "\(motion.rotationRate.z)"
        text += "\n"
        file.write(text.data(using: .utf8)!)
        sample += 1
    }
    
    func close() {
        guard let file = self.file else { return }
        file.closeFile()
        print("\(sample) sample")
        fileCount += 1
        print("\(fileCount) set")
        self.file = nil
        connector.send(filePath: self.filePath)
    }
    
    func getTmpPath() -> URL {
        return FileManager.default.temporaryDirectory
    }
    
    func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func makeFilePath() -> URL {
        let path = getTmpPath()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let filename = formatter.string(from: Date()) + ".csv"
        let filePath = path.appendingPathComponent(filename)
        print(filePath.absoluteURL)
        return filePath
    }
    
    func getAllFilePathInDir(dirPath: URL) -> [URL] {
        var filePaths: [URL] = []
        do {
            filePaths = try FileManager.default.contentsOfDirectory(at: dirPath, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            return filePaths
        } catch let error {
            print(error)
        }
        return filePaths
    }
    
    func removeAllFile(dirPath: URL) {
        let filePaths = getAllFilePathInDir(dirPath: dirPath)
        print(filePaths)
        do {
            for filePath in filePaths {
                try FileManager.default.removeItem(at: filePath)
                print("remove = \(filePath)")
            }
            print("Delete all files")
        } catch let error {
            print(error)
        }
    }}
