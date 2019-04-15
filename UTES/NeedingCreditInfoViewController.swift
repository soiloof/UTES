//
//  NeedingCreditInfoViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/16.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB

class NeedingCreditInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var userAffiliationLabel: UILabel!
    @IBOutlet var needingCreditInfoTableView: UITableView!
    
    
    let liberalarts1CreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール文科", "社会科学※", "人文科学", "展開科目", "L（総合科目）※", "ABC（総合科目）", "DEF（総合科目）", "主題科目", "その他なんでも", "合計"]
    
    let liberalarts2CreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール文科", "社会科学※", "人文科学", "展開科目", "L（総合科目）※", "ABC（総合科目）", "DEF（総合科目）", "主題科目", "その他なんでも", "合計"]
    
    let liberalarts3CreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール文科", "社会科学※", "人文科学", "展開科目", "L（総合科目）※", "ABC（総合科目）※",  "DEF（総合科目）", "主題科目", "その他なんでも", "合計"]
    
    let socialscienceCreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール理科", "基礎実験（自然科学）", "数理科学（自然科学）", "物質科学（自然科学）", "生命科学（自然科学）" ,"展開科目", "L（総合科目）", "ABCD（総合科目）", "EF（総合科目）",  "主題科目", "その他なんでも", "合計"]
    
    let liberalarts1CreditNumberStringList = ["5", "6", "2", "2", "2", "8", "4", "(任意)", "9", "6", "6", "2(0)", "4(0)", "56(50)"]
    let liberalarts2CreditNumberStringList = ["5", "6", "2", "2", "2", "8", "4", "(任意)", "9", "6", "6", "2(0)", "4(0)", "56(50)"]
    let liberalarts3CreditNumberStringList = ["5", "6", "2", "2", "2", "4", "4", "(任意)", "9~13", "4~8",  "8", "2(0)", "4(0)", "56(50)"]
    let socialscience1CreditNumberStringList = ["5", "6", "2", "2", "2(0)", "3", "12", "10", "1",  "(任意)", "3", "6",  "6", "2(0)", "3(0)", "63(56)"]
    let socialscience2CreditNumberStringList = ["5", "6", "2", "2", "2(0)", "3", "10", "10", "4",  "(任意)", "3", "6",  "6", "2(0)", "2(0)", "63(57)"]
    let socialscience3CreditNumberStringList = ["5", "6", "2", "2", "2(0)", "3", "10", "10", "4",  "(任意)", "3", "6",  "6", "2(0)", "2(0)", "63(57)"]

    override func viewDidLoad() {
        super.viewDidLoad()

        needingCreditInfoTableView.dataSource = self
        needingCreditInfoTableView.delegate = self
        
        getAffiliationData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getAffiliationData()
    }
    

    //編集した内容を入手
    func getAffiliationData(){
        if let user = NCMBUser.current() {
            if user.object(forKey: "affiliation") != nil{
                userAffiliationLabel.text = user.object(forKey: "affiliation") as? String
            }else{
                let alertController = UIAlertController(title: "科類が設定されていません", message: "科類をマイページから選択してください", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
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
    }
    
    
    //tableviewの関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userAffiliationLabel.text! == "文科Ⅰ類" {
            return liberalarts1CreditList.count
        }else if userAffiliationLabel.text! == "文科Ⅱ類"{
            return liberalarts2CreditList.count
        }else if userAffiliationLabel.text! == "文科Ⅲ類"{
            return liberalarts3CreditList.count
        }else if userAffiliationLabel.text! == "理科Ⅰ類"{
            return socialscienceCreditList.count
        }else if userAffiliationLabel.text! == "理科Ⅱ類"{
            return socialscienceCreditList.count
        }else if userAffiliationLabel.text! == "理科Ⅲ類"{
            return socialscienceCreditList.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeedingCreditInfoCell")!
        
        if userAffiliationLabel.text! == "文科Ⅰ類" {
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            let creditnumberLabel = cell.viewWithTag(2) as! UILabel
            classtypeLabel.text = liberalarts1CreditList[indexPath.row]
            creditnumberLabel.text = liberalarts1CreditNumberStringList[indexPath.row]
            
        }else if userAffiliationLabel.text! == "文科Ⅱ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            let creditnumberLabel = cell.viewWithTag(2) as! UILabel
            classtypeLabel.text = liberalarts2CreditList[indexPath.row]
            creditnumberLabel.text = liberalarts2CreditNumberStringList[indexPath.row]
            
        }else if userAffiliationLabel.text! == "文科Ⅲ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            let creditnumberLabel = cell.viewWithTag(2) as! UILabel
            classtypeLabel.text = liberalarts3CreditList[indexPath.row]
            creditnumberLabel.text = liberalarts3CreditNumberStringList[indexPath.row]
            
        }else if userAffiliationLabel.text! == "理科Ⅰ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            let creditnumberLabel = cell.viewWithTag(2) as! UILabel
            classtypeLabel.text = socialscienceCreditList[indexPath.row]
            creditnumberLabel.text = socialscience1CreditNumberStringList[indexPath.row]
            
        }else if userAffiliationLabel.text! == "理科Ⅱ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            let creditnumberLabel = cell.viewWithTag(2) as! UILabel
            classtypeLabel.text = socialscienceCreditList[indexPath.row]
            creditnumberLabel.text = socialscience2CreditNumberStringList[indexPath.row]
        }else if userAffiliationLabel.text! == "理科Ⅲ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            let creditnumberLabel = cell.viewWithTag(2) as! UILabel
            classtypeLabel.text = socialscienceCreditList[indexPath.row]
            creditnumberLabel.text = socialscience3CreditNumberStringList[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
