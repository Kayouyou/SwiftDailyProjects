//
//  VideoCell.swift
//  SwiftProjectFour
//
//  Created by 叶杨杨 on 2017/2/7.
//  Copyright © 2017年 叶杨杨. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var cellBackImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
