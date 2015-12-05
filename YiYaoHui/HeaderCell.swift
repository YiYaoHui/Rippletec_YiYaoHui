//
//  HeaderCell.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/3.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var stateImageView: UIImageView!
    
    @IBOutlet weak var secondLevelLabel: UILabel!
    @IBOutlet weak var fourthLevelLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
