//
//  XIBViewController.swift
//  AutoScrollViewExample
//
//  Created by Che Yongzi on 2016/10/25.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class XIBViewController: UIViewController {

    @IBOutlet weak var autoScrollView: CCAutoScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.white
        
        autoScrollView.dataSource = ["1.jpg","2.jpg","3.jpg"]
        autoScrollView.cellClass = CustomClassCollectionViewCell.self
        autoScrollView.autoScrollEnable = true
        autoScrollView.cellConfig = { (cell, data) in
            guard let customCell = cell as? CustomClassCollectionViewCell else {
                return
            }
            guard let imgName = data as? String else {
                return
            }
            customCell.imageView.image = UIImage(named: imgName)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
