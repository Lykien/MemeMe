//
//  ViewController.swift
//  MemeMe
//
//  Created by Nils Riebeling on 15.08.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var shareButton: UIBarButtonItem!
   
    @IBOutlet weak var cameraSelectorButton: UIBarButtonItem!
    @IBOutlet weak var pictureSelectorButton: UIBarButtonItem!
    @IBOutlet weak var toolbarTop: UIToolbar!
    @IBOutlet weak var toolbarBottom: UIToolbar!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var memeMeImage: UIImageView!
    
    
    let memeTextfieldDelegate = MemeTextFieldDelegate()
    
    

    
    
    //MARK: IBActions
    
    //Create and share the memed picture.
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
        let memedImage = generateMemedImage()
        
        
        //define an intance of the ActivityView Controller and pass the ActivityViewController a memmedImage as an activity item
        let shareViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                
                self.save()
                
                //Close view after saving of the picture
                self.dismiss(animated: true, completion: nil)
            }
            
        }
//        present the ActivityView Controller and call save method after completion
     
        present(shareViewController, animated: true, completion: nil)

        
    }
    
    //Reset all variables and start with viewWillAppear
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
        memeMeImage.image = nil
        self.shareButton.isEnabled = false
        self.viewWillAppear(true)
        dismiss(animated: true, completion: nil)
       
    
    }
    
    //Make a picture with the camera
    @IBAction func cameraSelectorAction(_ sender: UIBarButtonItem) {
        
        picAnImage(.camera)
        
    }
    
    //Select a picture from the libary
    @IBAction func pictureSelectorAction(_ sender: UIBarButtonItem) {
        
        picAnImage(.photoLibrary)
    }
    
    
    func picAnImage(_ source: UIImagePickerController.SourceType){
        
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = source
        present(pickController, animated: true, completion: nil)
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shareButton.isEnabled = false
        
        //Prepare the text fields
        prepareTextFields(textField: textFieldTop)
        prepareTextFields(textField: textFieldBottom)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Hide the camera button if camera is not available
        cameraSelectorButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        

        
        
        //Subscribe the Notification for the Keyboard
        subscribeToKeyboardNotifications()
        
    }
    
  
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Unsubscribe the Notification for the Keyboard
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    //MARK: Helper functions
    
    // Prepare the text field
    func prepareTextFields(textField: UITextField){
        
        let memeTextAttributes: [NSAttributedString.Key : Any] = [
            
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "KohinoorTelugu-Medium", size: 40)!,
            //To get a text with two coloures, you need to make the strokeWidth negative.
            NSAttributedString.Key.strokeWidth: -2
            
            
        ]
        
        textField.delegate = self.memeTextfieldDelegate
        textField.autocapitalizationType = .allCharacters
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"
                

    }
    
    // Generate a Memed image
    func generateMemedImage() -> UIImage {
        
        //Hide toolbar and navbar
        self.toolbarTop.isHidden = true
        self.toolbarBottom.isHidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show toolbar and navbar
        self.toolbarTop.isHidden = false
        self.toolbarBottom.isHidden = false
        
        return memedImage
    }
    
    
    //Save the Meme object
    func save(){
        // Create the meme object
        let meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, startImage: memeMeImage.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        // Add the Meme to the storage
        appDelegate.memes.append(meme)
    
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.memeMeImage.image = imagePicked
            
        }
    
        self.shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
  
    
    //MARK: Shift the view tht the textfield is not blocked by the keyboard
    
    func subscribeToKeyboardNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        //Just when the bottom text will be changed then the keyboard sould move up the frame
        if textFieldBottom.isFirstResponder {
        view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    
    
    @objc func keyboardWillHide(_ notification:Notification){
        
        self.view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
  


}



