//
//  ViewController_Settings.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 5/30/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_Settings: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let output = UITextView()
    
    @IBOutlet var switchContPlay_attr: UISwitch!
    @IBOutlet var switchContRecord_attr: UISwitch!
    @IBOutlet var labelVersion: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUserName.text = appDelegate.userName
        switchContPlay_attr.isOn = appDelegate.continualPlay
        switchContRecord_attr.isOn = appDelegate.continualRecord
        labelVersion.text = "\(appDelegate.VERSION)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var labelUserName: UILabel!
    
    @IBAction func buttonChangeUser(_ sender: UIButton) {
        //Switch screen
        appDelegate.userName_prev = appDelegate.userName
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_User") as! ViewController_User
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func switchContPlay(_ sender: UISwitch) {
        appDelegate.continualPlay = !appDelegate.continualPlay
        print("continualPlay: \(appDelegate.continualPlay)")
    }
    
    @IBAction func switchContRecord(_ sender: UISwitch) {
        appDelegate.continualRecord = !appDelegate.continualRecord
        print("continualRecord: \(appDelegate.continualRecord)")
    }
    
    @IBAction func buttonQuote(_ sender: Any) {
        //Switch screen
        appDelegate.userName_prev = appDelegate.userName
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Quote") as! ViewController_Quote
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func buttonInfoPlay(_ sender: UIButton) {
        showAlert(title: "Continuous Play", message: "The 'Continuous Play' option allows the app to continue playing one verse right after another. It will continue to do so until it finds a verse that has not been recorded, the user presses 'Stop', or 'Continuous Play' is disabled.")
    }
    
    @IBAction func buttonInfoRecord(_ sender: UIButton) {
        showAlert(title: "Continuous Record", message: "The 'Continuous Record' option will record continually as the user navigates from verse to verse. It will continue to do so until the user presses 'Stop' or 'Continuous Record' is disabled.")
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
    
    @IBAction func back(_ sender: UIButton) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    

}
