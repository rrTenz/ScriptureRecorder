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
    
    static let text_buttonRecord = ["Record", "Grabar"]
    static let text_buttonPlay = ["Play", "Tocar"]
    static let text_buttonShare = ["Share", "Compartir"]
    static let text_buttonStop = ["Stop", "Parar"]
    
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
            Utilities().popupMessage(view: self, title: "User changed", message: "User changed to:\n\(appDelegate.userName)", button: "OK")
            appDelegate.userName_prev = appDelegate.userName
        }
        
        if appDelegate.shareFile {
            appDelegate.shareFile = false
            shareFile()
        }
        
        buttonRecord.setTitle(ViewController.text_buttonRecord[appDelegate.Language.rawValue], for: .normal)
        buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.Language.rawValue], for: .normal)
        buttonSave.setTitle(ViewController.text_buttonShare[appDelegate.Language.rawValue], for: .normal)
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
    
    func shareFile() {
        var fileExists = false
        
        //Create desired file
        if appDelegate.whatToShare == .Verse {
            //there is nothing to create
            fileExists = verifyFileExists()
        }else {
            if Utilities().combineFile() == false {
                Utilities().popupMessage(view: self, title: "Error", message: "The combined file could not be created", button: "OK")
            }else {
                fileExists = true
            }
        }
        
        //TODO check if combined file exists
        if fileExists {
            var path = ""
            var audioData: NSURL
            if appDelegate.whatToShare == .Verse {
                path = self.audioFileLocation()
                audioData = NSURL(fileURLWithPath: path)
            }else {
                audioData = appDelegate.mergeAudioURL
            }
            let activityVC = UIActivityViewController(activityItems:[audioData], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
        }else{
            Utilities().popupMessage(view: self, title: "Oops", message: "File does not exisit", button: "OK")
        }
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
            Utilities().popupMessage(view: self, title: "Oops", message: "The file does not exist", button: "Done")
            return
        }
        if !audioRecorder.isRecording{  //don't play when recording
            if buttonPlay.titleLabel?.text == ViewController.text_buttonPlay[appDelegate.Language.rawValue] ||
                (audioPlayer != nil && audioPlayer.isPlaying == false) {
                buttonRecord.isEnabled = false
                buttonPlay.setTitle(ViewController.text_buttonStop[appDelegate.Language.rawValue], for: .normal)
                
                imagePlay.isHidden = false
                imageRecord.isHidden = true
                
                preparePlayer()
                audioPlayer.play()
            }else{
                audioPlayer.stop()
                buttonRecord.isEnabled = true
                buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.Language.rawValue], for: .normal)
                
                imagePlay.isHidden = true
                imageRecord.isHidden = true
            }
        }
    }
    
    func stop_Recording_and_Playing() {
        if audioRecorder.isRecording{
            stopRecording()
        }
        if buttonPlay.titleLabel?.text == ViewController.text_buttonStop[appDelegate.Language.rawValue] ||
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
                    Utilities().popupMessage(view: self, title: "Recording Stopped", message: "This verse has previously been recorded. Continual Record has stopped.", button: "OK")
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
                    Utilities().popupMessage(view: self, title: "Recording Stopped", message: "This verse has previously been recorded. Continual Record has stopped.", button: "OK")
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
            appDelegate.subBookString = subList[subBookIndex].Name[appDelegate.Language.rawValue]
            appDelegate.chapter = Utilities().getCurrentSubBook().ChapterArray.count
            appDelegate.verse = Utilities().getCurrentChapterObject().verseCount
            appDelegate.subBookString_prev = appDelegate.subBookString
        }else{
            Utilities().popupMessage(view: self, title: "Beginning of Book", message: "There is not a previous chapter or verse in this book", button: "OK")
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
            appDelegate.subBookString = subList[subBookIndex].Name[appDelegate.Language.rawValue]
            appDelegate.chapter = 1
            appDelegate.verse = Utilities().getMinVerse()
            appDelegate.subBookString_prev = appDelegate.subBookString
        }else{
            Utilities().popupMessage(view: self, title: "End of Book", message: "There is not another chapter or verse in this book", button: "OK")
            appDelegate.chapter = chapter_prev
            appDelegate.verse = verse_prev
        }
        
        updateUI()
    }
    
    // MARK: Main
    func prepareAudioRecorder(){
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
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
            Utilities().popupMessage(view: self, title: "Oops", message: "The file does not exist", button: "Done")
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
            buttonRecord.setTitle(ViewController.text_buttonStop[appDelegate.Language.rawValue], for: .normal)
            buttonPlay.isEnabled = false
            
            imagePlay.isHidden = true
            imageRecord.isHidden = false
        }else{
            buttonRecord.setTitle(ViewController.text_buttonRecord[appDelegate.Language.rawValue], for: .normal)
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
        buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.Language.rawValue], for: .normal)
        
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
                    buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.Language.rawValue], for: .normal)
                    playActions()
                }else {
                    print("   Verse does not exist")
                    Utilities().popupMessage(view: self, title: "Playing Stopped", message: "Continuous Play stopped because you reached a verse that has not been recorded.", button: "OK")
                }
            }else {
                Utilities().popupMessage(view: self, title: "Playing Stopped", message: "Continuous Play stopped because you reached the end of the book.", button: "OK")
            }
        }
    }
    
    func updateBookStrings(){
        var resetChapterAndVerse = false
        
        
        if appDelegate.goToBookmark {
            appDelegate.goToBookmark = false
        }else {
            if(appDelegate.bookString != appDelegate.bookString_prev){
                let var1 = Const.SUB_BOOK_LIST[appDelegate.Language.rawValue]
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
            buttonPlay.setTitle(ViewController.text_buttonPlay[appDelegate.Language.rawValue], for: .normal)
            
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
            if appDelegate.Language == .English {
                verseString = " - Book Title and Book Summary"
            }else if appDelegate.Language == .Spanish {
                verseString = " - Título del libro y resumen del libro"
            }else {
                fatalError()
            }
        }else if subBook.Name.contains("Intro") || subBook.Name.contains("Title") || subBook.Name.contains("Dedicatory") || subBook.Name.contains(" Testimony") ||          subBook.Name.contains("Portada") || subBook.Name.contains("") || subBook.Name.contains("Introducción") || subBook.Name.contains("Testimonio ") {
            verseString = ""
        }else if appDelegate.verse == -1 {
            if appDelegate.Language == .English {
                verseString = " - Chapter Pre-heading"
            }else if appDelegate.Language == .Spanish {
                verseString = " - Antes del título del capítulo"
            }else {
                fatalError()
            }
        }else if subBook.Name[appDelegate.Language.rawValue] == Const.PGP_AofF_ARRAY[appDelegate.Language.rawValue] && appDelegate.verse == 0 {
            verseString = " - Articles of Faith Title"
            if appDelegate.Language == .English {
                verseString = " - Articles of Faith Title"
            }else if appDelegate.Language == .Spanish {
                verseString = " - Artículos de Fe, Título"
            }else {
                fatalError()
            }
        }else if (appDelegate.chapter == 116 || appDelegate.chapter == 120) &&
                    subBook.Name[appDelegate.Language.rawValue] == Const.DC_SECTIONS_ARRAY[appDelegate.Language.rawValue] &&
                    appDelegate.verse == 0 {
            if appDelegate.Language == .English {
                verseString = " - Chapter Pre-heading"
            }else if appDelegate.Language == .Spanish {
                verseString = " - Antes del título del capítulo"
            }else {
                fatalError()
            }
        }else if appDelegate.verse == 0 {
            verseString = " - Chapter Heading"
            if appDelegate.Language == .English {
                verseString = " - Chapter Heading"
            }else if appDelegate.Language == .Spanish {
                verseString = " - Título del Capítulo"
            }else {
                fatalError()
            }
        }else {
            verseString = ":\(appDelegate.verse)"
        }
        
        let subBookString = Const.SUB_BOOK_LIST[appDelegate.Language.rawValue][appDelegate.bookEnum.rawValue][Utilities().getCurrentSubBookIndex()]
        
        let description = Utilities().getCurrentChapterObject().optionalDescription.Description
        textViewVerse.text = "\(subBookString) \(appDelegate.chapter)\(verseString)\n\(description[appDelegate.Language.rawValue])"
        
//        buttonBook.setTitle(" \(appDelegate.bookString)", for: .normal)
//        buttonSubBook.setTitle(" \(appDelegate.subBookString)", for: .normal)
        buttonBook.setTitle(" \(Const.BOOK_LIST[appDelegate.Language.rawValue][appDelegate.bookEnum.rawValue])", for: .normal)
        buttonSubBook.setTitle(" \(Const.SUB_BOOK_LIST[appDelegate.Language.rawValue][appDelegate.bookEnum.rawValue][Utilities().getCurrentSubBookIndex()])", for: .normal)    //TODO fix
        
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

