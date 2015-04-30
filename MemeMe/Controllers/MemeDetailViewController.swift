//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/26/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImageView: UIImageView!

    var meme: Meme!
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editMeme")
        let deleteButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteMeme")
        self.navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if meme == nil {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            memeImageView.image = meme.memeImage
        }
    }
    
    func editMeme() {
        performSegueWithIdentifier("MemeEditorSegueFromMemeDetail", sender: self)
    }
    
    func deleteMeme() {
        let controller = UIAlertController()
        controller.title = "Delete Meme"
        controller.message = "Are you sure you want to delete this meme?"
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) {
            action in
            let index = (self.appDelegate.memes as NSArray).indexOfObject(self.meme)
            self.appDelegate.memes.removeAtIndex(index)
            self.navigationController?.popViewControllerAnimated(true)
            })
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MemeEditorSegueFromMemeDetail" {
            let navController = segue.destinationViewController as! UINavigationController
            let controller = navController.childViewControllers.first as! MemeEditorViewController
            controller.meme = meme
        }
    }

}
