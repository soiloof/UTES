//
//  RegisterViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/16.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var classnameTextField: UITextField!
    @IBOutlet var teachernameTextField: UITextField!
    @IBOutlet var classTimeInfoTextField1: UITextField!
    
    @IBOutlet var classtypeTextField: UITextField!
    @IBOutlet var creditnumberTextField: UITextField!
    @IBOutlet var scoreTextField: UITextField!
    @IBOutlet var scoretypeTextField: UITextField!
    
    
    
    
    
    var classtypePickerView: UIPickerView = UIPickerView()
    var creditnumberPickerView: UIPickerView = UIPickerView()
    var scoretypePickerView: UIPickerView = UIPickerView()
    var classTimeInfoPickerView: UIPickerView = UIPickerView()
    
    
    
    
    
    
    let classtypeList = ["","既修外国語（必修）", "初修外国語（必修）", "情報", "スポ身（必修）",
                         "初ゼミ文科", "初ゼミ理科", "社会科学", "人文科学",
                         "基礎実験（自然科学）", "数理科学（自然科学）", "物理科学（自然科学）","生命科学（自然科学）",
                         "L（総合科目）", "A（総合科目）", "B（総合科目）", "C（総合科目）",
                         "D（総合科目）", "E（総合科目）", "F（総合科目）", "主題科目", "展開科目"]
    
    
    let creditnumberList = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let scoretypeList = ["", "通常", "追い出し", "ノーカウント"]
    let classTimeInfoList1 = [["", "2016年度", "2017年度", "2018年度", "2019年度", "2020年度", "2021年度"], ["","Sセメスター", "Aセメスター", "S1ターム", "S2ターム", "A1ターム", "A2ターム"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //テキストフィールドデリゲートメソッド
        classnameTextField.delegate = self
        teachernameTextField.delegate = self
        classtypeTextField.delegate = self
        creditnumberTextField.delegate = self
        scoreTextField.delegate = self
        scoretypeTextField.delegate = self
        classTimeInfoTextField1.delegate = self
        
        
        
        
        //PickerViewの事前準備
        classtypePickerView.delegate = self
        classtypePickerView.dataSource = self
        classtypePickerView.showsSelectionIndicator = true
        classtypePickerView.tag = 1
        
        creditnumberPickerView.delegate = self
        creditnumberPickerView.dataSource = self
        creditnumberPickerView.showsSelectionIndicator = true
        creditnumberPickerView.tag = 2
        
        scoretypePickerView.delegate = self
        scoretypePickerView.dataSource = self
        scoretypePickerView.showsSelectionIndicator = true
        scoretypePickerView.tag = 3
        
        classTimeInfoPickerView.delegate = self
        classTimeInfoPickerView.dataSource = self
        classTimeInfoPickerView.showsSelectionIndicator = true
        classTimeInfoPickerView.tag = 4
        
        
        
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(RegisterViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(RegisterViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        
        self.classtypeTextField.inputView = classtypePickerView
        self.classtypeTextField.inputAccessoryView = toolbar
        
        self.creditnumberTextField.inputView = creditnumberPickerView
        self.creditnumberTextField.inputAccessoryView = toolbar
        
        self.scoretypeTextField.inputView = scoretypePickerView
        self.scoretypeTextField.inputAccessoryView = toolbar
        
        self.classTimeInfoTextField1.inputView = classTimeInfoPickerView
        self.classTimeInfoTextField1.inputAccessoryView = toolbar
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveData(){
        
        let classnameInputText = classnameTextField.text
        let teachernameInputText = teachernameTextField.text
        let classTimeInfoInputText = classTimeInfoTextField1.text
        
        let classtypeText = classtypeTextField.text
        let numberInputText = creditnumberTextField.text
        let scoreInputText = scoreTextField.text
        let scoretypeInputText = scoretypeTextField.text
        
        //classArrayのセーブ
        let classArray = [classnameInputText, teachernameInputText, classTimeInfoInputText, classtypeText, numberInputText, scoreInputText, scoretypeInputText] as! [String]
        
        let ud = UserDefaults.standard
        if ud.array(forKey: "classArray") != nil {
            var saveClassArray = ud.array(forKey: "classArray") as! [[String]]
            if classtypeText != nil && numberInputText != nil && scoreInputText != nil && scoretypeInputText != nil{
                saveClassArray.append(classArray)
                print(saveClassArray)
            }else{
                print("授業名が入力されていません")
            }
            ud.set(saveClassArray, forKey: "classArray")
        }else{
            var newClassArray = [[String]]()
            if classtypeText != nil && numberInputText != nil && scoreInputText != nil && scoretypeInputText != nil  {
                newClassArray.append(classArray)
                
            }else{
                print("授業名が入力されていません")
            }
            ud.set(newClassArray, forKey: "classArray")
            
        }
        ud.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    //キーボード閉じの関数
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        classnameTextField.resignFirstResponder()
        teachernameTextField.resignFirstResponder()
        classtypeTextField.resignFirstResponder()
        creditnumberTextField.resignFirstResponder()
        scoreTextField.resignFirstResponder()
        scoretypeTextField.resignFirstResponder()
        classTimeInfoTextField1.resignFirstResponder()
        
        return true
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1  {
            return 1
        }else if pickerView.tag == 2 {
            return 1
        }else if pickerView.tag == 3{
            return 1
        }else if pickerView.tag == 4{
            return 2
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            
            return  classtypeList.count
        }else if pickerView.tag == 2{
            return creditnumberList.count
            
        }else if pickerView.tag == 3{
            return scoretypeList.count
        }else if pickerView.tag == 4{
            return classTimeInfoList1[component].count
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return classtypeList[row]
        }else if pickerView.tag == 2{
            return creditnumberList[row]
        }else if pickerView.tag == 3{
            return scoretypeList[row]
        }else if pickerView.tag == 4{
            return classTimeInfoList1[component][row]
            
            
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.classtypeTextField.text = classtypeList[row]
            if classtypeTextField.text == "主題科目" || classtypeTextField.text == "初ゼミ理科"{
                classtypeTextField.text = String()
                let alertController = UIAlertController(title: "計算上必要のない科目区分です。", message: "この科目区分の授業は登録不要です。単位の取得は怠らないようにしましょう", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                classtypeTextField.text = classtypeList[row]
            }
            
            
        }else if pickerView.tag == 2{
            self.creditnumberTextField.text = creditnumberList[row]
        }else if pickerView.tag == 3{
            self.scoretypeTextField.text = scoretypeList[row]
        }else if pickerView.tag == 4{
            
            let data1 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
            let data2 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)
            
            self.classTimeInfoTextField1.text = "\(data1!)　\(data2!)"
            
            
            
        }
    }
    
    @objc func cancel() {
        
        self.classtypeTextField.text = ""
        self.classtypeTextField.endEditing(true)
        self.creditnumberTextField.text = ""
        self.creditnumberTextField.endEditing(true)
        self.scoretypeTextField.text = ""
        self.scoretypeTextField.endEditing(true)
        self.classTimeInfoTextField1.text = ""
        self.classTimeInfoTextField1.endEditing(true)
        
        
    }
    
    @objc func done() {
        self.classtypeTextField.endEditing(true)
        self.creditnumberTextField.endEditing(true)
        self.scoretypeTextField.endEditing(true)
        self.classTimeInfoTextField1.endEditing(true)
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }

}
