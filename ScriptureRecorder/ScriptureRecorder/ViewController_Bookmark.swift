//
//  ViewController_Bookmark.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 8/15/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit

class ViewController_Bookmark: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var Label_Bookmarks: UILabel!
    @IBOutlet var labelCurrentScripture: UILabel!
    @IBOutlet var textBookmark0: UITextView!
    @IBOutlet var textBookmark1: UITextView!
    @IBOutlet var textBookmark2: UITextView!
    @IBOutlet var textBookmark3: UITextView!
    @IBOutlet var textBookmark4: UITextView!
    @IBOutlet var textBookmark5: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelCurrentScripture.text = "\(appDelegate.subBookString) \(appDelegate.chapter):\(appDelegate.verse)"
        
        updateTextBox(0)
        updateTextBox(1)
        updateTextBox(2)
        updateTextBox(3)
        updateTextBox(4)
        updateTextBox(5)
        
        switch appDelegate.Language {
        case .English:
            Label_Bookmarks.text = "Bookmarks"
        case .Spanish:
            Label_Bookmarks.text = "Marcadores"
        case .Portuguese:
            Label_Bookmarks.text = "Favoritos"
        }
    }
    
    func updateTextBox(_ i: Int) {
        var text = ""
        
        if appDelegate.bookmarks[i].bookString == "" || appDelegate.bookmarks[i].subBookString == ""{
            switch appDelegate.Language {
            case .English:
                text = "<Empty>"
            case .Spanish:
                text = "<Vacío>"
            case .Portuguese:
                text = "<Vazio>"
            }
        }else {
            text = "\(appDelegate.bookmarks[i].bookString)\n\(appDelegate.bookmarks[i].subBookString) \(appDelegate.bookmarks[i].chapter):\(appDelegate.bookmarks[i].verse)"
        }
        
        switch i {
        case 0:
            textBookmark0.text = text
        case 1:
            textBookmark1.text = text
        case 2:
            textBookmark2.text = text
        case 3:
            textBookmark3.text = text
        case 4:
            textBookmark4.text = text
        case 5:
            textBookmark5.text = text
        default:
            break
        }
    }
    
    @IBAction func buttonTrash0(_ sender: Any) {
        putInTrash(0)
    }
    @IBAction func buttonTrash1(_ sender: Any) {
        putInTrash(1)
    }
    @IBAction func buttonTrash2(_ sender: Any) {
        putInTrash(2)
    }
    @IBAction func buttonTrash3(_ sender: Any) {
        putInTrash(3)
    }
    @IBAction func buttonTrash4(_ sender: Any) {
        putInTrash(4)
    }
    @IBAction func buttonTrash5(_ sender: Any) {
        putInTrash(5)
    }
    
    func putInTrash(_ i: Int) {
        appDelegate.bookmarks[i] = Scripture.Bookmark()
        updateTextBox(i)
    }
    
    @IBAction func buttonBookmark0(_ sender: Any) {
        makeBookmark(0)
    }
    @IBAction func buttonBookmark1(_ sender: Any) {
        makeBookmark(1)
    }
    @IBAction func buttonBookmark2(_ sender: Any) {
        makeBookmark(2)
    }
    @IBAction func buttonBookmark3(_ sender: Any) {
        makeBookmark(3)
    }
    @IBAction func buttonBookmark4(_ sender: Any) {
        makeBookmark(4)
    }
    @IBAction func buttonBookmark5(_ sender: Any) {
        makeBookmark(5)
    }
    
    func makeBookmark(_ i: Int){
        appDelegate.bookmarks[i].bookEnum = appDelegate.bookEnum
        appDelegate.bookmarks[i].bookString = appDelegate.bookString
        appDelegate.bookmarks[i].subBookString = appDelegate.subBookString
        appDelegate.bookmarks[i].chapter = appDelegate.chapter
        appDelegate.bookmarks[i].verse = appDelegate.verse
        updateTextBox(i)
    }
    
    @IBAction func buttonGo0(_ sender: Any) {
        goToBookmark(0)
    }
    @IBAction func buttonGo1(_ sender: Any) {
        goToBookmark(1)
    }
    @IBAction func buttonGo2(_ sender: Any) {
        goToBookmark(2)
    }
    @IBAction func buttonGo3(_ sender: Any) {
        goToBookmark(3)
    }
    @IBAction func buttonGo4(_ sender: Any) {
        goToBookmark(4)
    }
    @IBAction func buttonGo5(_ sender: Any) {
        goToBookmark(5)
    }
    
    func goToBookmark(_ i: Int) {
        if appDelegate.bookmarks[i].bookString == "" || appDelegate.bookmarks[i].subBookString == ""{
            showAlert(title: "Bad Bookmark", message: "Cannot go to an empty bookmark")
            return
        }
        appDelegate.bookEnum = appDelegate.bookmarks[i].bookEnum
        appDelegate.bookString = appDelegate.bookmarks[i].bookString
        appDelegate.subBookString = appDelegate.bookmarks[i].subBookString
        appDelegate.chapter = appDelegate.bookmarks[i].chapter
        appDelegate.verse = appDelegate.bookmarks[i].verse
        
        appDelegate.goToBookmark = true
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonBack(_ sender: Any) {
        //https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
        self.performSegue(withIdentifier: "unwindToMenuWithSegue", sender: self)
    }
}
