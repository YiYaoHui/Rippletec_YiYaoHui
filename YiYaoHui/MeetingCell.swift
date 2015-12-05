//
//  MeetingCell.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MeetingCell: UITableViewCell {
    
    
    @IBOutlet weak var meetingLogo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var holderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
