//
//  ExplanationInfoViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/20.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import FrostedSidebar

class ExplanationInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBar
        //バー背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //バーアイテムカラー
        self.navigationController?.navigationBar.tintColor = UIColor.cyan
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBurger() {
        (tabBarController as! HomeTabBarController).sidebar.showInViewController(self, animated: true)
    }

}
