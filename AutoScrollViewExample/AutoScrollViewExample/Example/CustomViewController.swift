//
//  CustomViewController.swift
//  AutoScrollViewExample
//
//  Created by Che Yongzi on 2016/10/25.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.white

        let scroll = CCAutoScrollView(frame: CGRect(x: 0, y: 64, width: 300, height: 200))
        scroll.dataSource = [UIColor.red,UIColor.blue,UIColor.green]
        scroll.autoScrollTimeInterval = 1.5
        scroll.cellNibName = "CustomCollectionViewCell"
        scroll.cellConfig = { (cell, data) in
            guard let customCell = cell as? CustomCollectionViewCell else {
                return
            }
            guard let color = data as? UIColor else {
                return
            }
            customCell.customView.backgroundColor = color
        }
        view.addSubview(scroll)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
