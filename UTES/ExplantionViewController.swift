//
//  ExplantionViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/19.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit

class ExplantionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toMain(){
        //ログイン成功
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
        //ログイン状態の保持
        let ud = UserDefaults.standard
        ud.set(true, forKey: "isLogin")
        ud.synchronize()
    }

}
