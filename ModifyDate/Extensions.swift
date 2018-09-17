//
//  Extensions.swift
//  ModifyDate
//
//  Created by Koray Birand on 19.08.2018.
//  Copyright © 2018 Koray Birand. All rights reserved.
//

import Cocoa

extension NSOpenPanel {
    var selectUrl: URL? {
        title = "Select Folder"
        allowsMultipleSelection = false
        canChooseDirectories = true
        canChooseFiles = false
        canCreateDirectories = true
        allowedFileTypes = ["mov","mp4"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls.first : nil
    }
}




extension ViewController:NSTableViewDataSource, NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
//        let myIdentity = (notification.object as! NSTableView).identifier
       var counter:Int?
        if tableView == self.tableViewSource {
            counter = csvContentNew.count
        }
        if tableView == self.tableViewTarget {
            counter = targetFilesNew.count
        }
        return counter!
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        var result = NSTableCellView()
        
        if tableView == self.tableViewSource {
        
        result  = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
        result.textField?.stringValue = csvContentNew[row][(tableColumn?.identifier.rawValue)!]!
        }
        
        if tableView == self.tableViewTarget {
            
            result  = tableView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self) as! NSTableCellView
            result.textField?.stringValue = targetFilesNew[row][(tableColumn?.identifier.rawValue)!]!
        }
        return result
    }
    
}
