//
//  SelectDepartmentViewController.swift
//  UTES
//
//  Created by 土屋光暉 on 2018/07/20.
//  Copyright © 2018年 mitsuki.com. All rights reserved.
//

import UIKit
import FrostedSidebar

class SelectDepartmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataList:[String] = []
    var departmentArray:[[String]] = [[]]
    @IBOutlet var departmentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableview
        departmentTableView.dataSource = self
        departmentTableView.delegate = self
        departmentTableView.allowsMultipleSelection = true

        //navigationBar
        //バー背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //バーアイテムカラー
        self.navigationController?.navigationBar.tintColor = UIColor.cyan
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        //csv読み込み
        do {
            //CSVファイルのパスを取得する。
            let csvPath = Bundle.main.path(forResource: "department_data", ofType: "csv")
            
            //CSVファイルのデータを取得する。
            let csvData = try String(contentsOfFile:csvPath!, encoding:String.Encoding.utf8)
            
            //改行区切りでデータを分割して配列に格納する。
            dataList = csvData.components(separatedBy:"\n")
            
        } catch {
            
        }
        makeDepartmentArray()
        
       
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func makeDepartmentArray(){
        departmentArray.removeFirst()
        for i in 0 ... dataList.count-1 {
            let dataDetail = dataList[i].components(separatedBy:",")
            departmentArray.append(dataDetail)
        }
        
    }
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentArray.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentCell")!
        
        let departmentNameLabel = cell.viewWithTag(1) as! UILabel
        let departmentDetailNameLabel = cell.viewWithTag(2) as! UILabel
        departmentNameLabel.text = departmentArray[indexPath.row][1]
        departmentDetailNameLabel.text = departmentArray[indexPath.row][2]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        departmentArray[indexPath.row][3] = "true"
    }
    
    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを外す
        cell?.accessoryType = .none
        departmentArray[indexPath.row][3] = "false"
    }
    
    
    
    @IBAction func saveHopedDepartmentArray(){
        var selectedDepartmentArray:[[String]] = [[]]
        for i in 0 ... departmentArray.count-2 {
            if departmentArray[i][3] == "true"{
                selectedDepartmentArray.append(departmentArray[i])
            }
        }
        let ud = UserDefaults.standard
        ud.set(selectedDepartmentArray, forKey: "selectedDepartmentArray")
        ud.synchronize()
        //保存完了アラート
        let alertController = UIAlertController(title: "保存完了", message: "あなたの希望学部の選択が完了しました", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    

    @IBAction func onBurger() {
        (tabBarController as! HomeTabBarController).sidebar.showInViewController(self, animated: true)
    }

}
