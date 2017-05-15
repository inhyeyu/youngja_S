//
//  NoticeTableViewCell.swift
//  youngjaS
//
//  Created by Shatra on 2017. 5. 10..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var textThumbLbl: UILabel!
    @IBOutlet weak var writerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
