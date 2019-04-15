//
//  CalculateViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/16.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB

class CalculateViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var classDataTableView: UITableView!
    
    @IBOutlet var calculateTypeTextField: UITextField!
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var currentScoreLabel: UILabel!
    @IBOutlet var creditnumberLabel: UILabel!
    @IBOutlet var idealScoreTextField: UITextField!
    @IBOutlet var needingCreditNumberLabel: UILabel!
    @IBOutlet var shortageCreditNumberLabel: UILabel!
    @IBOutlet var needingScoreAverageLabel: UILabel!
    @IBOutlet var userAffiliationLabel: UILabel!
    
    
    
    var classDataArray = [[String]] ()
    
    var calculateTypePickerView: UIPickerView = UIPickerView()
    var selectedCalculateTypePickerView = UIPickerView()
    
    
    let calculateTypeList = ["","基本平均点", "指定平均点（工学部）","指定平均点（農学部）"]
    
    
    //計算に用いる変数
    var specialRateArray = [Double]()
    var Score = Double()
    var numeratorSum: Double = 0.0
    var denominatorSum = 0.0
    var outofClassCreditNumberSum = 0.0
    var needingCreditNumber = 0.0
    var shortageCreditNumber = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationBar
        //バー背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //バーアイテムカラー
        self.navigationController?.navigationBar.tintColor = UIColor.cyan
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        

        //tableviewはデータソースメソッド
        classDataTableView.dataSource = self
        
        //tableviewはデリゲートメソッド
        classDataTableView.delegate = self
        
        //カスタムセルの登録
        let nib = UINib(nibName: "ClassDataTableViewCell", bundle: Bundle.main)
        
        classDataTableView.register(nib, forCellReuseIdentifier: "DetailCell")
        
        //いらないセルを消去
        classDataTableView.tableFooterView = UIView()
        
        
        
        //テキストフィールド
        calculateTypeTextField.delegate = self
        idealScoreTextField.delegate = self
        
        
        
        //pickerviewcontroller
        calculateTypePickerView.delegate = self
        calculateTypePickerView.dataSource = self
        calculateTypePickerView.showsSelectionIndicator = true
        calculateTypePickerView.tag = 1
        
        
        
        
        
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CalculateViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CalculateViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        
        self.calculateTypeTextField.inputView = calculateTypePickerView
        self.calculateTypeTextField.inputAccessoryView = toolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadClassData()
        getAffiliationData()
        loadIdealScore()
        loadCalculateType()
    }
    

    //理想値を変更するボタン
    @IBAction func plus1IdealText(){
        var idealScoreDouble = atof(idealScoreTextField.text)
        idealScoreDouble += 1.00
        idealScoreTextField.text = String(floor(idealScoreDouble * 10) / 10)
    }
    @IBAction func minus1IdealText(){
        var idealScoreDouble = atof(idealScoreTextField.text)
        idealScoreDouble -= 1.00
        idealScoreTextField.text = String(floor(idealScoreDouble * 10) / 10)
    }
    @IBAction func plus01IdealText(){
        var idealScoreDouble = atof(idealScoreTextField.text)
        idealScoreDouble += 0.10
        idealScoreTextField.text = String(floor(idealScoreDouble * 10) / 10)
    }
    @IBAction func minus01IdealText(){
        var idealScoreDouble = atof(idealScoreTextField.text)
        idealScoreDouble -= 0.10
        idealScoreTextField.text = String(floor(idealScoreDouble * 10) / 10)
    }
    
    
    
    
    //tableviewの内容
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return classDataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(classDataArray)
        let cell = classDataTableView.dequeueReusableCell(withIdentifier: "DetailCell") as! ClassDataTableViewCell
        cell.classnameTextField.text = classDataArray[indexPath.row][0]
        cell.teachernameTextField.text = classDataArray[indexPath.row][1]
        cell.classTimeInfoTextField1.text = classDataArray[indexPath.row][2]
        cell.classtypeTextField.text = classDataArray[indexPath.row][3]
        cell.creditnumberTextField.text = classDataArray[indexPath.row][4]
        cell.scoreTextField.text = classDataArray[indexPath.row][5]
        cell.scoretypeTextField.text = classDataArray[indexPath.row][6]
        cell.classDataArray = classDataArray[indexPath.row]
        cell.viewController = self
        cell.tag = indexPath.row
        return cell
        
    }
    
    //classdataを取得
    func loadClassData(){
        
        let ud = UserDefaults.standard
        if ud.array(forKey: "classArray") != nil{
            classDataArray = ud.array(forKey: "classArray") as! [[String]]
            classDataTableView.reloadData()
        }else{
        }
    }
    
    //理想点の取得
    func loadIdealScore(){
        let ud = UserDefaults.standard
        if ud.array(forKey: "idealScore") != nil{
            idealScoreTextField.text = ud.array(forKey: "idealScore")?.last as! String
        }else{
        }
    }
    //計算方式の取得
    func loadCalculateType(){
        let ud = UserDefaults.standard
        if ud.array(forKey: "CalculateType") != nil{
            calculateTypeTextField.text = ud.array(forKey: "CalculateType")?.last as! String
        }else{
        }
    }
    
    
    //文理科類の情報を取得
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
    
    
    //計算に関する関数
    @IBAction func calculateScore(){
        specialRateArray = []
        
        if calculateTypeTextField.text != nil {
            //基本平均点が選択されている時
            if calculateTypeTextField.text == "基本平均点" {
                
                //重率の取得
                for var i in 0 ..< classDataArray.count{
                    if classDataArray[i][6] == "通常"{
                        specialRateArray.append(1.0)
                    }else if classDataArray[i][6] == "追い出し"{
                        specialRateArray.append(0.10)
                    }else if classDataArray[i][6] == "ノーカウント"{
                        specialRateArray.append(0.0)
                    }else{
                        //追い出し情報選択を促すアラート
                        let alertController = UIAlertController(title: "形式が選択されていません", message: "形式情報を上のセルから選択してください", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                            
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
                //単位数*重率の値の和を取得
                denominatorSum = 0.0
                for var b in 0 ..< classDataArray.count{
                    denominatorSum += atof(classDataArray[b][4]) * specialRateArray[b]
                }
                
                //得点＊単位数＊重率の値を取得し和を計算する。
                numeratorSum = 0.0
                for var k in 0 ..< classDataArray.count{
                    numeratorSum += atof(classDataArray[k][5]) * atof(classDataArray[k][4]) * specialRateArray[k]
                }
                
                //追い出しの数*重率＊単位数を計算
                outofClassCreditNumberSum = 0.0
                for var d in 0 ..< classDataArray.count{
                    if classDataArray[d][6] == "追い出し"{
                        outofClassCreditNumberSum += specialRateArray[d] * atof(classDataArray[d][4])
                    }else{
                        outofClassCreditNumberSum += 0
                    }
                    
                }
                
                //必要単位数の表示
                if userAffiliationLabel.text != nil{
                    
                    if userAffiliationLabel.text == "文科Ⅰ類" || userAffiliationLabel.text == "文科Ⅱ類" || userAffiliationLabel.text == "文科Ⅲ類"{
                        needingCreditNumber = 50.0 + outofClassCreditNumberSum
                    }else if userAffiliationLabel.text == "理科Ⅱ類" || userAffiliationLabel.text == "理科Ⅲ類"{
                        needingCreditNumber = 57.0 + outofClassCreditNumberSum
                    }else if userAffiliationLabel.text == "理科Ⅰ類" {
                        needingCreditNumber = 56.0 + outofClassCreditNumberSum
                    }else{
                        
                    }
                    //科類選択nil
                }else{
                    //科類選択を促すアラート
                    let alertController = UIAlertController(title: "科類が設定されていません", message: "科類をマイページから選択してください", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                needingCreditNumberLabel.text = String(needingCreditNumber)
                //不足単位数の表示
                shortageCreditNumber = needingCreditNumber - denominatorSum
                shortageCreditNumberLabel.text = String(shortageCreditNumber)
                
                //現基本平均点の計算
                Score = numeratorSum / denominatorSum
                
                //基本平均点の表示
                currentScoreLabel.text = String(round(Score * 10) / 10)
                //savescore
                if classDataArray != nil{
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "CurrentScore") != nil{
                        var saveScore = ud.array(forKey: "CurrentScore") as! [String]
                        saveScore.append(String(round(Score * 100) / 100))
                        ud.set(saveScore, forKey: "CurrentScore")
                    }else{
                        var newScore = [String]()
                        newScore.append(String(round(Score * 100) / 100))
                        ud.set(newScore, forKey: "CurrentScore")
                    }
                    ud.synchronize()
                }
                
                //単位数の和の表示
                creditnumberLabel.text = String(round(denominatorSum * 10) / 10)
                //savescore
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "CurrentCreditNumber") != nil{
                        var saveScore = ud.array(forKey: "CurrentCreditNumber") as! [String]
                        saveScore.append(creditnumberLabel.text!)
                        ud.set(saveScore, forKey: "CurrentCreditNumber")
                    }else{
                        var newScore = [String]()
                        newScore.append(creditnumberLabel.text!)
                        ud.set(newScore, forKey: "CurrentCreditNumber")
                    }
                    ud.synchronize()
                
                
                //理想点と必要平均点
                //理想点の保存
                if idealScoreTextField.text != nil{
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "idealScoreArray") != nil {
                        var saveIdealScoreArray = ud.array(forKey: "idealScore") as! [String]
                        saveIdealScoreArray.append(idealScoreTextField.text!)
                        ud.set(saveIdealScoreArray, forKey: "idealScore")
                    }else{
                        var newIdealSocreArray = [String]()
                        newIdealSocreArray.append(idealScoreTextField.text!)
                        ud.set(newIdealSocreArray, forKey: "idealScore")
                        
                    }
                    ud.synchronize()
                    
                    let needingScoreAverage = (atof(idealScoreTextField.text) * needingCreditNumber - numeratorSum) / shortageCreditNumber
                    needingScoreAverageLabel.text = String(round(needingScoreAverage * 100) / 100)
                }else{
                    //記入を促すアラート
                    let alertController = UIAlertController(title: "理想平均点が不適切です。", message: "理想平均点を正しく入力してください。（半角で小数点まで記入）", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
                //実基本平均点の計算
                Score = numeratorSum / needingCreditNumber
                
                //実基本平均点の表示
                var thousandtimesScore = 0.0
                thousandtimesScore = Score * 1000
                scoreLabel.text = String(round(thousandtimesScore) / 1000)
                
                //savescore
                if classDataArray != nil{
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "DefaultScore") != nil{
                        var saveScore = ud.array(forKey: "DefaultScore") as! [String]
                        saveScore.append(String(round(Score * 100) / 100))
                        ud.set(saveScore, forKey: "DefaultScore")
                    }else{
                        var newScore = [String]()
                        newScore.append(String(round(Score * 100) / 100))
                        ud.set(newScore, forKey: "DefaultScore")
                    }
                    ud.synchronize()
                }else{
                    //成績情報が空を注意するアラート
                    let alertController = UIAlertController(title: "成績情報が入力されていません。", message: "成績情報を右上の+ボタンから登録してください", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                if ud.array(forKey: "CalculateType") != nil{
                    var saveCalculateType = ud.array(forKey: "CalculateType") as! [String]
                    saveCalculateType.append(calculateTypeTextField.text!)
                    ud.set(saveCalculateType, forKey: "CalculateType")
                }else{
                    var newCalculateType = [String]()
                    newCalculateType.append(calculateTypeTextField.text!)
                    ud.set(newCalculateType, forKey: "CalculateType")
                }
                ud.synchronize()
                
                
            }//工学部指定平均
            else if calculateTypeTextField.text == "指定平均点（工学部）" {
                //重率の取得
                for var i in 0 ..< classDataArray.count{
                    if classDataArray[i][6] == "通常"{
                        specialRateArray.append(1.0)
                    }else if classDataArray[i][6] == "追い出し"{
                        specialRateArray.append(0.10)
                    }else if classDataArray[i][6] == "ノーカウント"{
                        specialRateArray.append(0.0)
                    }else{
                        //追い出し情報選択を促すアラート
                        let alertController = UIAlertController(title: "形式が選択されていません", message: "形式情報を上のセルから選択してください", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                            
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
                numeratorSum = 0.0
                for k in 0 ..< classDataArray.count{
                    if  atof(classDataArray[k][5]) < 50 {
                        numeratorSum += 0.0
                    }else if atof(classDataArray[k][5]) >= 50 && atof(classDataArray[k][5]) < 55 {
                        numeratorSum += 1.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 55 && atof(classDataArray[k][5]) < 60 {
                        numeratorSum += 2.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 60 && atof(classDataArray[k][5]) < 65 {
                        numeratorSum += 3.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 65 && atof(classDataArray[k][5]) < 70 {
                        numeratorSum += 4.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 70 && atof(classDataArray[k][5]) < 75 {
                        numeratorSum += 5.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 75 && atof(classDataArray[k][5]) < 80 {
                        numeratorSum += 6.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 80 && atof(classDataArray[k][5]) < 85 {
                        numeratorSum += 7.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 85 && atof(classDataArray[k][5]) < 90 {
                        numeratorSum += 8.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 90 && atof(classDataArray[k][5]) < 95 {
                        numeratorSum += 9.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }else if atof(classDataArray[k][5]) >= 95 && atof(classDataArray[k][5]) < 100 {
                        numeratorSum += 10.0 * atof(classDataArray[k][4]) * specialRateArray[k]
                    }
                }
                //追い出しの数*重率＊単位数を計算
                outofClassCreditNumberSum = 0
                for var d in 0 ..< classDataArray.count{
                    if classDataArray[d][6] == "追い出し"{
                        outofClassCreditNumberSum += specialRateArray[d] * atof(classDataArray[d][4])
                    }else{
                        outofClassCreditNumberSum += 0
                    }
                }
                
                //必要単位数の表示
                if userAffiliationLabel.text != nil{
                    
                    if userAffiliationLabel.text == "文科Ⅰ類" || userAffiliationLabel.text == "文科Ⅱ類" || userAffiliationLabel.text == "文科Ⅲ類"{
                        needingCreditNumber = 50.0 + outofClassCreditNumberSum
                    }else if userAffiliationLabel.text == "理科Ⅱ類" || userAffiliationLabel.text == "理科Ⅲ類"{
                        needingCreditNumber = 57.0 + outofClassCreditNumberSum
                    }else if userAffiliationLabel.text == "理科Ⅰ類" {
                        needingCreditNumber = 56.0 + outofClassCreditNumberSum
                    }else{
                        
                    }
                    //科類選択nil
                }else{
                    //科類選択を促すアラート
                    let alertController = UIAlertController(title: "科類が設定されていません", message: "科類をマイページから選択してください", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                //単位数*重率の値の和を取得
                denominatorSum = 0.0
                for var b in 0 ..< classDataArray.count{
                    denominatorSum += atof(classDataArray[b][4]) * specialRateArray[b]
                }
                
                //現工学部指定平均の計算
                Score = numeratorSum / denominatorSum
                
                //工学部指定平均の表示
                currentScoreLabel.text = String(round(Score * 100) / 100)
                //単位数の和の表示
                var tentimesDenominatorSum = 0.0
                tentimesDenominatorSum = denominatorSum * 10
                creditnumberLabel.text = String(round(tentimesDenominatorSum) / 10)
                
                //理想点と必要平均点
                //理想点の保存
                if atof(idealScoreTextField.text) <= 10.0 {
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "idealScoreArray") != nil {
                        var saveIdealScoreArray = ud.array(forKey: "idealScore") as! [String]
                        saveIdealScoreArray.append(idealScoreTextField.text!)
                        ud.set(saveIdealScoreArray, forKey: "idealScore")
                    }else{
                        var newIdealSocreArray = [String]()
                        newIdealSocreArray.append(idealScoreTextField.text!)
                        ud.set(newIdealSocreArray, forKey: "idealScore")
                        
                    }
                    ud.synchronize()
                    
                    let needingScoreAverage = (atof(idealScoreTextField.text) * needingCreditNumber - numeratorSum) / shortageCreditNumber
                    needingScoreAverageLabel.text = String(round(needingScoreAverage * 100) / 100)
                }else{
                    //記入を促すアラート
                    let alertController = UIAlertController(title: "理想平均点が不適切です。", message: "理想平均点を正しく入力してください。（10.0以下の半角数字）", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                //工学部指定平均の計算
                Score = numeratorSum / needingCreditNumber
                
                //工学部指定平均の表示
                var thousandtimesScore = 0.0
                thousandtimesScore = Score * 1000
                scoreLabel.text = String(round(thousandtimesScore) / 1000)
                
                //savescore
                if classDataArray.count > 0{
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "EngineeringScore") != nil{
                        var saveScore = ud.array(forKey: "EngineeringScore") as! [String]
                        saveScore.append(String(round(Score * 100) / 100))
                        ud.set(saveScore, forKey: "EngineeringScore")
                    }else{
                        var newScore = [String]()
                        newScore.append(String(round(Score * 100) / 100))
                        ud.set(newScore, forKey: "EngineeringScore")
                    }
                    ud.synchronize()
                }else{
                    //成績情報が空を注意するアラート
                    let alertController = UIAlertController(title: "成績情報が入力されていません。", message: "成績情報を右上の+ボタンから登録してください", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                let ud = UserDefaults.standard
                if ud.array(forKey: "CalculateType") != nil{
                    var saveCalculateType = ud.array(forKey: "CalculateType") as! [String]
                    saveCalculateType.append(calculateTypeTextField.text!)
                    ud.set(saveCalculateType, forKey: "CalculateType")
                }else{
                    var newCalculateType = [String]()
                    newCalculateType.append(calculateTypeTextField.text!)
                    ud.set(newCalculateType, forKey: "CalculateType")
                }
                ud.synchronize()
                
                
                
            }else if calculateTypeTextField.text == "指定平均点（農学部）"{
                //重率の取得
                for var i in 0 ..< classDataArray.count{
                    if classDataArray[i][6] == "通常"{
                        specialRateArray.append(1.0)
                    }else if classDataArray[i][6] == "追い出し"{
                        specialRateArray.append(0.10)
                    }else if classDataArray[i][6] == "ノーカウント"{
                        specialRateArray.append(0.0)
                    }else{
                        //追い出し情報選択を促すアラート
                        let alertController = UIAlertController(title: "形式が選択されていません", message: "形式情報を上のセルから選択してください", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                            
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
                //単位数*重率の値の和を取得
                denominatorSum = 0.0
                for var b in 0 ..< classDataArray.count{
                    denominatorSum += atof(classDataArray[b][4]) * specialRateArray[b]
                }
                
                //得点＊単位数＊重率の値を取得し和を計算する。
                numeratorSum = 0.0
                for var k in 0 ..< classDataArray.count{
                    numeratorSum += atof(classDataArray[k][5]) * atof(classDataArray[k][4]) * specialRateArray[k]
                }
                
                //追い出しの数*重率＊単位数を計算
                outofClassCreditNumberSum = 0.0
                for var d in 0 ..< classDataArray.count{
                    if classDataArray[d][6] == "追い出し"{
                        outofClassCreditNumberSum += specialRateArray[d] * atof(classDataArray[d][4])
                    }else{
                        outofClassCreditNumberSum += 0
                    }
                    
                }
                
                //必要単位数の表示
                if userAffiliationLabel.text != nil{
                    
                    if userAffiliationLabel.text == "文科Ⅰ類" || userAffiliationLabel.text == "文科Ⅱ類" || userAffiliationLabel.text == "文科Ⅲ類"{
                        needingCreditNumber = 50.0 + outofClassCreditNumberSum
                    }else if userAffiliationLabel.text == "理科Ⅱ類" || userAffiliationLabel.text == "理科Ⅲ類"{
                        needingCreditNumber = 57.0 + outofClassCreditNumberSum
                    }else if userAffiliationLabel.text == "理科Ⅰ類" {
                        needingCreditNumber = 56.0 + outofClassCreditNumberSum
                    }else{
                        
                    }
                    //科類選択nil
                }else{
                    //科類選択を促すアラート
                    let alertController = UIAlertController(title: "科類が設定されていません", message: "科類をマイページから選択してください", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                needingCreditNumberLabel.text = String(needingCreditNumber)
                //不足単位数の表示
                shortageCreditNumber = needingCreditNumber - denominatorSum
                shortageCreditNumberLabel.text = String(shortageCreditNumber)
                var creditnumberSum: Double = 0.0
                for j in 0 ..< classDataArray.count{
                    creditnumberSum += atof(classDataArray[j][4])
                }
                //現基本平均点の計算
                Score = (numeratorSum / denominatorSum ) * creditnumberSum
                
                //基本平均点の表示
                currentScoreLabel.text = String(round(Score * 10) / 10)
                
                
                //単位数の和の表示
                creditnumberLabel.text = String(round(denominatorSum * 10) / 10)
                
                //理想点と必要平均点
                //理想点の保存
                if idealScoreTextField.text != nil{
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "idealScoreArray") != nil {
                        var saveIdealScoreArray = ud.array(forKey: "idealScore") as! [String]
                        saveIdealScoreArray.append(idealScoreTextField.text!)
                        ud.set(saveIdealScoreArray, forKey: "idealScore")
                    }else{
                        var newIdealSocreArray = [String]()
                        newIdealSocreArray.append(idealScoreTextField.text!)
                        ud.set(newIdealSocreArray, forKey: "idealScore")
                        
                    }
                    ud.synchronize()
                    
                    let needingScoreAverage = (atof(idealScoreTextField.text) * needingCreditNumber - numeratorSum) / shortageCreditNumber
                    needingScoreAverageLabel.text = String(round(needingScoreAverage * 100) / 100)
                }else{
                    //記入を促すアラート
                    let alertController = UIAlertController(title: "理想平均点が不適切です。", message: "理想平均点を正しく入力してください。（半角で小数点まで記入）", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
                //実基本平均点の計算
                Score = (numeratorSum / needingCreditNumber) * creditnumberSum
                
                //実基本平均点の表示
                var thousandtimesScore = 0.0
                thousandtimesScore = Score * 1000
                scoreLabel.text = String(round(thousandtimesScore) / 1000)
                
                //savescore
                if classDataArray != nil{
                    let ud = UserDefaults.standard
                    if ud.array(forKey: "AgricultureScore") != nil{
                        var saveScore = ud.array(forKey: "AgricultureScore") as! [String]
                        saveScore.append(String(round(Score * 100) / 100))
                        ud.set(saveScore, forKey: "AgricultureScore")
                    }else{
                        var newScore = [String]()
                        newScore.append(String(round(Score * 100) / 100))
                        ud.set(newScore, forKey: "AgricultureScore")
                    }
                    ud.synchronize()
                }else{
                    //成績情報が空を注意するアラート
                    let alertController = UIAlertController(title: "成績情報が入力されていません。", message: "成績情報を右上の+ボタンから登録してください", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                let ud = UserDefaults.standard
                if ud.array(forKey: "CalculateType") != nil{
                    var saveCalculateType = ud.array(forKey: "CalculateType") as! [String]
                    saveCalculateType.append(calculateTypeTextField.text!)
                    ud.set(saveCalculateType, forKey: "CalculateType")
                }else{
                    var newCalculateType = [String]()
                    newCalculateType.append(calculateTypeTextField.text!)
                    ud.set(newCalculateType, forKey: "CalculateType")
                }
                ud.synchronize()
                
                
                
                
                
                
            }
                //基本平均点以外
            else{
                let alertController = UIAlertController(title: "お詫び", message: "まだ実装されておりません次のアップデートをお待ちください", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }else if calculateTypeTextField.text == "" {
            let alertController = UIAlertController(title: "計算方式が入力されていません", message: "計算方式を選択してください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertController.dismiss(animated: true, completion: nil)
                
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    //pickerviewcontroller
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1{
            return 1
        }else{
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return calculateTypeList.count
        }else{
            return calculateTypeList.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return calculateTypeList[row]
        }else{
            return calculateTypeList[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.calculateTypeTextField.text = calculateTypeList[row]
        }
    }
    
    @objc func cancel() {
        self.calculateTypeTextField.text = ""
        self.calculateTypeTextField.endEditing(true)
        
    }
    
    @objc func done() {
        self.calculateTypeTextField.endEditing(true)
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    
    //deselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    //キーボード閉じの関数
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idealScoreTextField.resignFirstResponder()
        calculateTypeTextField.resignFirstResponder()
        
        
        return true
    }

}
