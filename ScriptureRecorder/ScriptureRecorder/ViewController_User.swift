//
//  ViewController_User.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 8/5/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_User: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var textUserName: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    @IBAction func buttonAddUser(_ sender: UIButton) {
        var addUser = true
        
        var tempName = textUserName.text
        tempName = tempName?.replacingOccurrences(of: " ", with: "")
        if tempName?.isAlphanumeric == false {
            addUser = false
            showAlert(title: "Invalid Name", message: "User names must only contain standard numbers and letters and cannot be blank.")
        }
        
        for user in appDelegate.userArray {
            if user == textUserName.text {
                addUser = false
                showAlert(title: "User Already Exists", message: "The user '\(user)' already exists")
                break
            }
        }
        
        if textUserName.text == "" {
            addUser = false
            showAlert(title: "Invalid User Name", message: "The user name is invalid")
        }
        
        if addUser {
            appDelegate.userArray.append(textUserName.text!)
            tableView.reloadData()
            
            appDelegate.userName = textUserName.text!
            showAlert(title: "User changed", message: "User changed to:\n\(appDelegate.userName)")
            print("User Update: \(appDelegate.userName)")
            appDelegate.didLoadDefaults = false
            appDelegate.userName_prev = appDelegate.userName
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return appDelegate.userArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = appDelegate.userArray[indexPath.row]
        
        return cell
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.userName = appDelegate.userArray[indexPath.row]
        textUserName.text = appDelegate.userName
        appDelegate.didLoadDefaults = false
        print("User Update: \(appDelegate.userName)")
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
}
