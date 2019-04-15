//
//  ShortageCreditInfoViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/16.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB

class ShortageCreditInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var userAffiliationLabel: UILabel!
    @IBOutlet var shortageCreditInfoTableView: UITableView!
    
    var classDataArray = [[String]]()
    
    let classtypeList = ["","既修外国語（必修）", "初修外国語（必修）", "情報", "スポ身（必修）",
                         "初ゼミ文科", "初ゼミ理科", "社会科学", "人文科学",
                         "基礎実験（自然科学）", "数理科学（自然科学）", "物質科学（自然科学）","生命科学（自然科学）",
                         "L（総合科目）", "A（総合科目）", "B（総合科目）", "C（総合科目）",
                         "D（総合科目）", "E（総合科目）", "F（総合科目）", "主題科目", "展開科目"]
    
    let liberalarts1CreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール文科", "社会科学※", "人文科学", "展開科目", "L（総合科目）※", "ABC（総合科目）", "DEF（総合科目）", "主題科目", "その他なんでも", "合計"]
    
    let liberalarts2CreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール文科", "社会科学※", "人文科学", "展開科目", "L（総合科目）※", "ABC（総合科目）", "DEF（総合科目）", "主題科目", "その他なんでも", "合計"]
    
    let liberalarts3CreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール文科", "社会科学※", "人文科学", "展開科目", "L（総合科目）※", "ABC（総合科目）※",  "DEF（総合科目）", "主題科目", "その他なんでも", "合計"]
    
    let socialscienceCreditList = ["既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール理科", "基礎実験（自然科学）", "数理科学（自然科学）", "物質科学（自然科学）", "生命科学（自然科学）" ,"展開科目", "L（総合科目）", "ABCD（総合科目）", "EF（総合科目）",  "主題科目", "その他なんでも", "合計"]
    
    let liberalarts1CreditNumberStringList = ["5", "6", "2", "2", "2", "8", "4", "(0)", "9", "6", "6", "2(0)", "4(0)", "56(50)"]
    let liberalarts2CreditNumberStringList = ["5", "6", "2", "2", "2", "8", "4", "(0)", "9", "6", "6", "2(0)", "4(0)", "56(50)"]
    let liberalarts3CreditNumberStringList = ["5", "6", "2", "2", "2", "4", "4", "(0)", "9~13", "4~8",  "8", "2(0)", "4(0)", "56(50)"]
    let socialscience1CreditNumberStringList = ["5", "6", "2", "2", "2(0)", "3", "12", "10", "1",  "0", "3", "6",  "6", "2(0)", "3(0)", "63(56)"]
    let socialscience2CreditNumberStringList = ["5", "6", "2", "2", "2(0)", "3", "10", "10", "4",  "0", "3", "6",  "6", "2(0)", "2(0)", "63(57)"]
    let socialscience3CreditNumberStringList = ["5", "6", "2", "2", "2(0)", "3", "10", "10", "4",  "0", "3", "6",  "6", "2(0)", "2(0)", "63(57)"]
    
    let liberalarts1CreditNumberIntList = [5, 6, 2, 2, 2, 8, 4, 0, 9, 6, 6, 2, 4, 50]
    let liberalarts2CreditNumberIntList = [5, 6, 2, 2, 2, 8, 4, 0, 9, 6, 6, 2, 4, 50]
    let liberalarts3CreditNumberIntList = [5, 6, 2, 2, 2, 4, 4, 0, 9, 8, 8, 2, 4, 50]
    let socialscience1CreditNumberIntList = [5, 6, 2, 2, 2, 3, 12, 10, 1,  0, 3, 6,  6, 2, 3, 56]
    let socialscience2CreditNumberIntList = [5, 6, 2, 2, 2, 3, 10, 10, 4,  0, 3, 6,  6, 2, 2, 57]
    let socialscience3CreditNumberIntList = [5, 6, 2, 2, 2, 3, 10, 10, 4,  0, 3, 6,  6, 2, 2, 57]
    
    
    
    
    var liberalarts1CurrentCreditNumberStringList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var liberalarts2CurrentCreditNumberStringList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var liberalarts3CurrentCreditNumberStringList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var socialscienceCurrentCreditNumberStringList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var socialscience23CurrentCreditNumberStringList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableviewメソッド
        shortageCreditInfoTableView.dataSource = self
        shortageCreditInfoTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        getAffiliationData()
        loadClassData()
        getCurrentCreditInfo()
    }
    
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
    

    //classdataの取得
    func loadClassData(){
        
        let ud = UserDefaults.standard
        if ud.array(forKey: "classArray") != nil{
            
            classDataArray = ud.array(forKey: "classArray") as! [[String]]
            
        }else{
            print("error")
        }
        
        
    }
    
    /*現単位数の取得*/
    func getCurrentCreditInfo(){
        if userAffiliationLabel.text! == "文科Ⅰ類" {
            for var i in 0 ..< classDataArray.count{
                if classDataArray[i][6] == "追い出し" {
                    liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                }else if classDataArray[i][6] == "通常"{
                    if classDataArray[i][3] != nil && classDataArray[i][4] != nil{
                        if classDataArray[i][3] == "既修外国語（必修）" {
                            liberalarts1CurrentCreditNumberStringList[0] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初修外国語（必修）" {
                            liberalarts1CurrentCreditNumberStringList[1] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "情報" {
                            liberalarts1CurrentCreditNumberStringList[2] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "スポ身（必修）"{
                            liberalarts1CurrentCreditNumberStringList[3] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初ゼミ文科" {
                            liberalarts1CurrentCreditNumberStringList[4] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初ゼミ理科" {
                            liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "社会科学"{
                            liberalarts1CurrentCreditNumberStringList[5] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "人文科学" {
                            liberalarts1CurrentCreditNumberStringList[6] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "基礎実験（自然科学）" {
                            liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "数理科学（自然科学）" {
                            liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "物質科学（自然科学）"{
                            liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "生命科学（自然科学）" {
                            liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "L（総合科目）"{
                            liberalarts1CurrentCreditNumberStringList[8] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "A（総合科目）" {
                            liberalarts1CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "B（総合科目）" {
                            liberalarts1CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "C（総合科目）" {
                            liberalarts1CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "D（総合科目）"{
                            liberalarts1CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "E（総合科目）" {
                            liberalarts1CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "F（総合科目）" {
                            liberalarts1CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "主題科目" {
                            liberalarts1CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "展開科目" {
                            liberalarts1CurrentCreditNumberStringList[7] += Int(classDataArray[i][4])!
                            liberalarts1CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }
                    }else{
                        let alertController = UIAlertController(title: "科目区分が選択されていません", message: "科目区分を選択してください", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    //ノーカウントが選ばれていたら
                }else{
                    
                }
            }
            
        }else if userAffiliationLabel.text! == "文科Ⅱ類"{
            for var i in 0 ..< classDataArray.count{
                if classDataArray[i][6] == "追い出し" {
                    liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                }else if classDataArray[i][6] == "通常"{
                    if classDataArray[i][3] != nil && classDataArray[i][4] != nil{
                        if classDataArray[i][3] == "既修外国語（必修）" {
                            liberalarts2CurrentCreditNumberStringList[0] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初修外国語（必修）" {
                            liberalarts2CurrentCreditNumberStringList[1] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "情報" {
                            liberalarts2CurrentCreditNumberStringList[2] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "スポ身（必修）"{
                            liberalarts2CurrentCreditNumberStringList[3] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初ゼミ文科" {
                            liberalarts2CurrentCreditNumberStringList[4] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初ゼミ理科" {
                            liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "社会科学"{
                            liberalarts2CurrentCreditNumberStringList[5] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "人文科学" {
                            liberalarts2CurrentCreditNumberStringList[6] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "基礎実験（自然科学）" {
                            liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "数理科学（自然科学）" {
                            liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "物質科学（自然科学）"{
                            liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "生命科学（自然科学）" {
                            liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "L（総合科目）"{
                            liberalarts2CurrentCreditNumberStringList[8] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "A（総合科目）" {
                            liberalarts2CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "B（総合科目）" {
                            liberalarts2CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "C（総合科目）" {
                            liberalarts2CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "D（総合科目）"{
                            liberalarts2CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "E（総合科目）" {
                            liberalarts2CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "F（総合科目）" {
                            liberalarts2CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "主題科目" {
                            liberalarts2CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "展開科目" {
                            liberalarts2CurrentCreditNumberStringList[7] += Int(classDataArray[i][4])!
                            liberalarts2CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }
                    }else{
                        let alertController = UIAlertController(title: "科目区分が選択されていません", message: "科目区分を選択してください", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }else{
                    
                }
                
            }
        }else if userAffiliationLabel.text! == "文科Ⅲ類"{
            for var i in 0 ..< classDataArray.count{
                if classDataArray[i][6] == "追い出し" {
                    liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                }else if classDataArray[i][6] == "通常"{
                    if classDataArray[i][3] != nil && classDataArray[i][4] != nil{
                        if classDataArray[i][3] == "既修外国語（必修）" {
                            liberalarts3CurrentCreditNumberStringList[0] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初修外国語（必修）" {
                            liberalarts3CurrentCreditNumberStringList[1] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "情報" {
                            liberalarts3CurrentCreditNumberStringList[2] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "スポ身（必修）"{
                            liberalarts3CurrentCreditNumberStringList[3] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初ゼミ文科" {
                            liberalarts3CurrentCreditNumberStringList[4] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "初ゼミ理科" {
                            liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "社会科学"{
                            liberalarts3CurrentCreditNumberStringList[5] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "人文科学" {
                            liberalarts3CurrentCreditNumberStringList[6] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "基礎実験（自然科学）" {
                            liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "数理科学（自然科学）" {
                            liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "物質科学（自然科学）"{
                            liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "生命科学（自然科学）" {
                            liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "L（総合科目）"{
                            liberalarts3CurrentCreditNumberStringList[8] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "A（総合科目）" {
                            liberalarts3CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "B（総合科目）" {
                            liberalarts3CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "C（総合科目）" {
                            liberalarts3CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "D（総合科目）"{
                            liberalarts3CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "E（総合科目）" {
                            liberalarts3CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "F（総合科目）" {
                            liberalarts3CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "主題科目" {
                            liberalarts3CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                        }else if classDataArray[i][3] == "展開科目" {
                            liberalarts3CurrentCreditNumberStringList[7] += Int(classDataArray[i][4])!
                            liberalarts3CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                        }
                    }else{
                        let alertController = UIAlertController(title: "科目区分が選択されていません", message: "科目区分を選択してください", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }else{
                    
                }
            }
            
            /*"既修外国語※", "初修外国語", "情報", "スポ身", "初年次ゼミナール理科", "基礎実験（自然科学）", "数理科学（自然科学）", "物質科学（自然科学）", "生命科学（自然科学）" ,"展開科目", "L（総合科目）", "ABCD（総合科目）", "EF（総合科目）",  "主題科目", "その他なんでも", "合計"*/
            
        }else if userAffiliationLabel.text! == "理科Ⅰ類"{
            for var i in 0 ..< classDataArray.count{
                if classDataArray[i][6] == "追い出し" {
                    socialscienceCurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                }else if classDataArray[i][6] == "通常"{
                    if classDataArray[i][3] == "既修外国語（必修）" {
                        socialscienceCurrentCreditNumberStringList[0] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初修外国語（必修）" {
                        socialscienceCurrentCreditNumberStringList[1] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "情報" {
                        socialscienceCurrentCreditNumberStringList[2] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "スポ身（必修）"{
                        socialscienceCurrentCreditNumberStringList[3] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初ゼミ文科" {
                        socialscienceCurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初ゼミ理科" {
                        socialscienceCurrentCreditNumberStringList[4] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "社会科学"{
                        socialscienceCurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "人文科学" {
                        socialscienceCurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "基礎実験（自然科学）" {
                        socialscienceCurrentCreditNumberStringList[5] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "数理科学（自然科学）" {
                        socialscienceCurrentCreditNumberStringList[6] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "物質科学（自然科学）"{
                        socialscienceCurrentCreditNumberStringList[7] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "生命科学（自然科学）" {
                        socialscienceCurrentCreditNumberStringList[8] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "L（総合科目）"{
                        socialscienceCurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "A（総合科目）" {
                        socialscienceCurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "B（総合科目）" {
                        socialscienceCurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "C（総合科目）" {
                        socialscienceCurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "D（総合科目）"{
                        socialscienceCurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "E（総合科目）" {
                        socialscienceCurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "F（総合科目）" {
                        socialscienceCurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "主題科目" {
                        socialscienceCurrentCreditNumberStringList[13] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "展開科目" {
                        socialscienceCurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        socialscienceCurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }
                }else{
                    
                }
            }
        }else if userAffiliationLabel.text! == "理科Ⅱ類"{
            for var i in 0 ..< classDataArray.count{
                if classDataArray[i][6] == "追い出し" {
                    socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                }else if classDataArray[i][6] == "通常"{
                    if classDataArray[i][3] == "既修外国語（必修）" {
                        socialscience23CurrentCreditNumberStringList[0] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初修外国語（必修）" {
                        socialscience23CurrentCreditNumberStringList[1] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "情報" {
                        socialscience23CurrentCreditNumberStringList[2] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "スポ身（必修）"{
                        socialscience23CurrentCreditNumberStringList[3] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初ゼミ文科" {
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初ゼミ理科" {
                        socialscience23CurrentCreditNumberStringList[4] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "社会科学"{
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "人文科学" {
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "基礎実験（自然科学）" {
                        socialscience23CurrentCreditNumberStringList[5] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "数理科学（自然科学）" {
                        socialscience23CurrentCreditNumberStringList[6] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "物質科学（自然科学）"{
                        socialscience23CurrentCreditNumberStringList[7] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "生命科学（自然科学）" {
                        socialscience23CurrentCreditNumberStringList[8] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "L（総合科目）"{
                        socialscience23CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "A（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "B（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "C（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "D（総合科目）"{
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "E（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "F（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "主題科目" {
                        socialscience23CurrentCreditNumberStringList[13] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "展開科目" {
                        socialscience23CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }
                }else{
                    
                }
            }
        }else if userAffiliationLabel.text! == "理科Ⅲ類"{
            for var i in 0 ..< classDataArray.count{
                if classDataArray[i][6] == "追い出し" {
                    socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                }else if classDataArray[i][6] == "通常"{
                    if classDataArray[i][3] == "既修外国語（必修）" {
                        socialscience23CurrentCreditNumberStringList[0] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初修外国語（必修）" {
                        socialscience23CurrentCreditNumberStringList[1] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "情報" {
                        socialscience23CurrentCreditNumberStringList[2] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "スポ身（必修）"{
                        socialscience23CurrentCreditNumberStringList[3] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初ゼミ文科" {
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "初ゼミ理科" {
                        socialscience23CurrentCreditNumberStringList[4] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "社会科学"{
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "人文科学" {
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "基礎実験（自然科学）" {
                        socialscience23CurrentCreditNumberStringList[5] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "数理科学（自然科学）" {
                        socialscience23CurrentCreditNumberStringList[6] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "物質科学（自然科学）"{
                        socialscience23CurrentCreditNumberStringList[7] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "生命科学（自然科学）" {
                        socialscience23CurrentCreditNumberStringList[8] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "L（総合科目）"{
                        socialscience23CurrentCreditNumberStringList[10] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "A（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "B（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "C（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "D（総合科目）"{
                        socialscience23CurrentCreditNumberStringList[11] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "E（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "F（総合科目）" {
                        socialscience23CurrentCreditNumberStringList[12] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "主題科目" {
                        socialscience23CurrentCreditNumberStringList[13] += Int(classDataArray[i][4])!
                    }else if classDataArray[i][3] == "展開科目" {
                        socialscience23CurrentCreditNumberStringList[9] += Int(classDataArray[i][4])!
                        socialscience23CurrentCreditNumberStringList[14] += Int(classDataArray[i][4])!
                    }
                }else{
                    
                }
            }
        }else{
            let alertController = UIAlertController(title: "科類が選択されていません", message: "マイページから科類を選択してください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        //なんでもいいからが多すぎたら
        if liberalarts1CurrentCreditNumberStringList[12] > 4{
            liberalarts1CurrentCreditNumberStringList[12] = 4
        }
        if liberalarts2CurrentCreditNumberStringList[12] > 4{
            liberalarts2CurrentCreditNumberStringList[12] = 4
        }
        if liberalarts3CurrentCreditNumberStringList[12] > 4{
            liberalarts3CurrentCreditNumberStringList[12] = 4
        }
        if socialscienceCurrentCreditNumberStringList[14] > 3{
            socialscienceCurrentCreditNumberStringList[14] = 3
        }
        //合計の値
        for var k in 0 ..< 12{
            liberalarts1CurrentCreditNumberStringList[13] += liberalarts1CurrentCreditNumberStringList[k]
        }
        for var k in 0 ..< 12{
            liberalarts2CurrentCreditNumberStringList[13] += liberalarts2CurrentCreditNumberStringList[k]
        }
        for var k in 0 ..< 12{
            liberalarts3CurrentCreditNumberStringList[13] += liberalarts3CurrentCreditNumberStringList[k]
        }
        for var k in 0 ..< 14{
            socialscienceCurrentCreditNumberStringList[15] += socialscienceCurrentCreditNumberStringList[k]
        }
        for var k in 0 ..< 14{
            socialscience23CurrentCreditNumberStringList[15] += socialscienceCurrentCreditNumberStringList[k]
        }
        
        
    }
    
    
    
    
    //tableview
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "shortageCreditInfoCell")!
        if userAffiliationLabel.text! == "文科Ⅰ類" {
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            var creditnumberLabel = cell.viewWithTag(2) as! UILabel
            var shortageCreditNumberLabel = cell.viewWithTag(3) as! UILabel
            classtypeLabel.text = liberalarts1CreditList[indexPath.row]
            creditnumberLabel.text = String(liberalarts1CurrentCreditNumberStringList[indexPath.row])
            shortageCreditNumberLabel.text = String(liberalarts1CreditNumberIntList[indexPath.row] - liberalarts1CurrentCreditNumberStringList[indexPath.row])
        }else if userAffiliationLabel.text! == "文科Ⅱ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            var creditnumberLabel = cell.viewWithTag(2) as! UILabel
            var shortageCreditNumberLabel = cell.viewWithTag(3) as! UILabel
            classtypeLabel.text = liberalarts2CreditList[indexPath.row]
            creditnumberLabel.text = String(liberalarts2CurrentCreditNumberStringList[indexPath.row])
            shortageCreditNumberLabel.text = String(liberalarts2CreditNumberIntList[indexPath.row] - liberalarts2CurrentCreditNumberStringList[indexPath.row])
            
        }else if userAffiliationLabel.text! == "文科Ⅲ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            var creditnumberLabel = cell.viewWithTag(2) as! UILabel
            var shortageCreditNumberLabel = cell.viewWithTag(3) as! UILabel
            classtypeLabel.text = liberalarts3CreditList[indexPath.row]
            creditnumberLabel.text = String(liberalarts3CurrentCreditNumberStringList[indexPath.row])
            shortageCreditNumberLabel.text = String(liberalarts3CreditNumberIntList[indexPath.row] - liberalarts3CurrentCreditNumberStringList[indexPath.row])
            
        }else if userAffiliationLabel.text! == "理科Ⅰ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            var creditnumberLabel = cell.viewWithTag(2) as! UILabel
            var shortageCreditNumberLabel = cell.viewWithTag(3) as! UILabel
            classtypeLabel.text = socialscienceCreditList[indexPath.row]
            creditnumberLabel.text = String(socialscienceCurrentCreditNumberStringList[indexPath.row])
            shortageCreditNumberLabel.text = String(socialscience1CreditNumberIntList[indexPath.row] - socialscienceCurrentCreditNumberStringList[indexPath.row])
        }else if userAffiliationLabel.text! == "理科Ⅱ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            var creditnumberLabel = cell.viewWithTag(2) as! UILabel
            var shortageCreditNumberLabel = cell.viewWithTag(3) as! UILabel
            classtypeLabel.text = socialscienceCreditList[indexPath.row]
            creditnumberLabel.text = String(socialscience23CurrentCreditNumberStringList[indexPath.row])
            shortageCreditNumberLabel.text = String(socialscience2CreditNumberIntList[indexPath.row] - socialscience23CurrentCreditNumberStringList[indexPath.row])
        }else if userAffiliationLabel.text! == "理科Ⅲ類"{
            let  classtypeLabel = cell.viewWithTag(1) as! UILabel
            var creditnumberLabel = cell.viewWithTag(2) as! UILabel
            var shortageCreditNumberLabel = cell.viewWithTag(3) as! UILabel
            classtypeLabel.text = socialscienceCreditList[indexPath.row]
            creditnumberLabel.text = String(socialscience23CurrentCreditNumberStringList[indexPath.row])
            shortageCreditNumberLabel.text = String(socialscience3CreditNumberIntList[indexPath.row] - socialscience23CurrentCreditNumberStringList[indexPath.row])
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
