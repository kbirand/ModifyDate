//
//  ViewController.swift
//  ModifyDate
//
//  Created by Koray Birand on 19.08.2018.
//  Copyright © 2018 Koray Birand. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    
    
    var cPath : URL!
    var tPath : URL!
    var attributes : [String]!
    var csvContent : [[String]]!
    var targetFiles : [[String]]!
    var csvContentNew = [[String:String]]()
    var targetFilesNew = [[String:String]]()
    
    @IBOutlet weak var csvCount: NSTextField!
    @IBOutlet weak var csvPath: NSTextField!
    @IBOutlet weak var targetCount: NSTextField!
    @IBOutlet weak var targetPath: NSTextField!
    @IBOutlet weak var tableViewSource: NSTableView!
    @IBOutlet weak var tableViewTarget: NSTableView!
    
    
    @IBAction func applyAttribs(_ sender: Any) {
        if csvCount.stringValue == targetCount.stringValue {
            
            for index in 0...targetFiles.count-1 {
                print(csvContent[index][2])
                print(targetFiles[index][1])
                koray.changeDate(newDate: csvContent[index][2], filePath: targetFiles[index][1])
            }
            
            self.targetFiles = (koray.listFolderFilteredWithDate(urlPath: self.tPath, filterExt: "mp4"))
            self.targetCount.stringValue = self.targetFiles.count.description
            self.fillTargetArrayController()
            
        }
        
    }
    
    
    @IBAction func selectCSV(_ sender: Any) {
        
        if let url = NSOpenPanel().selectUrl {
            self.cPath = url
            self.csvPath.stringValue  = self.cPath.path
            self.csvContent = (koray.listFolderFilteredWithDate(urlPath: self.cPath, filterExt: "mp4"))
            self.csvCount.stringValue = self.csvContent.count.description
            self.fillSourceArrayController()
        }
        
        
    }
    
    
    @IBAction func selectTarget(_ sender: Any) {
        if let url = NSOpenPanel().selectUrl {
            self.tPath = url
            self.targetPath.stringValue  = self.tPath.path
            self.targetFiles = (koray.listFolderFilteredWithDate(urlPath: self.tPath, filterExt: "mp4"))
            self.targetCount.stringValue = self.targetFiles.count.description
            self.fillTargetArrayController()
        }
    }
    
    
    func fillSourceArrayController() {
        csvContentNew.removeAll()
        
        for index in csvContent {
            csvContentNew.append(["filename" : index[0] , "filepath" : index[1] , "filedate" : index[2]])
        }
        self.tableViewSource.reloadData()
    }
    
    func fillTargetArrayController() {
        targetFilesNew.removeAll()
        
        for index in targetFiles {
            targetFilesNew.append(["filename" : index[0] , "filepath" : index[1] , "filedate" : index[2]])
        }
        self.tableViewTarget.reloadData()
    }
    
    @objc func methodOfReceivedNotificationSource(notification: Notification){
        
        if let url = NSOpenPanel().selectUrl {
            self.cPath = url
            self.csvPath.stringValue  = self.cPath.path
            self.csvContent = (koray.listFolderFilteredWithDate(urlPath: self.cPath, filterExt: "mp4"))
            self.csvCount.stringValue = self.csvContent.count.description
            self.fillSourceArrayController()
        }
        
    }
    
    @objc func methodOfReceivedNotificationTarget(notification: Notification){
        
        if let url = NSOpenPanel().selectUrl {
            self.tPath = url
            self.targetPath.stringValue  = self.tPath.path
            self.targetFiles = (koray.listFolderFilteredWithDate(urlPath: self.tPath, filterExt: "mp4"))
            self.targetCount.stringValue = self.targetFiles.count.description
            self.fillTargetArrayController()
        }
        
    }
    
    @objc func methodOfReceivedNotificationApply(notification: Notification){
        
        if csvCount.stringValue == targetCount.stringValue {
            
            for index in 0...targetFiles.count-1 {
                print(csvContent[index][2])
                print(targetFiles[index][1])
                koray.changeDate(newDate: csvContent[index][2], filePath: targetFiles[index][1])
            }
            
            self.targetFiles = (koray.listFolderFilteredWithDate(urlPath: self.tPath, filterExt: "mp4"))
            self.targetCount.stringValue = self.targetFiles.count.description
            self.fillTargetArrayController()
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSource.delegate = self
        self.tableViewSource.dataSource = self
        self.tableViewSource.reloadData()
        self.tableViewTarget.delegate = self
        self.tableViewTarget.dataSource = self
        self.tableViewTarget.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationSource(notification:)), name: Notification.Name("NotificationSource"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationTarget(notification:)), name: Notification.Name("NotificationTarget"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationApply(notification:)), name: Notification.Name("NotificationApply"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

