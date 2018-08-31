//
//  ViewController_Export.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 8/9/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_Export: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var labelWhatToSend: UILabel!
    
    @IBOutlet var pickerWhat: UIPickerView!
    
    var whatArray: [String] = ["", "", "", ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.shareFile = false
        
        whatArray[0] = Utilities().getCurrentBook().Name
        whatArray[1] = Utilities().getCurrentSubBook().Name
        whatArray[2] = "\(Utilities().getCurrentSubBook().Name) \(appDelegate.chapter)"
        whatArray[3] = "\(Utilities().getCurrentSubBook().Name) \(appDelegate.chapter):\(appDelegate.verse)"
        
        appDelegate.whatToShare = Const.WhatToShare.Book
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        appDelegate.shareFile = false
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    @IBAction func buttonShare(_ sender: Any) {
        appDelegate.shareFile = true
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return whatArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(whatArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        appDelegate.whatToShare = Const.WhatToShare(rawValue: row)!
    }

}
