//
//  ViewController_Book.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 5/24/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_Book: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var back: UIButton!
    
    @IBAction func back(_ sender: UIButton) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Const.BOOK_LIST.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Const.BOOK_LIST[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.bookEnum = Const.Book(rawValue: indexPath.row)!
        appDelegate.bookString = Const.BOOK_LIST[indexPath.row]
        print("Book Selected \(Const.BOOK_LIST[indexPath.row])")
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }

}
