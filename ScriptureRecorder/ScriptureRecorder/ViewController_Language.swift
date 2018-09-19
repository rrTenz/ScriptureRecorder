//
//  ViewController_Language.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 9/14/18.
//  Copyright © 2018 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_Language: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var Label_Language: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Label_Language.text = Const.LANGUAGE[appDelegate.Language.rawValue]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.LANGUAGE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Const.LANGUAGE[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Label_Language.text = Const.LANGUAGE[indexPath.row]
        appDelegate.Language = AppDelegate.Language(rawValue: indexPath.row)!
        appDelegate.languageURL = appDelegate.languageURL_array[indexPath.row]
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
