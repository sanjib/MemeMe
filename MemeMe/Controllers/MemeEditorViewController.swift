//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/26/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var imagePickerToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!

    var meme: Meme!
    
    private let imagePickerController = UIImagePickerController()
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

    // Attributes and custom font for meme text
    private let memeTextAtrributes = [
        NSFontAttributeName:            UIFont(name: "CopalStd-Solid", size: 40)!,
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeWidthAttributeName :    -8.0,   // set negative value to avoid clear text
        NSStrokeColorAttributeName:     UIColor.blackColor(),
    ]
    
    private let defaultTextForTopTextField = "TOP"
    private let defaultTextForBottomTextField = "BOTTOM"
    
    // The following two properties are used to check which field user is currently editing.
    // The view should slide up only when user is editing bottomTextField.
    private var editingTopTextFieldBegan = false
    private var editingBottomTextFieldBegan = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        imagePickerController.delegate = self
        
        // Tags set to text field to check which field user is currently editing.
        topTextField.tag = 1
        bottomTextField.tag = 2
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let meme = meme {
            println(meme.topText)
        }

        // Meme text attributes and alignment
        topTextField.defaultTextAttributes = memeTextAtrributes
        bottomTextField.defaultTextAttributes = memeTextAtrributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center        
        
        // Enable camera button if available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Enable action button (for sharing meme) only when image has been set
        if memeImageView.image != nil {
            actionButton.enabled = true
        } else {
            actionButton.enabled = false
        }
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    

    
    // MARK: - Meme Actions
    
    @IBAction func actionForMeme(sender: UIBarButtonItem) {
        let memeImage = generateMemeImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = {
            activityType, completed, returnedItems, activityError in
            self.saveMeme()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancelMemeEdit(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Meme Image
    
    func saveMeme() {
        appDelegate.memes.append(Meme(
            topText: topTextField.text,
            bottomText: bottomTextField.text,
            originalImage: memeImageView.image!,
            memeImage: generateMemeImage()))
    }
    
    func generateMemeImage() -> UIImage {
        // Hide toolbar and navigation bar to avoid inclusion in saved image
        self.imagePickerToolbar.hidden = true
        self.navigationController?.navigationBarHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Restore toolbar and navigation bar
        self.imagePickerToolbar.hidden = false
        self.navigationController?.navigationBarHidden = false
        
        return memeImage
    }
    
    // MARK: - Image Picker
    
    @IBAction func getImage(sender: UIBarButtonItem) {
        // Tags assigned to bar button items to distinguish which button called this method
        // tag 1: camera button
        // tag 2: organize button
        if (sender.tag == 1) && cameraButton.enabled {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        } else if sender.tag == 2 {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Text Field
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        switch textField.text {
        case defaultTextForTopTextField, defaultTextForBottomTextField:
            textField.text = ""
        default: break
        }
        switch textField.tag {
        case 1:
            editingTopTextFieldBegan = true
        case 2:
            editingBottomTextFieldBegan = true
        default: break
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
        case 1:
            editingTopTextFieldBegan = false
        case 2:
            editingBottomTextFieldBegan = false
        default: break
        }
    }
    
    // MARK: - Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        // Slide view for bottom text field only
        if editingBottomTextFieldBegan {
            // Checking if the value of y is greater than 0 ensures
            // view doesn't go off-screen while toggling keyboard in simulator
            if self.view.frame.origin.y >= 0 {
                self.view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // Slide view for bottom text field only
        if editingBottomTextFieldBegan {
            // When keyboard should hide we can safely put the origin.y to 0
            // There is no need to add back the keyboard height which sometimes
            // doesn't return correctly while toggling keyboard in simulator
            self.view.frame.origin.y = 0
        }
    }
    
    private func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let keyboardSize = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    private func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    private func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(
            self,
            name: UIKeyboardWillHideNotification,
            object: nil)
    }

}
