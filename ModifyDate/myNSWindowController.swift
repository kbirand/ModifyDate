//
//  myNSWindowController.swift
//  ModifyDate
//
//  Created by Koray Birand on 19.08.2018.
//  Copyright © 2018 Koray Birand. All rights reserved.
//

import Cocoa

class myNSWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        //applyButton.bac = NSColor.green.cgColor
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    @IBOutlet weak var applyButton: NSButton!
    
    @IBAction func apply(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("NotificationApply"), object: nil)
    }
    
    @IBAction func target(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("NotificationTarget"), object: nil)
    }
    
    @IBAction func source(_ sender: Any) {
       NotificationCenter.default.post(name: Notification.Name("NotificationSource"), object: nil)
    }
    
}
