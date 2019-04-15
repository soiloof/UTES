//
//  EditProfileViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/21.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB

class EditProfileViewController:  UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource,  UINavigationControllerDelegate {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var affiliationTextField: UITextField!
 
    var affiliationList = ["文科Ⅰ類", "文科Ⅱ類", "文科Ⅲ類", "理科Ⅰ類", "理科Ⅱ類", "理科Ⅲ類", "その他"]
    
    
    var affiliationPickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //テキストフィールドデリゲートメソッド
        affiliationTextField.delegate = self
        userNameTextField.delegate = self
        userIdTextField.delegate = self
        
      
        
        //pickerview準備
        affiliationPickerView.delegate = self
        affiliationPickerView.dataSource = self
        affiliationPickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(EditProfileViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(EditProfileViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.affiliationTextField.inputView = affiliationPickerView
        self.affiliationTextField.inputAccessoryView = toolbar
        
        
        //NCMBUser設定
        if let user = NCMBUser.current(){
            userNameTextField.text = user.object(forKey: "displayName") as? String
            affiliationTextField.text = user.object(forKey: "affiliation") as? String
            let  userId = user.userName
            userIdTextField.text = userId!
            
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
  
    //完了ボタン
    @IBAction func saveUserInfo(){
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.userName = userIdTextField.text
        user?.setObject(affiliationTextField.text, forKey: "affiliation")
        user?.saveInBackground({ (error) in
            if error != nil{
                
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return affiliationList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return affiliationList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.affiliationTextField.text = affiliationList[row]
    }
    
    @objc func cancel() {
        self.affiliationTextField.text = ""
        self.affiliationTextField.endEditing(true)
    }
    
    @objc func done() {
        self.affiliationTextField.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        affiliationTextField.resignFirstResponder()
        userNameTextField.resignFirstResponder()
        userIdTextField.resignFirstResponder()
        return true
    }
    
}
