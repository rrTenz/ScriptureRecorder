//
//  ViewController.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 5/24/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit
import AVFoundation
//import GoogleMobileAds
//import CloudKit

//TODO add for ads
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate/*, GADBannerViewDelegate*/ {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var buttonRecord: UIButton!
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var buttonSave: UIButton!
    
    @IBOutlet var imageRecord: UIImageView!
    @IBOutlet var imagePlay: UIImageView!
    
    @IBOutlet var textViewVerse: UITextView!
    @IBOutlet var webView: UIWebView!
    
    @IBOutlet var textChapter: UITextField!
    @IBOutlet var textVerse: UITextField!
    
    @IBOutlet var buttonBook: UIButton!
    @IBOutlet var buttonSubBook: UIButton!
    
    @IBOutlet weak var View_Progress: UIView!
    @IBOutlet weak var CombineProgress_Label: UILabel!
    
    static let text_buttonRecord = ["Record", "Grabar", "Gravar"]
    static let text_buttonPlay = ["Play", "Tocar", "Tocar"]
    static let text_buttonShare = ["Share", "Compartir", "Compartilhar"]
    static let text_buttonStop = ["Stop", "Parar", "Parar"]
    
    //TODO add for ads, !!!will need to drag back in from storyboard !!! 
    //@IBOutlet var bannerView: GADBannerView!
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var audioRecordingName = "audioRecording2.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if appDelegate.didLoadDefaults == false {
            appDelegate.didLoadDefaults = true
            Utilities().loadDefaults(loadUser: true)
        }
        
        self.prepareAudioRecorder()
        self.updateBookStrings()
        
        let url = Utilities().getScriptureUrl()
        webView.loadRequest(URLRequest(url: url))
        
        //TODO add for ads
//        let request = GADRequest()
//        bannerView.delegate = self
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"  //Scripture recorder
//        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"  //test ad
//        bannerView.rootViewController = self
//        bannerView.load(request)
        
        imagePlay.isHidden = true
        imageRecord.isHidden = true
        
        self.timer_UI = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(run_UI_Code), userInfo: nil, repeats: true)
    }
    
    @objc func run_UI_Code() {
        CombineProgress_Label.text = "\(appDelegate.TotalSize_String)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue)
    {
        if appDelegate.didLoadDefaults == false {
            appDelegate.didLoadDefaults = true
            Utilities().loadDefaults(loadUser: false)
        }
        
        self.updateBookStrings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if appDelegate.userName_prev != appDelegate.userName {
            switch appDelegate.userLanguage {
            case .English:
                Utilities().popupMessage(view: self, title: "User changed", message: "User changed to:\n\(appDelegate.userName)", button: "OK")
            case .Spanish:
                Utilities().popupMessage(view: self, title: "Usuario cambiado", message: "El usuario cambió a:\n\(appDelegate.userName)", button: "Bueno")
            case .Portuguese:
                Utilities().popupMessage(view: self, title: "Usuário alterado", message: "Usuário alterado para:\n\(appDelegate.userName)", button: "OK")
            }
            appDelegate.userName_prev = appDelegate.userName
        }
        
        if appDelegate.shareFile {
            appDelegate.shareFile = false
            shareFile()
        }
        
        buttonRecord.setTitle(ViewController.text_buttonRecord[appDelegate.userLanguage.rawValue], for: .normal)
        buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.userLanguage.rawValue], for: .normal)
        buttonSave.setTitle(ViewController.text_buttonShare[appDelegate.userLanguage.rawValue], for: .normal)
    }
    
    //TODO add for ads
//    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("adViewDidReceiveAd")
//    }
//    
//    /// Tells the delegate an ad request failed.
//    func adView(_ bannerView: GADBannerView,
//                didFailToReceiveAdWithError error: GADRequestError) {
//        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//    
//    /// Tells the delegate that a full screen view will be presented in response
//    /// to the user clicking on an ad.
//    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
//        print("adViewWillPresentScreen")
//    }
//    
//    /// Tells the delegate that the full screen view will be dismissed.
//    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewWillDismissScreen")
//    }
//    
//    /// Tells the delegate that the full screen view has been dismissed.
//    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
//        print("adViewDidDismissScreen")
//    }
//    
//    /// Tells the delegate that a user click will open another app (such as
//    /// the App Store), backgrounding the current app.
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//        print("adViewWillLeaveApplication")
//    }
    
    var activityIndicator = UIActivityIndicatorView()
    var timer: Timer!
    var timer_tryAgain: Timer!
    var timer_UI: Timer!
    var readFileSize_TryCount = 0
    var audioData_TryAgain: NSURL = NSURL()
    func shareFile() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(run_BlockUi_Code), userInfo: nil, repeats: false)
    }
    
    @objc func run_BlockUi_Code() {
        
        View_Progress.isHidden = false
        switch appDelegate.userLanguage {
        case .English:
            CombineProgress_Label.text = "Preparing File"
        case .Spanish:
            CombineProgress_Label.text = "Preparando el archivo"
        case .Portuguese:
            CombineProgress_Label.text = "Preparando Arquivo"
        }
        
        
        //Activity Indicator init
        activityIndicator.isHidden = false
        activityIndicator.center = self.view.center
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        print("beginIgnoringInteractionEvents")
        self.view.addSubview(activityIndicator)
        
        if timer_UI != nil {
            timer_UI.invalidate()
        }
        self.timer_UI = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(run_UI_Code), userInfo: nil, repeats: true)
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
    }
    
    @objc func runTimedCode() {
        //DispatchQueue.global(qos: .utility).async {
            var fileExists = false
            
            //Create desired file
            if self.appDelegate.whatToShare == .Verse {
                //there is nothing to create
                fileExists = self.verifyFileExists()
            }else {
                self.appDelegate.doneMergingFile = false
                    if Utilities().combineFile() == false {
                        self.FileComboFail()
                    }else {
                        fileExists = true
                    }
            }
            
            if fileExists {
                var path = ""
                var audioData: NSURL
                if self.appDelegate.whatToShare == .Verse {
                    path = self.audioFileLocation()
                    audioData = NSURL(fileURLWithPath: path)
                }else {
                    audioData = self.appDelegate.mergeAudioURL
                }
                
                print("Waiting for file to stablize")
                self.audioData_TryAgain = audioData
                self.readFileSize_TryCount = 10
                self.fileSize_prev = 0
                if timer_UI != nil {
                    timer_UI.invalidate()
                }
                self.timer_tryAgain = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.run_TryAgainCode), userInfo: nil, repeats: false)
            }else{
                self.FileComboFail()
            }
        //}
    }
    
    var fileSize_Total = 0
    var fileSize_prev: UInt64 = 0
    @objc func run_TryAgainCode() {
        
        print("readFileSize_TryCount: \(readFileSize_TryCount)")
        
        let fileSize = sizePerMB(url: audioData_TryAgain as URL)
        if doesFileExist(url: audioData_TryAgain as URL) && fileSize > 0 {
            
            print("File Size is no longer 0, fileSize: \(fileSize), fileSize_prev \(fileSize_prev)")
            
            if appDelegate.TotalSize_String.isAlphanumeric {
                fileSize_Total = Int(appDelegate.TotalSize_String)!
            }
            
            let percent = (Float(fileSize) / Float(Double(fileSize_Total) * 0.2165)) * 100
            if percent > 100.0 {
                CombineProgress_Label.text = String(format: "%.3f", Double(fileSize) / 1000000.0) + " MB"
            } else {
                CombineProgress_Label.text = "~ " + String(format: "%.3f", percent) + " %"
            }
            
            
            if fileSize == fileSize_prev {
                print("File is READY")
                let activityVC = UIActivityViewController(activityItems:[audioData_TryAgain], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self.view
                
                self.present(activityVC, animated: true, completion: nil)
                
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                View_Progress.isHidden = true
            }else {
                print("File Size has changed")
                fileSize_prev = fileSize
                self.timer_tryAgain = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(run_TryAgainCode), userInfo: nil, repeats: false)
            }
            
        }else {
            if self.appDelegate.doneMergingFile {
                readFileSize_TryCount -= 1
            }
            if readFileSize_TryCount >= 0 {
                self.timer_tryAgain = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(run_TryAgainCode), userInfo: nil, repeats: false)
            }else {
                print("No more tries")
                FileComboFail()
            }
        }
    }
    
    func FileComboFail() {
        switch appDelegate.userLanguage {
        case .English:
            Utilities().popupMessage(view: self, title: "Error", message: "The combined file could not be created", button: "OK")
        case .Spanish:
            Utilities().popupMessage(view: self, title: "Error", message: "El archivo combinado no pudo ser creado", button: "Bueno")
        case .Portuguese:
            Utilities().popupMessage(view: self, title: "Erro", message: "O arquivo combinado não pôde ser criado", button: "OK")
        }
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        View_Progress.isHidden = true
    }
    
    func doesFileExist(url: URL) -> Bool {
        var doesExist = false
        var fileSize : UInt64 = 0
        let filePath = url.path
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            
            do {
                //return [FileAttributeKey : Any]
                let attr = try FileManager.default.attributesOfItem(atPath: filePath)
                fileSize = attr[FileAttributeKey.size] as! UInt64
                
                //if you convert to NSDictionary, you can get file size old way as well.
                let dict = attr as NSDictionary
                fileSize = dict.fileSize()
                
                if fileSize <= 0 {
                    print("FILE SIZE IS 0")
                    doesExist = false
                }else {
                    print("FILE AVAILABLE, fileSize: \(fileSize)")
                    doesExist = true
                }
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("FILE NOT AVAILABLE")
        }
        
        return doesExist
    }
    
    
    func sizePerMB(url: URL?) -> UInt64 {
        let filePath = (url?.path)!
        var fileSize : UInt64 = 0
        
        do {
            //return [FileAttributeKey : Any]
            let attr = try FileManager.default.attributesOfItem(atPath: filePath)
            fileSize = attr[FileAttributeKey.size] as! UInt64
            
            //if you convert to NSDictionary, you can get file size old way as well.
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
        } catch {
            print("Error: \(error)")
        }
        
        return fileSize
    }
    
    @IBAction func buttonSave(_ sender: Any) {
        //saveToCloud(myContent: audioRecordingName)
       
        stop_Recording_and_Playing()
        
        //Switch screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Export") as! ViewController_Export
        self.present(nextViewController, animated:true, completion:nil)
    }

    @IBAction func Record(_ sender: UIButton) {
        recordActions()
    }
    
    func recordActions() {
        if !audioRecorder.isRecording{
            #if false
                playBeep()
            #else
                startRecording()
            #endif
        }else{
            stopRecording()
        }
    }
    
    func startRecording() {
        print("startRecording")
        if !audioRecorder.isRecording {
            //start recording
            self.prepareAudioRecorder()
            
            let audioSession = AVAudioSession.sharedInstance()
            
            do{
                try audioSession.setActive(true)
                audioRecorder.record()
            }catch{
                print(error)
            }
        }
        self.updateRecordButtonTitle()
    }
    
    func stopRecording() {
        print("stopRecording")
        //stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setActive(false)
        }catch{
            print(error)
        }
        
        //Check
        if(self.verifyFileExists()){
            print("file exists")
        }else{
            print("there was a problem recording")
        }
        self.updateRecordButtonTitle()
    }
    
    //TODO add for Cloud
//    let database = CKContainer.default().publicCloudDatabase    //TODO change to private?
//    
//    func saveToCloud(myContent: String){
//    #if true
//        let myRecord = CKRecord(recordType: "Note")
//        myRecord.setValue(myContent, forKey: "content")
//        database.save(myRecord) { (record, error) in
//            print(error ??  "No error")
//            guard record != nil else {return}
//            print("Saved record to iCloud")
//        }
//    #else
//        
//        let newNote = CKRecord(recordType: "AudioRecording")
//        newNote.setValue(note, forKey: "content")
//        newNote.setValue(audioObject, forKey: "Audio")
//        database.save(newNote) { (record, error) in
//            print(error ??  "No error")
//            guard record != nil else {return}
//            print("Saved record to iCloud")
//        }
//    #endif
//    }
//    
//    //TODO call this from somewhere
//    func queryDatabase() {
//        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
//        database.perform(query, inZoneWith: nil) { (records, _) in
//            guard let records = records else {return}
//            let sortedRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
//            print(sortedRecords)
//            DispatchQueue.main.async {
//                //Update UI here
//            }
//        }
//    }

    @IBAction func PlaySound(_ sender: UIButton) {
        playActions()
    }
    
    func playActions() {
        if verifyFileExists() == false {
            switch appDelegate.userLanguage {
            case .English:
                Utilities().popupMessage(view: self, title: "Oops", message: "File does not exisit", button: "OK")
            case .Spanish:
                Utilities().popupMessage(view: self, title: "Ups", message: "El archivo no existe", button: "Bueno")
            case .Portuguese:
                Utilities().popupMessage(view: self, title: "Opa", message: "Arquivo não existe", button: "OK")
            }
            return
        }
        if !audioRecorder.isRecording{  //don't play when recording
            if buttonPlay.titleLabel?.text == ViewController.text_buttonPlay[appDelegate.userLanguage.rawValue] ||
                (audioPlayer != nil && audioPlayer.isPlaying == false) {
                buttonRecord.isEnabled = false
                buttonPlay.setTitle(ViewController.text_buttonStop[appDelegate.userLanguage.rawValue], for: .normal)
                
                imagePlay.isHidden = false
                imageRecord.isHidden = true
                
                preparePlayer()
                audioPlayer.play()
            }else{
                audioPlayer.stop()
                buttonRecord.isEnabled = true
                buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.userLanguage.rawValue], for: .normal)
                
                imagePlay.isHidden = true
                imageRecord.isHidden = true
            }
        }
    }
    
    func stop_Recording_and_Playing() {
        if audioRecorder.isRecording{
            stopRecording()
        }
        if buttonPlay.titleLabel?.text == ViewController.text_buttonStop[appDelegate.userLanguage.rawValue] ||
            (audioPlayer != nil && audioPlayer.isPlaying == true) {
            playActions()   //TODO this needs to be tested
        }
    }
    
    @IBAction func selectBook(_ sender: UIButton) {
        stop_Recording_and_Playing()
        
        //Switch screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Book") as! ViewController_Book
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func selectSubBook(_ sender: UIButton) {
        stop_Recording_and_Playing()
        
        //Switch screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_SubBook") as! ViewController_SubBook
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func goToSettings(_ sender: UIButton) {
        stop_Recording_and_Playing()
        
        //Switch screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Settings") as! ViewController_Settings
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func buttonGoToBookmarks(_ sender: Any) {
        stop_Recording_and_Playing()
        
        //Switch screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController_Bookmark") as! ViewController_Bookmark
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    var chapter_prev = 0
    var verse_prev = 0
    @IBAction func decChapter(_ sender: UIButton) {
        stop_Recording_and_Playing()
        
        chapter_prev = appDelegate.chapter
        verse_prev = appDelegate.verse
        appDelegate.chapter = Int(textChapter.text!)!
        if(appDelegate.chapter > 1){
            appDelegate.chapter -= 1
            appDelegate.verse = Utilities().getMinVerse()
        }else {
            goToPreviousSubBook()
            appDelegate.verse = Utilities().getMinVerse()
        }
        updateUI()
    }
    
    @IBAction func incChapter(_ sender: UIButton) {
        stop_Recording_and_Playing()
        
        chapter_prev = appDelegate.chapter
        verse_prev = appDelegate.verse
        appDelegate.chapter = Int(textChapter.text!)!
        appDelegate.chapter += 1
        let subBook = Utilities().getCurrentSubBook()
        if(appDelegate.chapter > subBook.ChapterArray.count){
            goToNextSubBook()
        }else{
            appDelegate.verse = Utilities().getMinVerse()
        }
        updateUI()
    }

    @IBAction func decVerse(_ sender: UIButton) {
        goToPrevVerse()
    }
    
    @IBAction func incVerse(_ sender: UIButton) {
        goToNextVerse()
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        goToPrevVerse()
    }
    
    @IBAction func buttonForward(_ sender: UIButton) {
        goToNextVerse()
    }
    
    func goToNextVerse(){
        let wasRecording = audioRecorder.isRecording
        stop_Recording_and_Playing()
        
        let subBook_prev = appDelegate.subBookString
        chapter_prev = appDelegate.chapter
        verse_prev = appDelegate.verse
        
        appDelegate.chapter = Int(textChapter.text!)!
        appDelegate.verse = Int(textVerse.text!)!
        let maxVerse = Utilities().getMaxVerse()
        appDelegate.verse += 1
        if(appDelegate.verse > maxVerse){
            goToNextChapter()
        }
        
        updateUI()
        
        //Continous Record
        if wasRecording && appDelegate.continualRecord {
            print("**Checking continous record")
            if subBook_prev != appDelegate.subBookString ||
                chapter_prev != appDelegate.chapter ||
                verse_prev != appDelegate.verse {
                //we have changed to a new verse
                print("   Went to next verse")
                
                if verifyFileExists() { //see if the new verse has been recorded before
                    //if the verse exists, don't try to record over it
                    switch appDelegate.userLanguage {
                    case .English:
                        Utilities().popupMessage(view: self, title: "Recording Stopped", message: "This verse has previously been recorded. Continual Record has stopped.", button: "OK")
                    case .Spanish:
                        Utilities().popupMessage(view: self, title: "Grabación detenida", message: "Este verso ha sido previamente grabado. El registro continuo se ha detenido.", button: "Bueno")
                    case .Portuguese:
                        Utilities().popupMessage(view: self, title: "Gravação interrompida", message: "Este verso foi previamente gravado. O registro contínuo foi interrompido.", button: "OK")
                    }
                }else {
                    print("   Start recording for continous record")
                    startRecording()
                }
            }
        }
    }
    
    func goToPrevVerse(){
        let wasRecording = audioRecorder.isRecording
        stop_Recording_and_Playing()
        
        let subBook_prev = appDelegate.subBookString
        chapter_prev = appDelegate.chapter
        verse_prev = appDelegate.verse
        
        appDelegate.chapter = Int(textChapter.text!)!
        appDelegate.verse = Int(textVerse.text!)!
        if(appDelegate.verse - 1 >= Utilities().getMinVerse()){
            appDelegate.verse -= 1
        }else {
            goToPreviousChapter()
        }
        
        updateUI()
        
        //Continous Record
        if wasRecording && appDelegate.continualRecord {
            print("**Checking continous record")
            if subBook_prev != appDelegate.subBookString ||
                chapter_prev != appDelegate.chapter ||
                verse_prev != appDelegate.verse {
                //we have changed to a new verse
                print("   Went to next verse")
                
                if verifyFileExists() { //see if the new verse has been recorded before
                    //if the verse exists, don't try to record over it
                    switch appDelegate.userLanguage {
                    case .English:
                        Utilities().popupMessage(view: self, title: "Recording Stopped", message: "This verse has previously been recorded. Continual Record has stopped.", button: "OK")
                    case .Spanish:
                        Utilities().popupMessage(view: self, title: "Grabación detenida", message: "Este verso ha sido previamente grabado. El registro continuo se ha detenido.", button: "Bueno")
                    case .Portuguese:
                        Utilities().popupMessage(view: self, title: "Gravação interrompida", message: "Este verso foi previamente gravado. O registro contínuo foi interrompido.", button: "OK")
                    }
                }else {
                    print("   Start recording for continous record")
                    startRecording()
                }
            }
        }
    }
    
    func goToPreviousChapter(){
        if(appDelegate.chapter == 1){
            goToPreviousSubBook()
        }else{
            appDelegate.chapter -= 1
            appDelegate.verse = Utilities().getCurrentChapterObject().verseCount
        }
        updateUI()
    }
    
    func goToNextChapter(){
        let subBook = Utilities().getCurrentSubBook()
        if(appDelegate.chapter == subBook.ChapterArray.count){
            goToNextSubBook()
        }else{
            appDelegate.chapter += 1
            appDelegate.verse = Utilities().getMinVerse()
        }
        updateUI()
    }
    
    func goToPreviousSubBook() {
        var subBookIndex = Utilities().getCurrentSubBookIndex()
        let subList = Utilities().getCurrentBook().SubBookArray
        if (subBookIndex > 0){
            subBookIndex -= 1
            appDelegate.subBookString = subList[subBookIndex].Name[appDelegate.userLanguage.rawValue]
            appDelegate.chapter = Utilities().getCurrentSubBook().ChapterArray.count
            appDelegate.verse = Utilities().getCurrentChapterObject().verseCount
            appDelegate.subBookString_prev = appDelegate.subBookString
        }else{
            switch appDelegate.userLanguage {
            case .English:
                Utilities().popupMessage(view: self, title: "Beginning of Book", message: "There is not a previous chapter or verse in this book", button: "OK")
            case .Spanish:
                Utilities().popupMessage(view: self, title: "Principio de libro", message: "No hay un capítulo o verso anterior en este libro", button: "Bueno")
            case .Portuguese:
                Utilities().popupMessage(view: self, title: "Início do livro", message: "Não há um capítulo ou verso anterior neste livro", button: "OK")
            }
            appDelegate.chapter = chapter_prev
            appDelegate.verse = verse_prev
        }
        
        updateUI()
    }
    
    func goToNextSubBook() {
        var subBookIndex = Utilities().getCurrentSubBookIndex()
        let subList = Utilities().getCurrentBook().SubBookArray
        if (subBookIndex + 1 < subList.count){
            subBookIndex += 1
            appDelegate.subBookString = subList[subBookIndex].Name[appDelegate.userLanguage.rawValue]
            appDelegate.chapter = 1
            appDelegate.verse = Utilities().getMinVerse()
            appDelegate.subBookString_prev = appDelegate.subBookString
        }else{
            switch appDelegate.userLanguage {
            case .English:
                Utilities().popupMessage(view: self, title: "End of Book", message: "There is not another chapter or verse in this book", button: "OK")
            case .Spanish:
                Utilities().popupMessage(view: self, title: "Fin de Libro", message: "No hay otro capítulo o verso en este libro.", button: "Bueno")
            case .Portuguese:
                Utilities().popupMessage(view: self, title: "Fim do Livro", message: "Não há outro capítulo ou verso neste livro", button: "OK")
            }
            appDelegate.chapter = chapter_prev
            appDelegate.verse = verse_prev
        }
        
        updateUI()
    }
    
    // MARK: Main
    func prepareAudioRecorder(){
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)))
            let location = audioFileLocation()
            let mySettings = self.audioRecordingSettings()
            let myUrl = URL(string: location)!
            try audioRecorder = AVAudioRecorder(url: myUrl, settings: mySettings)
            
            audioRecorder.prepareToRecord()
        }catch{
            print(error)
        }
    }
    
    func preparePlayer(){
        if verifyFileExists() == false {
            switch appDelegate.userLanguage {
            case .English:
                Utilities().popupMessage(view: self, title: "Oops", message: "The file does not exist", button: "Done")
            case .Spanish:
                Utilities().popupMessage(view: self, title: "Ups", message: "El archivo no existe", button: "Bueno")
            case .Portuguese:
                Utilities().popupMessage(view: self, title: "Opa", message: "O arquivo não existe", button: "OK")
            }
            return
        }
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: URL(string: audioFileLocation())!)
        }catch{
            print(error)
        }
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = 1.0
    }
    
    // MARK: Helpers
    func audioFileLocation() -> String{
        #if true
        var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        documentsPath.append("/\(audioRecordingName)")
        return documentsPath
        #else
        return NSTemporaryDirectory().appending(audioRecordingName)
        #endif
    }
    
    func audioRecordingSettings() -> [String:Any]{
        let settings = [AVFormatIDKey : NSNumber.init(value: kAudioFormatAppleLossless),
                        AVSampleRateKey : NSNumber.init(value: 44100.0),
                        AVNumberOfChannelsKey : NSNumber.init(value: 1),
                        AVLinearPCMBitDepthKey : NSNumber.init(value: 16),
                        AVEncoderAudioQualityKey : NSNumber.init(value: AVAudioQuality.high.rawValue)]
        return settings
    }
    
    func updateRecordButtonTitle(){
        if(audioRecorder.isRecording){
            buttonRecord.setTitle(ViewController.text_buttonStop[appDelegate.userLanguage.rawValue], for: .normal)
            buttonPlay.isEnabled = false
            
            imagePlay.isHidden = true
            imageRecord.isHidden = false
        }else{
            buttonRecord.setTitle(ViewController.text_buttonRecord[appDelegate.userLanguage.rawValue], for: .normal)
            if verifyFileExists() {
                buttonPlay.isEnabled = true
                
                imagePlay.isHidden = true
                imageRecord.isHidden = true
            }
        }
    }
    
    func verifyFileExists() -> Bool {
        let fileManager = FileManager.default
        
        let path = self.audioFileLocation()
        return fileManager.fileExists(atPath: path)
    }
    
    func verifyFileExists(path: String) -> Bool {
        let fileManager = FileManager.default
        
        return fileManager.fileExists(atPath: path)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if verifyFileExists() {
            buttonPlay.isEnabled = true
            
            imagePlay.isHidden = true
            imageRecord.isHidden = true
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying")
        buttonRecord.isEnabled = true
        buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.userLanguage.rawValue], for: .normal)
        
        imagePlay.isHidden = true
        imageRecord.isHidden = true
        
        checkContinuosPlay(true)
    }
    
    func checkContinuosPlay(_ autoAdvanceToNextVerse: Bool) {
        //Continous play
        var keepChecking = true
        if appDelegate.continualPlay {
            print("**Checking continous play")
            
            if autoAdvanceToNextVerse {
                let subBook_prev = appDelegate.subBookString
                chapter_prev = appDelegate.chapter
                verse_prev = appDelegate.verse
                goToNextVerse()
                if subBook_prev != appDelegate.subBookString ||
                    chapter_prev != appDelegate.chapter ||
                    verse_prev != appDelegate.verse {
                    //we have changed to a new verse
                    print("   Went to next verse")
                    keepChecking = true
                }else{
                    keepChecking = false
                }
            }
            
            if keepChecking{
                if verifyFileExists() { //see if the new verse exists
                    //if the verse exists, start playing it
                    print("   Start next Continous Play verse")
                    buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.userLanguage.rawValue], for: .normal)
                    playActions()
                }else {
                    print("   Verse does not exist")
                    switch appDelegate.userLanguage {
                    case .English:
                        Utilities().popupMessage(view: self, title: "Playing Stopped", message: "Continuous Play stopped because you reached a verse that has not been recorded.", button: "OK")
                    case .Spanish:
                        Utilities().popupMessage(view: self, title: "Jugando detenido", message: "El juego continuo se detuvo porque llegaste a un verso que no se ha grabado.", button: "Bueno")
                    case .Portuguese:
                        Utilities().popupMessage(view: self, title: "Jogando parado", message: "A Reprodução Contínua parou porque você chegou a um versículo que não foi gravado.", button: "OK")
                    }
                }
            }else {
                switch appDelegate.userLanguage {
                case .English:
                    Utilities().popupMessage(view: self, title: "Playing Stopped", message: "Continuous Play stopped because you reached the end of the book.", button: "OK")
                case .Spanish:
                    Utilities().popupMessage(view: self, title: "Jugando detenido", message: "El juego continuo se detuvo porque llegaste al final del libro.", button: "Bueno")
                case .Portuguese:
                    Utilities().popupMessage(view: self, title: "Jogando parado", message: "A Reprodução Contínua foi interrompida porque você chegou ao final do livro.", button: "OK")
                }
            }
        }
    }
    
    func updateBookStrings(){
        var resetChapterAndVerse = false
        
        
        if appDelegate.goToBookmark {
            appDelegate.goToBookmark = false
        }else {
            if(appDelegate.bookString != appDelegate.bookString_prev){
                let var1 = Const.SUB_BOOK_LIST[appDelegate.userLanguage.rawValue]
                let var2 = var1[appDelegate.bookEnum.rawValue]
                var index = Utilities().getCurrentSubBookIndex()
                if index == -1 {
                    index = 0
                }
                let var3 = var2[index]
                appDelegate.subBookString = var3    //TODO is this right?
                resetChapterAndVerse = true
            }
            
            if(appDelegate.subBookString != appDelegate.subBookString_prev){
                resetChapterAndVerse = true
            }
            
            if(resetChapterAndVerse){
                appDelegate.chapter = 1
                appDelegate.verse = Utilities().getMinVerse()
                textChapter.text = "\(appDelegate.chapter)"
                textVerse.text = "\(appDelegate.verse)"
            }
        }
        
        updateUI()
        
        appDelegate.bookString_prev = appDelegate.bookString
        appDelegate.subBookString_prev = appDelegate.subBookString
    }
    
    func updateUI(){
        var wasPlaying = false
        stop_Recording_and_Playing()
        
        if(audioPlayer != nil && audioPlayer.isPlaying == true) {
            wasPlaying = true
            audioPlayer.stop()
            buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.userLanguage.rawValue], for: .normal)
            
            imagePlay.isHidden = true
            imageRecord.isHidden = true
        }
        
        if (appDelegate.verse == -1 && Utilities().getCurrentChapterObject().hasPreHeading == false) || (appDelegate.verse == 0 && Utilities().getCurrentChapterObject().hasHeading == false) {
            appDelegate.verse = 1
        }
        
        textChapter.text = "\(appDelegate.chapter)"
        textVerse.text = "\(appDelegate.verse)"
        
        var verseString = ""
        let subBook = Utilities().getCurrentSubBook()
        if appDelegate.verse == -1 && appDelegate.chapter == 1 {
            switch appDelegate.userLanguage {
            case .English:
                verseString = " - Book Title and Book Summary"
            case .Spanish:
                verseString = " - Título del libro y resumen del libro"
            case .Portuguese:
                verseString = " - Título do livro e resumo do livro"
            }
        }else if subBook.Name.contains("Intro") || subBook.Name.contains("Title") || subBook.Name.contains("Dedicatory") || subBook.Name.contains(" Testimony") ||          subBook.Name.contains("Portada") || subBook.Name.contains("") || subBook.Name.contains("Introducción") || subBook.Name.contains("Testimonio ") {
            verseString = ""
        }else if appDelegate.verse == -1 {
            switch appDelegate.userLanguage {
            case .English:
                verseString = " - Chapter Pre-heading"
            case .Spanish:
                verseString = " - Antes del título del capítulo"
            case .Portuguese:
                verseString = " - Capítulo Pré-cabeçalho"
            }
        }else if subBook.Name[appDelegate.userLanguage.rawValue] == Const.PGP_AofF_ARRAY[appDelegate.userLanguage.rawValue] && appDelegate.verse == 0 {
            switch appDelegate.userLanguage {
            case .English:
                verseString = " - Articles of Faith Title"
            case .Spanish:
                verseString = " - Artículos de Fe, Título"
            case .Portuguese:
                verseString = " - Regras de Fé, Título"
            }
        }else if (appDelegate.chapter == 116 || appDelegate.chapter == 120) &&
                    subBook.Name[appDelegate.userLanguage.rawValue] == Const.DC_SECTIONS_ARRAY[appDelegate.userLanguage.rawValue] &&
                    appDelegate.verse == 0 {
            switch appDelegate.userLanguage {
            case .English:
                verseString = " - Chapter Pre-heading"
            case .Spanish:
                verseString = " - Antes del título del capítulo"
            case .Portuguese:
                verseString = " - Capítulo Pré-cabeçalho"
            }
        }else if appDelegate.verse == 0 {
            switch appDelegate.userLanguage {
            case .English:
                verseString = " - Chapter Heading"
            case .Spanish:
                verseString = " - Título del Capítulo"
            case .Portuguese:
                verseString = " - Título do Capítulo"
            }
        }else {
            verseString = ":\(appDelegate.verse)"
        }
        
        let subBookString = Const.SUB_BOOK_LIST[appDelegate.userLanguage.rawValue][appDelegate.bookEnum.rawValue][Utilities().getCurrentSubBookIndex()]
        
        let description = Utilities().getCurrentChapterObject().optionalDescription.Description
        textViewVerse.text = "\(subBookString) \(appDelegate.chapter)\(verseString)\n\(description[appDelegate.userLanguage.rawValue])"
        
//        buttonBook.setTitle(" \(appDelegate.bookString)", for: .normal)
//        buttonSubBook.setTitle(" \(appDelegate.subBookString)", for: .normal)
        buttonBook.setTitle(" \(Const.BOOK_LIST[appDelegate.userLanguage.rawValue][appDelegate.bookEnum.rawValue])", for: .normal)
        buttonSubBook.setTitle(" \(Const.SUB_BOOK_LIST[appDelegate.userLanguage.rawValue][appDelegate.bookEnum.rawValue][Utilities().getCurrentSubBookIndex()])", for: .normal)    //TODO fix
        
        let url = Utilities().getScriptureUrl()
        let currentURL = self.webView.request?.url?.absoluteString
        if url.absoluteString != currentURL {   //don't refresh page if we are already there
            webView.loadRequest(URLRequest(url: url))
        }
        
        updateAudioRecordingName()
        Utilities().saveDefaults()
        
        if wasPlaying {
            checkContinuosPlay(false)
        }
    }
    
    func updateAudioRecordingName() {
        //default ->   var audioRecordingName = "audioRecording.m4a"
    #if true
        let chapterString = String(format: "%03d", appDelegate.chapter)
        let verseString = String(format: "%03d", appDelegate.verse)
            
        var directory = appDelegate.userName.replacingOccurrences(of: " ", with: "").lowercased()
        createTempDirectory(directory)
        directory += "/" + Utilities().getCurrentBook().Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
        createTempDirectory(directory)
        directory += "/" + Utilities().getCurrentSubBook().Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
        createTempDirectory(directory)
        
        audioRecordingName = "\(directory)/S\(chapterString)\(verseString).m4a"
        //audioRecordingName = "S\(chapterString)\(verseString).m4a"
    #endif
        if verifyFileExists() && audioRecorder.isRecording == false {
            buttonPlay.isEnabled = true
        }else {
            buttonPlay.isEnabled = false
        }
    }
    
    func createTempDirectory(_ directory: String) {
        
        let filemgr = FileManager.default
        
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docsURL = dirPaths[0]
        
        let newDir = docsURL.appendingPathComponent(directory).path
        
        do {
            try filemgr.createDirectory(atPath: newDir,
                                        withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
}

//TODO add for Cloud
//extension DispatchQueue {
//    
//    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
//        DispatchQueue.global(qos: .background).async {
//            background?()
//            if let completion = completion {
//                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
//                    completion()
//                })
//            }
//        }
//    }
//    
//}

//TODO ***


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
