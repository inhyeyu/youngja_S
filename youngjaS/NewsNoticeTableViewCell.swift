//
//  NewsNoticeTableViewCell.swift
//  youngjaS
//
//  Created by Shatra on 2017. 5. 8..
//  Copyright © 2017년 BWG. All rights reserved.
//

import UIKit

class NewsNoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var forwardBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
