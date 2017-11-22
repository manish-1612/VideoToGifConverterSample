//
//  macViewController.swift
//  VideoToGifConverterMacApp
//
//  Created by Manish Kumar on 22/11/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import Cocoa

class macViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func chooseFileButtonClicked(_ sender: NSButton) {
        
//        var _: Int = 0
//        // Loop counter.
//        // Create the File Open Dialog class.
//        let openDlg = NSOpenPanel()
//        // Enable the selection of files in the dialog.
//        openDlg.canChooseFiles = true
//        // Enable the selection of directories in the dialog.
//        openDlg.canChooseDirectories = true
//        // Display the dialog.  If the OK button was pressed,
//        // process the files.
//        if openDlg.runModal().rawValue == NSApplication.ModalResponse.OK.rawValue {
//            // Get an array containing the full filenames of all
//            // files and directories selected.
//            var files = openDlg.file
//            // Loop through all the files and process them.
//            for i in 0..<files.count {
//                var fileName = files[i] as? String
//                // Do something with the filename.
//            }
//        }
        
        let dialog = NSOpenPanel()
        
        dialog.title                   = "Choose a video file"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = true
        dialog.canChooseDirectories    = true
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes        = ["mp4","mov"]
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                print("path: \(path)")
            }
        } else {
            // User clicked on "Cancel"
            return
        }

    }
    
}
