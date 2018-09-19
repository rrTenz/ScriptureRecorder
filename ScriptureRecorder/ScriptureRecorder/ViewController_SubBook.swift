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
        return Const.SUB_BOOK_LIST[appDelegate.Language.rawValue][appDelegate.bookEnum.rawValue].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        switch appDelegate.bookString {
        case Const.BOM, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.BOM.rawValue] :
            cell.textLabel?.text = Const.BOM_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.PGP, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.PGP.rawValue]:
            cell.textLabel?.text = Const.PGP_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.DC, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.DC.rawValue]:
            cell.textLabel?.text = Const.DC_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.OT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.OT.rawValue]:
            cell.textLabel?.text = Const.OT_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.NT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.NT.rawValue]:
            cell.textLabel?.text = Const.NT_LIST[appDelegate.Language.rawValue][indexPath.row]
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
        case Const.BOM, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.BOM.rawValue]:
            appDelegate.subBookString = Const.BOM_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.PGP, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.PGP.rawValue]:
            appDelegate.subBookString = Const.PGP_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.DC, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.DC.rawValue]:
            appDelegate.subBookString = Const.DC_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.OT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.OT.rawValue]:
            appDelegate.subBookString = Const.OT_LIST[appDelegate.Language.rawValue][indexPath.row]
        case Const.NT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.NT.rawValue]:
            appDelegate.subBookString = Const.NT_LIST[appDelegate.Language.rawValue][indexPath.row]
        default:
            appDelegate.subBookString = "???"
        }
        print("Sub Book Selected \(appDelegate.subBookString)")
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }

}
