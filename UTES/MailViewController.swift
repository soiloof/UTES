//
//  MailViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/20.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import FrostedSidebar
import UITextView_Placeholder
import NCMB

class MailViewController: UIViewController,UITextViewDelegate {
    @IBOutlet var messageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.placeholder = "ここに質問や要望の内容を記述してください"
        messageTextView.delegate = self

        //navigationBar
        //バー背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //バーアイテムカラー
        self.navigationController?.navigationBar.tintColor = UIColor.cyan
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sendMessage(){
        let user = NCMBUser.current()
        user?.setObject(messageTextView.text, forKey: "Message")
        user?.saveInBackground({ (error) in
            if error != nil{
                
            }else{
                let alertController = UIAlertController(title: "送信完了", message: "ご要望質問に関するメッセージの送信に成功しました", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.messageTextView.text = ""
            }
        })
    }
    

    @IBAction func onBurger() {
        (tabBarController as! HomeTabBarController).sidebar.showInViewController(self, animated: true)
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        messageTextView.resignFirstResponder()
        return true
    }

}
