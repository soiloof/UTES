//
//  ProfileViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/16.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB
import FrostedSidebar


class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var userIDLabel: UILabel!
    @IBOutlet var userDisplayNameLabel: UILabel!
    @IBOutlet var userAffiliationLabel: UILabel!
    @IBOutlet var currentCreditNumberLabel: UILabel!
    @IBOutlet var currentScoreLabel: UILabel!
    var hopedDepartmentArray:[[String]] = [[]]
    @IBOutlet var hopedDepartmentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationBar
        //バー背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //バーアイテムカラー
        self.navigationController?.navigationBar.tintColor = UIColor.cyan
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        hopedDepartmentTableView.dataSource = self
        hopedDepartmentTableView.delegate = self
        hopedDepartmentTableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //編集した内容を入手
        if let user = NCMBUser.current() {
            userIDLabel.text = user.userName
            userAffiliationLabel.text = user.object(forKey: "affiliation") as? String
            if  user.object(forKey: "displayName") != nil{
                userDisplayNameLabel.text = user.object(forKey: "displayName") as! String
            }else{
                userDisplayNameLabel.text = ""
            }
           
            
     
        }else{
            //ログアウト成功
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            //ログアウト状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
            
        }
       
      loadHopedDepartmentArray()
        loadCurrentScore()
        loadCurrentCreditNumber()
    }
    //classdataを取得
    func loadHopedDepartmentArray(){
        
        let ud = UserDefaults.standard
        if ud.array(forKey: "selectedDepartmentArray") != nil{
            hopedDepartmentArray = ud.array(forKey: "selectedDepartmentArray") as! [[String]]
            print(hopedDepartmentArray)
            hopedDepartmentTableView.reloadData()
        }else{
        }
    }
    
    //計算方式の取得
 
    func loadCurrentScore(){
        let ud = UserDefaults.standard
        if ud.array(forKey: "CurrentScore") != nil{
            currentScoreLabel.text = ud.array(forKey: "CurrentScore")?.last as! String
        }
    }
    func loadCurrentCreditNumber(){
        let ud = UserDefaults.standard
        if ud.array(forKey: "CurrentCreditNumber") != nil{
            currentCreditNumberLabel.text = ud.array(forKey: "CurrentCreditNumber")?.last as! String
        }
        
    }

    
    

    //メニュー動作（ログアウト、退会）
    @IBAction func showMenu(){
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください。", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil{
                    print("error")
                }else{
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログアウト状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            })
        }
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil{
                    print("error")
                }else{
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログアウト状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                }
            })
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(signOutAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onBurger() {
        (tabBarController as! HomeTabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hopedDepartmentArray.count-1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hopedDepartmentCell")!
        let departmentNameLabel = cell.viewWithTag(1) as! UILabel
        let departmentDetailNameLabel = cell.viewWithTag(2) as! UILabel
        let calculateTypeNameLabel = cell.viewWithTag(3) as! UILabel
        let calculatedScoreLabel = cell.viewWithTag(4) as! UILabel
        departmentNameLabel.text = hopedDepartmentArray[(indexPath.row)+1][1]
        departmentDetailNameLabel.text = hopedDepartmentArray[(indexPath.row)+1][2]
        calculateTypeNameLabel.text = hopedDepartmentArray[(indexPath.row)+1][4]
        let ud = UserDefaults.standard
        if calculateTypeNameLabel.text == "基本平均点"{
            if ud.array(forKey: "DefaultScore") != nil{
                calculatedScoreLabel.text = ud.array(forKey: "DefaultScore")?.last as! String
            }else{
                calculatedScoreLabel.text = "未計算"
            }
        }else if calculateTypeNameLabel.text == "工学部指定平均"{
            if ud.array(forKey: "EngineeringScore") != nil{
                calculatedScoreLabel.text = ud.array(forKey: "EngineeringScore")?.last as! String
            }else{
                calculatedScoreLabel.text = "未計算"
            }
            
        }else if calculateTypeNameLabel.text == "農学部指定平均"{
            if ud.array(forKey: "AgricultureScore") != nil{
                calculatedScoreLabel.text = ud.array(forKey: "AgricultureScore")?.last as! String
            }else{
                calculatedScoreLabel.text = "未計算"
            }
        }else{
            calculatedScoreLabel.text = "未実装"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
