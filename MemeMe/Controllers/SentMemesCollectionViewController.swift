//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/26/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

let reuseIdentifier = "MemeItemCell"

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var editButton: UIBarButtonItem!
    var toolbar: UIToolbar!
    var toolbarItemDelete: UIBarButtonItem!
    
    private var meme: Meme!
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var inEditingMode = false
    
    // Layout properties
    let minimumSpacingBetweenCells = 5
    let cellsPerRowInPortraitMode = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Create the toolbar
        toolbar = UIToolbar(frame: CGRect(
            x: 0,
            y: (self.view.bounds.size.height - 44),
            width: self.view.bounds.size.width,
            height: 44))
        toolbar.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.view.addSubview(toolbar)
        
        // Create the trash icon (UIBarButtonItem)
        toolbarItemDelete = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: nil, action: "deleteSelectedModels")
        toolbar.items = [toolbarItemDelete]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()

        // Turn edit mode off
        turnEditModeOff()
    }
    
    // MARK: - Edit collection and toolbar

    @IBAction func editCollection(sender: UIBarButtonItem) {
        // Toggle edit mode
        if inEditingMode {
            turnEditModeOff()
        } else {
            toolbar.hidden = false
            editButton.title = "Done"
            self.collectionView?.allowsMultipleSelection = true
            self.tabBarController?.tabBar.hidden = true
            inEditingMode = true
        }
    }
    
    private func turnEditModeOff() {
        // Deselect all items when edit mode is turned off
        if let itemPaths = self.collectionView?.indexPathsForSelectedItems() as? [NSIndexPath] {
            for indexPath in itemPaths {
                self.collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
            }
        }
        
        // Disable multiple selection, show tab bar, hide edit toolbar
        self.collectionView?.allowsMultipleSelection = false
        self.tabBarController?.tabBar.hidden = false
        toolbar.hidden = true
        
        // Set edit button properties
        editButton.title = "Edit"
        if (appDelegate.memes.count == 0) {
            editButton.enabled = false
        } else {
            editButton.enabled = true
        }
        
        // Disable trash icon and set edit mode to false
        toolbarItemDelete.enabled = toolbarItemDeleteState()
        inEditingMode = false
    }

    private func toolbarItemDeleteState() -> Bool {
        // Enable or disable trash icon in toolbar based on items selected
        if let itemPaths = self.collectionView?.indexPathsForSelectedItems() {
            if itemPaths.count > 0 {
                return true
            }
        }
        return false
    }
    
    // MARK: Meme Delete
    
    func deleteSelectedModels() {
        self.collectionView?.performBatchUpdates({
            if let itemPaths = self.collectionView?.indexPathsForSelectedItems() {
                var indicesToDelete = [Int]()
                for indexPath in itemPaths {
                    indicesToDelete.append(indexPath.row)
                }
                // Sorted indices by descending order because everytime an element E is removed,
                // the indices of the elements beyond E is reduced by one
                indicesToDelete.sort(>)
                for index in indicesToDelete {
                    self.appDelegate.memes.removeAtIndex(index)
                }
                self.collectionView?.deleteItemsAtIndexPaths(itemPaths)
            }
            }, completion: nil)
        inEditingMode = false
        turnEditModeOff()
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Use width in portrait mode; height in landscape
        let deviceOrientation = UIDevice.currentDevice().orientation
        var widthForCollection: CGFloat!
        if (deviceOrientation == UIDeviceOrientation.Portrait) || (deviceOrientation == UIDeviceOrientation.PortraitUpsideDown) {
            widthForCollection = self.view.frame.width
        } else {
            widthForCollection = self.view.frame.height
        }
        
        // To determine width of a cell we divide frame width by cells per row
        // Then compensate it by subtracting minimum spacing between cells
        // The last cell doesn't need compensation for spacing
        let width = Float(widthForCollection / CGFloat(cellsPerRowInPortraitMode)) -
            Float(minimumSpacingBetweenCells - (minimumSpacingBetweenCells / cellsPerRowInPortraitMode))
        let height = width
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(minimumSpacingBetweenCells)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(minimumSpacingBetweenCells)
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    
        let meme = appDelegate.memes[indexPath.row]
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = meme.memeImage
        cell.backgroundView = imageView
        
        // Selected state properties
        let backgroundView = UIView(frame: cell.contentView.frame)
        backgroundView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)

        let checkmarkImageView = UIImageView(frame: cell.contentView.frame)
        checkmarkImageView.contentMode = UIViewContentMode.BottomRight
        checkmarkImageView.image = UIImage(named: "checkmark")
        backgroundView.addSubview(checkmarkImageView)
        cell.selectedBackgroundView = backgroundView
    
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !inEditingMode {
            meme = appDelegate.memes[indexPath.row]
            performSegueWithIdentifier("MemeDetailSegueFromSentMemesCollection", sender: self)
        } else {
            toolbarItemDelete.enabled = toolbarItemDeleteState()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if inEditingMode {
            toolbarItemDelete.enabled = toolbarItemDeleteState()
        }
    }    

    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if !inEditingMode {
            collectionView.cellForItemAtIndexPath(indexPath)?.selectedBackgroundView = nil
        }
        return true
    }

    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if !inEditingMode {
            collectionView.cellForItemAtIndexPath(indexPath)?.selectedBackgroundView = nil
        }
        return true
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MemeDetailSegueFromSentMemesCollection" {
            let controller = segue.destinationViewController as! MemeDetailViewController
            controller.meme = meme
        }
    }

}
