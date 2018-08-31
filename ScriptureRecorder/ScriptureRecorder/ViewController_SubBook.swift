//
//  ViewController_SubBook.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 5/25/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_SubBook: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var labelProgress: UILabel!
    
    var progressCount = 0
    var progressDenominator = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: UIButton) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Const.SUB_BOOK_LIST[appDelegate.bookEnum.rawValue].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        switch appDelegate.bookString {
        case Const.BOM:
            cell.textLabel?.text = Const.BOM_LIST[indexPath.row]
        case Const.PGP:
            cell.textLabel?.text = Const.PGP_LIST[indexPath.row]
        case Const.DC:
            cell.textLabel?.text = Const.DC_LIST[indexPath.row]
        case Const.OT:
            cell.textLabel?.text = Const.OT_LIST[indexPath.row]
        case Const.NT:
            cell.textLabel?.text = Const.NT_LIST[indexPath.row]
        default:
            cell.textLabel?.text = "???"
        }
        
        let book = Utilities().getBookFromString(appDelegate.bookString)
        let subBook = Utilities().getSubBookFromStrings(appDelegate.bookString, (cell.textLabel?.text!)!)
        let num = Utilities().getProgressCount(book, subBook)
        progressCount += num
        let den = Utilities().getSubBookVerseCount(subBook)
        progressDenominator += den
        let progressFraction = "\(num)/\(den)"
        var fraction = String(format: "%.1f", Double(num)/Double(den)*100.0)
        cell.textLabel?.text = "\((cell.textLabel?.text)!)    (\(progressFraction) = \(fraction)%)"
        
        fraction = String(format: "%.1f", Double(progressCount)/Double(progressDenominator)*100.0)
        labelProgress.text = "\(progressCount)/\(progressDenominator) = \(fraction)%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch appDelegate.bookString {
        case Const.BOM:
            appDelegate.subBookString = Const.BOM_LIST[indexPath.row]
        case Const.PGP:
            appDelegate.subBookString = Const.PGP_LIST[indexPath.row]
        case Const.DC:
            appDelegate.subBookString = Const.DC_LIST[indexPath.row]
        case Const.OT:
            appDelegate.subBookString = Const.OT_LIST[indexPath.row]
        case Const.NT:
            appDelegate.subBookString = Const.NT_LIST[indexPath.row]
        default:
            appDelegate.subBookString = "???"
        }
        print("Sub Book Selected \(appDelegate.subBookString)")
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }

}
