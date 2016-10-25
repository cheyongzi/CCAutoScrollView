//
//  CustomCollectionViewCell.swift
//  AutoScrollViewExample
//
//  Created by Che Yongzi on 2016/10/25.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        customView.backgroundColor = UIColor.gray
    }

}
