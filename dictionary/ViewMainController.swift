//
//  ViewMainController.swift
//  dictionary
//
//  Created by RS on 2017/10/29.
//  Copyright © 2017年 RS. All rights reserved.
//

import UIKit

class ViewMainController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    @IBOutlet var add: UIButton!
    @IBOutlet var titleTableview: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    
    var files: [String] = []
    var dict: [String:[String]] = [:]
    var value: [String:[String]] = [:]
    var fKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTableview.dataSource = self as UITableViewDataSource
        titleTableview.delegate = self as UITableViewDelegate
        
        // Do any additional setup after loading the view.
        titleTableview.reloadData()
        
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
    
    @IBAction func goNextBySegue(_ sender:UIButton) {
        performSegue(withIdentifier: "2add", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = files[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if files.count == 0 {
            return 0
        }
        return files.count
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        fKey = files[indexPath.row]
        userDefaults.set(fKey, forKey: "fKey")
        let targetViewController = self.storyboard!.instantiateViewController(withIdentifier: "List")
        self.present(targetViewController, animated: true, completion: nil)
    }
    
    @IBAction func add(sender : AnyObject){
        performSegue(withIdentifier: "2add",sender: nil)
    }
}
