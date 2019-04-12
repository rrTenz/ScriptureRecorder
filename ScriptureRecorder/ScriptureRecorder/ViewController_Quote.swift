//
//  ViewController_Quote.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 8/11/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_Quote: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var TextView_Quote: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TextView_Quote.text = Const.SCOTT_QUOTE[appDelegate.userLanguage.rawValue]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    

}
