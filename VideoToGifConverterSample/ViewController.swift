//
//  ViewController.swift
//  VideoToGifConverterSample
//
//  Created by Manish Kumar on 20/11/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import UIKit
import MobileCoreServices
import Regift
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func chooseVideoButtonClicked(_ sender: UIButton) {
        
        presentImagePickerActionSheet()
    }
    

}

//MARK: - IMAGE PICKER CONTROLLER HELPERS
extension ViewController {
    
    fileprivate func presentImagePickerActionSheet() {
        // Presenting the Cameta Action Sheet
        let actionSheetController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let photoLibraryButton = UIAlertAction(title: "Video Library", style: .default) { (action) in
            self.didReceiveTapOnPhotoLibraryButton()
            
        }
        let takePhotoButton = UIAlertAction(title: "Take Video", style: .default) { (action) in
            self.didReceiveTapOnTakePhotoButton()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        actionSheetController.addAction(photoLibraryButton)
        actionSheetController.addAction(takePhotoButton)
        actionSheetController.addAction(cancelButton)
        for action in actionSheetController.actions {
            action.setValue(UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0), forKey: "titleTextColor")
        }
        self.present(actionSheetController, animated: true) {
            
        }
        
    }
    
    // MARK: - Profile Picture Hanlders
    func didReceiveTapOnPhotoLibraryButton(){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            UINavigationBar.appearance().tintColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
        }
        
    }
    func didReceiveTapOnTakePhotoButton(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            UINavigationBar.appearance().tintColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
        }
    }
}
//MARK: - IMAGE PICKER CONTROLLER DELEGATE
extension ViewController: UIImagePickerControllerDelegate {
    
    //MARK: Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenVideo = info[UIImagePickerControllerMediaType] as! CFString
        
        // Handle a movie capture
        if (CFStringCompare (chosenVideo, kUTTypeMovie, CFStringCompareFlags(rawValue: 0)) == CFComparisonResult.compareEqualTo)
        {
            self.dismiss(animated: true, completion: nil)
            let moviePath = (info[UIImagePickerControllerMediaURL] as! NSURL).path
            
            
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath!))
            {
               print("compatible")
                print("movie Path : \(String(describing: (info[UIImagePickerControllerMediaURL] as! NSURL).path))")
                createGIFWithVideoAtPath(path: moviePath!)
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil) //5

    }
    
    

}

extension ViewController: UINavigationControllerDelegate {

}

extension ViewController{
    
    func createGIFWithVideoAtPath(path: String){
        
        let frameCount = 120
        let delayTime  = Float(0.2)
        let urlPath = URL(fileURLWithPath: path)

        Regift.createGIFFromSource(urlPath, frameCount: frameCount, delayTime: delayTime) { (result)
            in
            print("Gif saved to \(String(describing: result))")
            
            let gifData = NSData.init(contentsOfFile: result!.path)
            let library = PHPhotoLibrary.shared()
            let auth = PHPhotoLibrary.authorizationStatus()
            
            if auth == PHAuthorizationStatus.authorized{
                print("auth : \(auth)")
                //save data
                library.performChanges({
                    let options = PHAssetResourceCreationOptions()
                    PHAssetCreationRequest.forAsset().addResource(with: PHAssetResourceType.photo, data: gifData! as Data, options: options)
                }, completionHandler: { (success, error) in
                    print("success : \(success)")
                    
                    let alert =  UIAlertController(title: "Success", message: "GIF saved to device", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                })
            }else{
                PHPhotoLibrary.requestAuthorization({ (status) in
                    print("status : \(status)")
                })
            }

        }

    }
}
