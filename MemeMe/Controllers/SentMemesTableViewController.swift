//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/26/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    private var meme: Meme!
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var memeEditorShown = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.reloadData()
        
        // Disable the Edit button if there are no memes
        if (appDelegate.memes.count == 0) {
            editButton.enabled = false
        } else {
            editButton.enabled = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show the Meme Editor when there are no memes and the Meme Editor was never shown
        if (appDelegate.memes.count == 0) && (memeEditorShown == false) {
            performSegueWithIdentifier("MemeEditorSegueFromMemeScenesTable", sender: self)
            memeEditorShown = true
        }
    }
    
    @IBAction func editTable(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.editing, animated: true)
        // Toggle the Done and Edit buttons based on editing state
        if tableView.editing {
            editButton.title = "Done"
        } else {
            editButton.title = "Edit"
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell", forIndexPath: indexPath) as! SentMemesTableViewCell
        let meme = appDelegate.memes[indexPath.row]
        cell.memeImageView.image = meme.memeImage
        cell.topTextLabel.text = meme.topText
        cell.bottomTextLabel.text = meme.bottomText
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        meme = appDelegate.memes[indexPath.row]
        performSegueWithIdentifier("MemeDetailSegueFromSentMemesTable", sender: self)
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            meme = nil
            appDelegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MemeDetailSegueFromSentMemesTable" {
            let controller = segue.destinationViewController as! MemeDetailViewController
            controller.meme = meme
        }
    }

}
