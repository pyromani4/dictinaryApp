//
//  AddFileViewController.swift
//  dictionary
//
//  Created by RS on 2017/10/30.
//  Copyright © 2017年 RS. All rights reserved.
//

import UIKit

class AddFileViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    var files: [String] = []
    var dict: [String:[String]] = [:]
    var value: [String:[String]] = [:]
    var fKey: String = ""
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self as UITextFieldDelegate
        titleField.placeholder = "ここに入力"
        
        if (userDefaults.array(forKey: "files") != nil){
            files = userDefaults.array(forKey: "files") as! [String]
        }
        
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[String]]
        }
        
        if (userDefaults.object(forKey: "value") != nil){
            value = userDefaults.object(forKey: "value")! as! [String:[String]]
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addFile(){
        titleField.placeholder = "ファイル名"
        if titleField.text == "" {
            titleField.placeholder = "ファイル名を入力してください"
        }else{
            let fileName = titleField.text as! String
            files.append(fileName)
            dict[fileName] = []
            value[fileName] = []
            titleField.text = String("")
            userDefaults.set(files, forKey: "files")
            userDefaults.set(dict, forKey: "dict")
            userDefaults.set(value, forKey: "value")
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        titleField.resignFirstResponder()
//        titleField.placeholder = "ここに入力"
//        if titleField.text == "" {
//        }else{
//            let fileName = titleField.text as! String
//            files.append(fileName)
//            titleField.text = String("")
//        }
//        userDefaults.set(files, forKey: "files")
//        return true
//    }
    

    @IBAction func goNextBySegue(_ sender:UIButton) {
        performSegue(withIdentifier: "bfadd", sender: nil)
    }
    
    @IBAction func gobackBySegue(_ sender:UIButton) {
        performSegue(withIdentifier: "b2main", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
