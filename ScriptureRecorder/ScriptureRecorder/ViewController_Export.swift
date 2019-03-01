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
        
        whatArray[0] = Utilities().getCurrentBook().Name[appDelegate.Language.rawValue]
        whatArray[1] = Utilities().getCurrentSubBook().Name[appDelegate.Language.rawValue]
        whatArray[2] = "\(Utilities().getCurrentSubBook().Name[appDelegate.Language.rawValue]) \(appDelegate.chapter)"
        whatArray[3] = "\(Utilities().getCurrentSubBook().Name[appDelegate.Language.rawValue]) \(appDelegate.chapter):\(appDelegate.verse)"
        
        appDelegate.whatToShare = Const.WhatToShare.Book
        
        switch appDelegate.Language {
        case .English:
            buttonShare_outlet.setTitle("Share", for: .normal)
            labelWhatToSend.text = "Choose What to Share"
        case .Spanish:
            buttonShare_outlet.setTitle("Compartir", for: .normal)
            labelWhatToSend.text = "Elige qué Compartir"
        case .Portuguese:
            buttonShare_outlet.setTitle("Compartilhar", for: .normal)
            labelWhatToSend.text = "Escolha o que Compartilhar"
        }
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        appDelegate.shareFile = false
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    @IBOutlet weak var buttonShare_outlet: UIButton!
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
