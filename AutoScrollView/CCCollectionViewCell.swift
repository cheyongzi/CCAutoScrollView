//
//  CCCollectionViewCell.swift
//  AutoScrollViewExample
//
//  Created by Che Yongzi on 2016/10/25.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class CCCollectionViewCell: UICollectionViewCell {
    public private(set) var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        closure {
            imageView = UIImageView(frame: self.bounds)
            self.addSubview(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
