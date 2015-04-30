//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/26/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println(meme.topText)
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editMeme")
        let deleteButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteMeme")
        self.navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }
    
    func editMeme() {
        println("edit meme")
        performSegueWithIdentifier("MemeEditorSegueFromMemeDetail", sender: self)
    }
    
    func deleteMeme() {
        let controller = UIAlertController()
        controller.title = "Delete Meme"
        controller.message = "Are you sure you want to delete this meme?"
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) {
            action in
            println("delete meme")
            })
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            action in
            println("cancel delete")
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "MemeEditorSegueFromMemeDetail" {
            let navController = segue.destinationViewController as! UINavigationController
            let controller = navController.childViewControllers.first as! MemeEditorViewController
            controller.meme = meme
        }
    }

}
