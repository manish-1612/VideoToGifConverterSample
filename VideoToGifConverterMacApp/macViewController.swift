//
//  macViewController.swift
//  VideoToGifConverterMacApp
//
//  Created by Manish Kumar on 22/11/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import Cocoa
import Regift
import Photos

class macViewController: NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func chooseFileButtonClicked(_ sender: NSButton) {
        
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
                dialog.close()
                let path = result!.path
                print("path: \(path)")
                createGifFromVideoAtPath(path: path)
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    
    func createGifFromVideoAtPath(path: String){
        
        let frameCount = 120
        let delayTime  = Float(0.2)
        let urlPath = URL(fileURLWithPath: path)

        Regift.createGIFFromSource(urlPath, frameCount: frameCount, delayTime: delayTime) { (result)
            in
            print("Gif saved to \(String(describing: result))")
            
            let gifData = NSData.init(contentsOfFile: result!.path)
            
            let savePanel = NSSavePanel()
            savePanel.showsResizeIndicator    = true
            savePanel.showsHiddenFiles        = true
            savePanel.canCreateDirectories    = true
            
            if (savePanel.runModal() == NSApplication.ModalResponse.OK) {

                let urlToSave = savePanel.url
                
                let fileURL = "\(urlToSave!.path).gif"
                print("file to save at: \(fileURL)")
                gifData?.write(to: NSURL.fileURL(withPath: fileURL), atomically: true)
            } else {

                return
            }
        }
    }
}
