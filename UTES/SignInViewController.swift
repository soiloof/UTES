//
//  SignInViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/16.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet var useridTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwardTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    @IBOutlet var affiliationTextField: UITextField!
    
    var affiliationList = ["文科Ⅰ類", "文科Ⅱ類", "文科Ⅲ類", "理科Ⅰ類", "理科Ⅱ類", "理科Ⅲ類", "その他"]
    
    
    var affiliationPickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        useridTextField.delegate = self
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwardTextField.delegate = self
        confirmTextField.delegate = self
        affiliationTextField.delegate = self
        
        //pickerview準備
        affiliationPickerView.delegate = self
        affiliationPickerView.dataSource = self
        affiliationPickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SignInViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SignInViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.affiliationTextField.inputView = affiliationPickerView
        self.affiliationTextField.inputAccessoryView = toolbar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //キーボードとじる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmTextField.resignFirstResponder()
        passwardTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        useridTextField.resignFirstResponder()
        userNameTextField.resignFirstResponder()
        affiliationTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func signUp(){
        let user = NCMBUser()
        //useridの文字数制限
        if (useridTextField.text?.characters.count)! != 10 {
            let alertController = UIAlertController(title: "登録失敗", message: "ユーザーidの桁数が間違っています。ユーザーidは１０桁のものを使用してください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertController.dismiss(animated: true, completion: nil)
                
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        user.userName = useridTextField.text!
        user.mailAddress = emailTextField.text!
        //パスワードの確認
        if passwardTextField.text == confirmTextField.text {
            user.password = passwardTextField.text!
        }else{
            print("パスワードの不一致")
        }
        user.signUpInBackground { (error) in
            if error != nil{
                //アラート
                let alertController = UIAlertController(title: "登録失敗", message: "ユーザーidが不正または既に登録されているものであるかメールアドレスが正しく記入されていません", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                let currentUser = NCMBUser.current()
                currentUser?.setObject(self.affiliationTextField.text, forKey: "affiliation")
                currentUser?.setObject(self.userNameTextField.text, forKey: "displayName")
                currentUser?.saveInBackground({ (error) in
                    if error != nil{
                        //アラート
                        let alertController = UIAlertController(title: "登録失敗", message: "科類選択またはユーザー名の記入が行われていません", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                            
                        }
                    }else{
                        //説明画面へ
                        let storyboard = UIStoryboard(name: "Explanation", bundle: Bundle.main)
                        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController")
                        UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    }
                })
                
            }
        }
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


}
