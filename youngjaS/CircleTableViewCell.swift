//
//  CircleTableViewCell.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 6..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class CircleTableViewCell: UITableViewCell {

    @IBOutlet weak var circleImageView: UIImageView!
    
    @IBOutlet weak var circleNameLabel: UILabel!
    
    @IBOutlet weak var circleDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 0, 0, 0))
    }
}
