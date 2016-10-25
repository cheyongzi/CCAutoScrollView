//
//  MainViewController.swift
//  AutoScrollViewExample
//
//  Created by Che Yongzi on 2016/10/25.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

import UIKit

let names: [String] = ["Default","Custom","XIB"]

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.title = "CCAutoScroll"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let defaultController = DefaultViewController()
            self.navigationController?.pushViewController(defaultController, animated: true)
        }else if indexPath.row == 1 {
            let customController = CustomViewController()
            self.navigationController?.pushViewController(customController, animated: true)
        }else if indexPath.row == 2 {
            let xibController = XIBViewController(nibName: "XIBViewController", bundle: nil)
            self.navigationController?.pushViewController(xibController, animated: true)
        }
    }

}
