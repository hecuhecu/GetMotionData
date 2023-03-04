//
//  MotionDataFileManager.swift
//  GetMotionData
//
//  Created by Hiroki Kawamura on 2023/03/04.
//

import CoreMotion

class MotionDataFileManager {
    
    func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func getTmpPath() -> URL {
        return FileManager.default.temporaryDirectory
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
    }
}
