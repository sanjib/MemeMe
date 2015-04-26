//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Sanjib Ahmad on 4/27/15.
//  Copyright (c) 2015 Object Coder. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    var topTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topTextLabel = UILabel(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height))
        topTextLabel.textColor = UIColor.redColor()
        contentView.addSubview(topTextLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
