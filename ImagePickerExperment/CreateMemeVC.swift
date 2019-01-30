//
//  ViewController.swift
//  ImagePickerExperment
//
//  Created by Afrah kheder on 16/11/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class CreateMemeVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var Toptoolbar: UIToolbar!
    @IBOutlet weak var Bottomtoolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        setTextAttribut(textField: topText, str: " TOP ")
        setTextAttribut(textField: bottomText, str : " BOTTOM ")
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    //viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if imagePickerView.image == nil {
            shareButton.isEnabled = false
        }else {
            shareButton.isEnabled = true
        }
        shareButton.isEnabled = imagePickerView.image != nil
        subscribeToKeyboardNotifications()
       
      
    }
    
    //viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = nil
        return true
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
       if bottomText.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
       }
        
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0.0
        }
      
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(CreateMemeVC.keyboardWillShow(_:))    , name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateMemeVC.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    @IBAction func pickAnImage(_ sender: Any) {
       
        openImagePicker(UIImagePickerController.SourceType.photoLibrary)
    }
    

    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
      
        openImagePicker(UIImagePickerController.SourceType.camera)
     
    }
    
    
    func openImagePicker(_ type: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imagePickerView.image = imagePicker
        }
        
        self.dismiss(animated: true, completion: nil)
      
    }
    
    //text formate
    let memeTextAttributes:[NSAttributedString.Key : Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black/* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white/* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): NSNumber(value: -3.0)/* TODO: fill in appropriate Float */]
    
    
    
    func setTextAttribut(textField : UITextField, str : String) {
        textField.delegate = self
        textField.text = str
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    
    func generateMemedImage() -> UIImage {
        
       
        hideToolbars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        hideToolbars(false)
        
        return memedImage
    }
    
    
    func hideToolbars(_ hide: Bool) {
        Toptoolbar.isHidden = hide
        Bottomtoolbar.isHidden = hide
    }
    
    //save image
    func save() {

        
        let memedImage = generateMemedImage()
        
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
 
    
    //share meme image
    @IBAction func shareMeme(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                
                self.save()
                
                self.dismiss(animated: true, completion: nil)
        }
       
    }
         present(activityViewController, animated: true, completion: nil)
    }
  
}

