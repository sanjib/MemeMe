//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/30/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        memeImageView.clipsToBounds = true
        
        // Show the right chevron button
        accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.editing {
            // Move the contentView frame origin while editing slightly to the right
            // to avoid the red delete button from overlapping the memeImageView
            self.contentView.frame.origin.x += 16.0
        }
    }
}
