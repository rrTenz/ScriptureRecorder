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

    @IBOutlet weak var Label_ContinuousPlay: UILabel!
    @IBOutlet weak var Label_ContinousRecord: UILabel!
    @IBOutlet weak var Label_QuestionsComments: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUserName.text = appDelegate.userName
        switchContPlay_attr.isOn = appDelegate.continualPlay
        switchContRecord_attr.isOn = appDelegate.continualRecord
        labelVersion.text = "\(appDelegate.VERSION)"
        
        if appDelegate.Language == .English {
            buttonChangeUser_outlet.setTitle("Change User", for: .normal)
            Label_ContinuousPlay.text = "Continuous Play"
            Label_ContinousRecord.text = "Continous Record"
            buttonQuote_outlet.setTitle("Richard G. Scott Quote", for: .normal)
            buttonLanguage_outlet.setTitle("Language", for: .normal)
            Label_QuestionsComments.text = "Please send questions, comments, or concerns to rrtenz@gmail.com (including translation errors). And now, if there are faults they are the mistakes of the software programmer."
        }else if appDelegate.Language == .Spanish {
            buttonChangeUser_outlet.setTitle("Cambiar Usuario", for: .normal)
            Label_ContinuousPlay.text = "Juego continuo"
            Label_ContinousRecord.text = "Grabación continua"
            buttonQuote_outlet.setTitle("Cita de Richard G. Scott", for: .normal)
            buttonLanguage_outlet.setTitle("Idioma", for: .normal)
            Label_QuestionsComments.text = "Envíe preguntas, comentarios o inquietudes a rrtenz@gmail.com (incluidos los errores de traducción). Y ahora bien, si hay faltas, estas son equivocaciones del programador de software..."
        }else {
            fatalError()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var labelUserName: UILabel!
    
    @IBOutlet weak var buttonChangeUser_outlet: UIButton!
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
    
    @IBOutlet weak var buttonQuote_outlet: UIButton!
    @IBAction func buttonQuote(_ sender: Any) {
        //Switch screen
        appDelegate.userName_prev = appDelegate.userName
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Quote") as! ViewController_Quote
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBOutlet weak var buttonLanguage_outlet: UIButton!
    @IBAction func buttonLanguage(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Language") as! ViewController_Language
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func buttonInfoPlay(_ sender: UIButton) {
        if appDelegate.Language == .English {
            showAlert(title: "Continuous Play", message: "The 'Continuous Play' option allows the app to continue playing one verse right after another. It will continue to do so until it finds a verse that has not been recorded, the user presses 'Stop', or 'Continuous Play' is disabled.")
        }else if appDelegate.Language == .Spanish {
            showAlert(title: "Juego continuo", message: "La opción 'Juego continuo' permite que la aplicación continúe reproduciendo un verso inmediatamente después de otro. Continuará haciéndolo hasta que encuentre un versículo que no se ha grabado, el usuario presiona 'Parar' o 'Reproducción continua' está desactivado.")
        }else {
            fatalError()
        }
    }
    
    @IBAction func buttonInfoRecord(_ sender: UIButton) {
        if appDelegate.Language == .English {
            showAlert(title: "Continuous Record", message: "The 'Continuous Record' option will record continually as the user navigates from verse to verse. It will continue to do so until the user presses 'Stop' or 'Continuous Record' is disabled.")
        }else if appDelegate.Language == .Spanish {
            showAlert(title: "Grabación continua", message: "La opción 'Grabación continua' registrará continuamente mientras el usuario navega de verso a verso. Continuará haciéndolo hasta que el usuario presione 'Parar' o 'Grabación continua' esté desactivado.")
        }else {
            fatalError()
        }
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
