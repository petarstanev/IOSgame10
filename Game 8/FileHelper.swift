//
//  FileHelper.swift
//  Game 8
//
//  Created by Petar Stanev on 01/05/2018.
//  Copyright © 2018 Petar Stanev. All rights reserved.
//

import Foundation

class FileHelper {
    
    
    //let file = "file.txt" //this is the file. we will write to and read from it
    
    //let text = "some text" //just a text
    
    
    
    func read(fileName:String) -> String {
        var text:String = ""
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            
            //reading
            do {
                text = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                print("Reading error: \(error).")
            }
        }
        return text
    }
    
    func write(fileName:String, text:String){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileName)
            
            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("Writing error: \(error).")
            }
        }
    }
    
    
}
