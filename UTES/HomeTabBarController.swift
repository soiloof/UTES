//
//  HomeTabBarController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/20.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import FrostedSidebar

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var sidebar: FrostedSidebar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isHidden = true
        
        moreNavigationController.navigationBar.isHidden = true
        
        sidebar = FrostedSidebar(itemImages: [
            UIImage(named: "akamon")!,
            UIImage(named: "blueInfo")!,
            UIImage(named: "knowledge")!,
            UIImage(named: "gmail")!],
                                 colors: [
                                    UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 1),
                                    UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 1),
                                    UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 1),
                                    UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 1)],
                                 selectionStyle: .single)
        sidebar.actionForIndex = [
            0: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 0}) },
            1: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 1}) },
            2: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 2}) },
            3: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 3}) },
            4: {self.sidebar.dismissAnimated(true, completion: { finished in self.selectedIndex = 4}) },]
        

        
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
