//
//  LoginViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/15.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import NCMB

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var useridTextField: UITextField!
    @IBOutlet var passwardTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        useridTextField.delegate = self
        passwardTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwardTextField.resignFirstResponder()
        useridTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func login(){
        
        if (useridTextField.text?.characters.count)! > 0 &&
            (passwardTextField.text?.characters.count)! > 0{
            
            NCMBUser.logInWithUsername(inBackground: useridTextField.text!, password: passwardTextField.text!)
            {(user, error) in
                if error != nil{
                    //保存完了アラート
                    let alertController = UIAlertController(title: "ログイン失敗", message: "パスワードまたはユーサーidが違います", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
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
            
            
        }
        
    }
    
    
    @IBAction func forgetpassward(){
        //置いとく
        
    }
}
