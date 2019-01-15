//
//  ListViewController.swift
//  dictionary
//
//  Created by RS on 2018/07/19.
//  Copyright © 2018年 RS. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate{
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet var eleTable: UITableView!
    
    var files: [String] = []
    var dict: [String:[String]] = [:]
    var value: [String:[String]] = [:]
    var fKey: String = ""
    var switcher: [Int:Int] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        eleTable.dataSource = self as UITableViewDataSource
        eleTable.delegate = self as UITableViewDelegate
        searchbar.delegate = self as UISearchBarDelegate
        searchbar.enablesReturnKeyAutomatically = false
        searchbar.showsCancelButton = true
        
        if (userDefaults.array(forKey: "files") != nil){
            files = userDefaults.array(forKey: "files") as! [String]
        }
        
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[String]]
        }
        
        if (userDefaults.object(forKey: "value") != nil){
            value = userDefaults.object(forKey: "value")! as! [String:[String]]
        }
        
        if (userDefaults.string(forKey: "fKey") != nil){
            fKey = userDefaults.string(forKey: "fKey") as String!
        }
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dict[fKey]?.count == 0 {
            return 0
        }
        return dict[fKey]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        // Configure the cell...
        if dict[fKey]! != [] {
            cell.textLabel?.text = dict[fKey]?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if switcher[indexPath.row] == nil{
            switcher[indexPath.row] = 0
        }
        if switcher[indexPath.row] == 0{
            cell?.textLabel?.text = value[fKey]?[indexPath.row]
            switcher[indexPath.row] = 1
        }else{
            cell?.textLabel?.text = dict[fKey]?[indexPath.row]
            switcher[indexPath.row] = 0
        }
    }
    
    @IBAction func add(sender : AnyObject){
        performSegue(withIdentifier: "add",sender: nil)
    }
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {
        performSegue(withIdentifier: "back", sender: nil)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        dict = userDefaults.object(forKey: "dict")! as! [String:[String]]
        value = userDefaults.object(forKey: "value")! as! [String:[String]]
        eleTable.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.endEditing(true)
        var newKey: [String] = []
        var newValue: [String] = []
        var i = 0
        var n = 0
        var temp: Set<Int> = []
        
        if searchbar.text != "" {
            for key in dict[fKey]! {
                if key.lowercased().contains(searchbar.text!.lowercased()){
                    temp.insert(i)
                }
                i += 1
            }
            
            for value in value[fKey]! {
                if value.lowercased().contains(searchbar.text!.lowercased()){
                    temp.insert(n)
                }
                n += 1
            }
            
            for k in temp{
                newKey.append((dict[fKey]?[k])!)
                newValue.append((value[fKey]?[k])!)
            }
            dict[fKey] = newKey
            value[fKey] = newValue
        } else if searchbar.text == "" {
            dict = userDefaults.object(forKey: "dict")! as! [String:[String]]
            value = userDefaults.object(forKey: "value")! as! [String:[String]]
        }
        eleTable.reloadData()
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
