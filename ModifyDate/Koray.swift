//
//  Koray.swift
//  Koray Birand Archive
//
//  Created by Koray Birand on 11/02/16.
//  Copyright © 2016 rock. All rights reserved.
//

import Foundation


class koray {
    
    
    
    class func leftString(_ theString: String, charToGet: Int) ->String{
        
        var indexCount = 0
        let strLen = theString.count
        
        if charToGet > strLen { indexCount = strLen } else { indexCount = charToGet }
        if charToGet < 0 { indexCount = 0 }
        
        let index: String.Index = theString.index(theString.startIndex, offsetBy: indexCount)
        let mySubstring:String = String(theString[..<index])
        return mySubstring }
    
    class func rightString(_ theString: String, charToGet: Int) ->String{
        
        var indexCount = 0
        let strLen = theString.count
        let charToSkip = strLen - charToGet
        
        if charToSkip > strLen { indexCount = strLen } else { indexCount = charToSkip }
        if charToSkip < 0 { indexCount = 0 }
        let index: String.Index = theString.index(theString.startIndex, offsetBy: indexCount)
        let mySubstring:String = String(theString[index...])
        
        
        return mySubstring
    }
    
    class func midString(_ theString: String, startPos: Int, charToGet: Int) ->String{
        
        let strLen = theString.count
        let rightCharCount = strLen - startPos
        var mySubstring = koray.rightString(theString, charToGet: rightCharCount)
        mySubstring = koray.leftString(mySubstring, charToGet: charToGet)
        return mySubstring
        
    }
    
    class func splitToArray ( theString: String) -> [[String]] {
        var newArray = [[String]]()
        let a = theString.components(separatedBy: "\n")
        for elements in a  {
            let c = elements.components(separatedBy: ",")
            newArray.append(c)
        }
        
        return newArray
        
    }
    

    
    class func listFolderFiltered (urlPath: URL, filterExt: String) -> [String] {
        var newArray = [String]()
        
        let fm = FileManager.default
        do {
            let items = try fm.contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            
            for item in items {
                
                if item.pathExtension.lowercased() == filterExt  {
                    newArray.append(item.path)
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        
        let ascending = newArray.sorted { (a, b) -> Bool in
            return b > a
        }
        
        
        return ascending
    }
    
    class func listFolderFilteredWithDate(urlPath: URL, filterExt: String) -> [[String]] {
        var newArray = [[String]]()
        var attribs = [FileAttributeKey : Any]()
        
        
        let fm = FileManager.default
        do {
            let items = try fm.contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            
            for item in items {
                
                if item.pathExtension.lowercased() == filterExt  {
                    //print(item.path)
                    do {
                        attribs = try FileManager.default.attributesOfItem(atPath: item.path)
//                        print(attribs)
                    }
                    catch
                    {
                        print(error)
                    }
                    newArray.append([item.lastPathComponent,item.path,(attribs[FileAttributeKey.creationDate] as! NSDate).description])
                }
            }
        } catch {
           
        }
        
        let ascending = newArray.sorted { $0[0] < $1[0] }
        
        
        return ascending
    }
    
    
    
    class func getCsvContent(myPath: String) -> [[String]] {
        
        var array : [[String]]!
        
        do {
            let koko = try String(contentsOfFile: myPath)
            array = koray.splitToArray(theString: koko)
            
        }
        catch {}
        
        return array
        
    }
    
    class func changeDate(newDate: String, filePath: String) {
        
        let convertedDate = koray.convertDate(stringDate: newDate)
        print("convertedDate\(convertedDate)")
        
        let attributes = [FileAttributeKey.creationDate: convertedDate]
        let attributes2 = [FileAttributeKey.modificationDate: convertedDate]
        do {
            try FileManager.default.setAttributes(attributes as Any as! [FileAttributeKey : Any], ofItemAtPath: filePath)
        }
        catch
        {
            print(error)
        }
        
        do {
            try FileManager.default.setAttributes(attributes2 as Any as! [FileAttributeKey : Any], ofItemAtPath: filePath)
        }
        catch
        {
            print(error)
        }
     
        
    }
    
    class func convertDate (stringDate: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xx"
        guard let datem = dateFormatter.date(from: stringDate) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        return datem
    }
    
    
    
    
    
}

