//
//  AddViewController.swift
//  dictionary
//
//  Created by RS on 2017/10/29.
//  Copyright © 2017年 RS. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var files: [String] = []
    var dict: [String:[String]] = [:]
    var value: [String:[String]] = [:]
    var fKey: String = ""
    @IBOutlet var textfield1: UITextField!
    @IBOutlet var textfield2: UITextField!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.placeholder = "Enter English"
        textfield2.placeholder = "Enter Japanese"
        
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[String]]
        }
        
        if (userDefaults.array(forKey: "files") != nil){
            files = userDefaults.array(forKey: "files") as! [String]
        }
        
        if (userDefaults.object(forKey: "value") != nil){
            value = userDefaults.object(forKey: "value")! as! [String:[String]]
        }
        
        if (userDefaults.string(forKey: "fKey") != nil){
            fKey = userDefaults.string(forKey: "fKey")!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender : AnyObject){
        let eng = textfield1.text
        let jpn = textfield2.text
        
        fKey = userDefaults.string(forKey: "fKey")!
        dict[fKey]?.append(eng!)
        value[fKey]?.append(jpn!)
        userDefaults.set(dict, forKey: "dict")
        userDefaults.set(value, forKey: "value")
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
