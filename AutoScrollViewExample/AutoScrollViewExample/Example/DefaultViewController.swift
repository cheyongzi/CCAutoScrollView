//
//  DefaultViewController.swift
//  AutoScrollViewExample
//
//  Created by Che Yongzi on 2016/10/25.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController, CCAutoScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.white
        
        let scroll = CCAutoScrollView(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        scroll.dataSource = ["1.jpg","2.jpg","3.jpg"]
        scroll.autoScrollEnable = true
        scroll.delegate = self
        view.addSubview(scroll)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("Default View Controller deinit")
    }
    
    //MARK: - CCAutoScrollView delegate
    func autoScrollView(_ scrollView: CCAutoScrollView, didSelectItemAt indexPath: IndexPath) {
        print("scroll view did select indexpath \(indexPath)")
    }
    
    func autoScrollView(_ scrollView: CCAutoScrollView, scrollToItemAt indexPath: IndexPath) {
        print("scroll view scroll to indexPath \(indexPath)")
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
