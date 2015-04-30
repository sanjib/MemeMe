//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/30/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
//    var topTextLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        topTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
//        topTextLabel.textColor = UIColor.redColor()
//        contentView.addSubview(topTextLabel)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
