//
//  macViewController.swift
//  VideoToGifConverterMacApp
//
//  Created by Manish Kumar on 22/11/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import Cocoa
import Regift


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
//            let library = PHPhotoLibrary.shared()
//            let auth = PHPhotoLibrary.authorizationStatus()
            
//            if auth == PHAuthorizationStatus.authorized{
//                print("auth : \(auth)")
//                //save data
//                library.performChanges({
//                    let options = PHAssetResourceCreationOptions()
//                    PHAssetCreationRequest.forAsset().addResource(with: PHAssetResourceType.photo, data: gifData! as Data, options: options)
//                }, completionHandler: { (success, error) in
//                    print("success : \(success)")
//
//                    let alert =  UIAlertController(title: "Success", message: "GIF saved to device", preferredStyle: UIAlertControllerStyle.alert)
//
//                    let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil)
//                    alert.addAction(ok)
//                    self.present(alert, animated: true, completion: nil)
//                })
//            }else{
//                PHPhotoLibrary.requestAuthorization({ (status) in
//                    print("status : \(status)")
//                })
//            }
            
        }

    }
}
