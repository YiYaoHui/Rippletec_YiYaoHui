//
//  OptionCell.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/29.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {
    
    
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
