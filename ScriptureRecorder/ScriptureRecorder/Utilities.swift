//
//  Utilities.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 8/8/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import AVFoundation

struct Utilities {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    struct defaultsKeys {
        static let key_bookEnum = "bookEnum"
        static let key_bookString = "bookString"
        static let key_subBookString = "subBookString"
        static let key_chapter = "chapter"
        static let key_verse = "verse"
        static let key_userName = "userName"
        static let key_userArray = "userArray"
        static let key_languageURL = "languageURL"
        static let key_continualPlay = "continualPlay"
        static let key_continualRecord = "continualRecord"
        
        //bookmarks
        static let key_bookEnum_bm = "bookEnum_bm" //each of this will need to have an index (0-5) added to the end
        static let key_bookString_bm = "bookString_bm"
        static let key_subBookString_bm = "subBookString_bm"
        static let key_chapter_bm = "chapter_bm"
        static let key_verse_bm = "verse_bm"
    }
    
    func loadDefaults(loadUser: Bool) {
        // Getting
        
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: defaultsKeys.key_userName) == nil {
            return
        }
        if loadUser {
            appDelegate.userName = defaults.string(forKey: defaultsKeys.key_userName)!  //get userName first, all other keys use it
        }
        
        if defaults.string(forKey: defaultsKeys.key_userName) == nil || //don't append userName to itself
            defaults.array(forKey: defaultsKeys.key_userArray) == nil ||
            defaults.string(forKey: appDelegate.userName + defaultsKeys.key_bookString) == nil ||
            defaults.string(forKey: appDelegate.userName + defaultsKeys.key_subBookString) == nil ||
            defaults.string(forKey: appDelegate.userName + defaultsKeys.key_languageURL) == nil {
            for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                print("\(key) = \(value) \n")
            }
            return
        }
        
        appDelegate.userArray = defaults.array(forKey: defaultsKeys.key_userArray)! as! [String]
        
        appDelegate.bookEnum = Const.Book(rawValue: defaults.integer(forKey: appDelegate.userName + defaultsKeys.key_bookEnum))!
        appDelegate.bookString = defaults.string(forKey: appDelegate.userName + defaultsKeys.key_bookString)!
        appDelegate.subBookString = defaults.string(forKey: appDelegate.userName + defaultsKeys.key_subBookString)!
        appDelegate.chapter = defaults.integer(forKey: appDelegate.userName + defaultsKeys.key_chapter)
        appDelegate.verse = defaults.integer(forKey: appDelegate.userName + defaultsKeys.key_verse)
        appDelegate.languageURL = defaults.string(forKey: appDelegate.userName + defaultsKeys.key_languageURL)!
        appDelegate.continualPlay = defaults.bool(forKey: appDelegate.userName + defaultsKeys.key_continualPlay)
        appDelegate.continualRecord = defaults.bool(forKey: appDelegate.userName + defaultsKeys.key_continualRecord)
        
        appDelegate.bookString_prev = appDelegate.bookString
        appDelegate.subBookString_prev = appDelegate.subBookString
        appDelegate.userName_prev = appDelegate.userName
        
        loadBookmarks()
    }
    
    func loadBookmarks() {
        let defaults = UserDefaults.standard
        
        var i = 0
        while i < 6 {
            let str = "\(i)"
            if defaults.string(forKey: appDelegate.userName + defaultsKeys.key_bookString_bm + str) == nil ||
                defaults.string(forKey: appDelegate.userName + defaultsKeys.key_subBookString_bm + str) == nil {
                //do nothing if these values are nil
            }else {
                appDelegate.bookmarks[i].bookEnum = Const.Book(rawValue: defaults.integer(forKey: appDelegate.userName + defaultsKeys.key_bookEnum_bm + str))!
                appDelegate.bookmarks[i].bookString = defaults.string(forKey: appDelegate.userName + defaultsKeys.key_bookString_bm + str)!
                appDelegate.bookmarks[i].subBookString = defaults.string(forKey: appDelegate.userName + defaultsKeys.key_subBookString_bm + str)!
                appDelegate.bookmarks[i].chapter = defaults.integer(forKey: appDelegate.userName + defaultsKeys.key_chapter_bm + str)
                appDelegate.bookmarks[i].verse = defaults.integer(forKey: appDelegate.userName + defaultsKeys.key_verse_bm + str)
            }
            i += 1
        }
    }
    
    func saveDefaults() {
        // Setting
        
//        if appDelegate.userName == nil || //don't append userName to itself
//            appDelegate.bookString == nil ||
//            appDelegate.userArray == nil ||
//            defaultsKeys.key_subBookString == nil ||
//            defaultsKeys.key_languageURL == nil  {
//            return
//        }
        
        let defaults = UserDefaults.standard
        defaults.set(appDelegate.userName, forKey: defaultsKeys.key_userName)  //get userName first, all other keys use it
        defaults.set(appDelegate.userArray, forKey: defaultsKeys.key_userArray)
        
        defaults.set(appDelegate.bookEnum.rawValue, forKey: appDelegate.userName + defaultsKeys.key_bookEnum)
        defaults.set(appDelegate.bookString, forKey: appDelegate.userName + defaultsKeys.key_bookString)
        defaults.set(appDelegate.subBookString, forKey: appDelegate.userName + defaultsKeys.key_subBookString)
        defaults.set(appDelegate.chapter, forKey: appDelegate.userName + defaultsKeys.key_chapter)
        defaults.set(appDelegate.verse, forKey: appDelegate.userName + defaultsKeys.key_verse)
        defaults.set(appDelegate.languageURL, forKey: appDelegate.userName + defaultsKeys.key_languageURL)
        defaults.set(appDelegate.continualPlay, forKey: appDelegate.userName + defaultsKeys.key_continualPlay)
        defaults.set(appDelegate.continualRecord, forKey: appDelegate.userName + defaultsKeys.key_continualRecord)
        
        saveBookmarks()
    }
    
    func saveBookmarks() {
        let defaults = UserDefaults.standard
        
        var i = 0
        while i < 6 {
            let str = "\(i)"
            defaults.set(appDelegate.bookmarks[i].bookEnum.rawValue, forKey: appDelegate.userName + defaultsKeys.key_bookEnum_bm + str)
            defaults.set(appDelegate.bookmarks[i].bookString, forKey: appDelegate.userName + defaultsKeys.key_bookString_bm + str)
            defaults.set(appDelegate.bookmarks[i].subBookString, forKey: appDelegate.userName + defaultsKeys.key_subBookString_bm + str)
            defaults.set(appDelegate.bookmarks[i].chapter, forKey: appDelegate.userName + defaultsKeys.key_chapter_bm + str)
            defaults.set(appDelegate.bookmarks[i].verse, forKey: appDelegate.userName + defaultsKeys.key_verse_bm + str)
            i += 1
        }
    }
    
    func getMinVerse() -> Int {
        var minVerse = 1
        if getCurrentChapterObject().hasHeading {
            minVerse = 0
        }
        if getCurrentChapterObject().hasPreHeading {
            minVerse = -1
        }
        return minVerse
    }
    
    
    func getCurrentChapterObject() -> Scripture.Chapter {
        let subBook = getCurrentSubBook()
        if appDelegate.chapter == 0 {appDelegate.chapter = 1}
        let chapter = subBook.ChapterArray[appDelegate.chapter - 1]
        return chapter
    }
    
    func getMaxVerse() -> Int {
        let subBook = getCurrentSubBook()
        if appDelegate.chapter == 0 {appDelegate.chapter = 1}
        let chapter = subBook.ChapterArray[appDelegate.chapter - 1]
        return chapter.verseCount
    }
    
    func chapterHasPreheading() -> Bool {
        let subBook = getCurrentSubBook()
        if appDelegate.chapter == 0 {appDelegate.chapter = 1}
        if(appDelegate.chapter - 1 >= subBook.ChapterArray.count) {
            return false
        }
        if appDelegate.chapter == 0 {appDelegate.chapter = 1}
        let chapter = subBook.ChapterArray[appDelegate.chapter - 1]
        if(chapter.hasPreHeading){
            return true
        }
        return false
    }
    
    func getCurrentBook() -> Scripture.Book {
        var book: Scripture.Book? = nil
        
        appDelegate.bookString = Const.BOOK_LIST[appDelegate.Language.rawValue][appDelegate.bookEnum.rawValue]
        switch appDelegate.bookString {
        case Const.BOM, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.BOM.rawValue]:
            book = Scripture.BOM
        case Const.PGP, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.PGP.rawValue]:
            book = Scripture.PGP
        case Const.DC, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.DC.rawValue]:
            book = Scripture.DC
        case Const.OT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.OT.rawValue]:
            book = Scripture.OT
        case Const.NT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.NT.rawValue]:
            book = Scripture.NT
        default:
            print("Book not added getCurrentBook()")
        }
        return book!
    }
    
    func getCurrentSubBook() -> Scripture.SubBook {
        let book = getCurrentBook()
        
        var subBook: Scripture.SubBook? = nil
        
        let var1 = Const.SUB_BOOK_LIST[appDelegate.Language.rawValue]
        let var2 = var1[appDelegate.bookEnum.rawValue]
        var index = getCurrentSubBookIndex()
        if index == -1 {
            index = 0
        }
        let var3 = var2[index]
        appDelegate.subBookString = var3
        
        for tempSubBook in book.SubBookArray {
            if tempSubBook.Name[appDelegate.Language.rawValue] == appDelegate.subBookString {
                subBook = tempSubBook
                break
            }
        }
        
        return subBook!
    }
    
    func getBookFromString(_ book_str: String) -> Scripture.Book {
        for book in Scripture.ALL {
            if(book.Name[AppDelegate.Language.English.rawValue] == book_str || book.Name[appDelegate.Language.rawValue] == book_str) {
                return book
            }
        }
        return Scripture.Book(Name: ["", ""], SubBookArray: [])
    }
    
    func getSubBookFromStrings(_ book_str: String, _ subBook_str: String) -> Scripture.SubBook {
        for book in Scripture.ALL {
            if(book.Name[AppDelegate.Language.English.rawValue] == book_str || book.Name[appDelegate.Language.rawValue] == book_str) {
                for subBook in book.SubBookArray {
                    if subBook.Name[AppDelegate.Language.English.rawValue] == subBook_str || subBook.Name[appDelegate.Language.rawValue] == subBook_str {
                        return subBook
                    }
                }
            }
        }
        return Scripture.SubBook(Name: ["", ""], ChapterArray: [])
    }
    
    func getCurrentSubBookIndex() -> Int {
        let book = getCurrentBook()
        
        var index = 0
        for tempSubBook in book.SubBookArray {
            if tempSubBook.Name[appDelegate.Language.rawValue] == appDelegate.subBookString {
                return index
            }
            index += 1
        }
        
        print("Sub Book not added")
        return -1
    }
    
    func getScriptureUrl() -> URL {
        let chapter = getCurrentChapterObject()
        var returnString = Const.URL_LDS_SCRIPTURES
        let subBook = getCurrentSubBook()
        appDelegate.languageURL = appDelegate.languageURL_array[appDelegate.Language.rawValue]
        
        if chapter.optionalDescription.Description[0].contains("Record your testimony") {
            returnString = Const.URL_LDS_TESTIMONY + appDelegate.languageURL
            return URL(string: returnString)!
        }
        
        switch appDelegate.bookString {
        case Const.BOM, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.BOM.rawValue]:
            returnString += Const.URL_BOM
            if chapter.optionalDescription.Description[0] == "Title Page" {
                returnString += Const.URL_BOM_TITLE_PAGE
            }else if chapter.optionalDescription.Description[0].contains("Title Page of the Book of Mormon") {
                returnString += Const.URL_BOM_TITLE
            }else if chapter.optionalDescription.Description[0].contains("Introduction") {
                returnString += Const.URL_BOM_INTRO
            }else if chapter.optionalDescription.Description[0].contains("Testimony of Three") {
                returnString += Const.URL_BOM_3_WITNESSES
            }else if chapter.optionalDescription.Description[0].contains("Testimony of Eight") {
                returnString += Const.URL_BOM_8_WITNESSES
            }else if chapter.optionalDescription.Description[0].contains("Testimony of the Prophet") {
                returnString += Const.URL_BOM_JS_TESTIMONY
            }else if chapter.optionalDescription.Description[0].contains("A Brief Explanation") {
                returnString += Const.URL_BOM_EXPLANATION
            }else {
                let index = getCurrentSubBookIndex()
                returnString += Const.URL_BOM_LIST[index]
                returnString += "\(appDelegate.chapter)"
                //returnString += ".\(appDelegate.verse)"
            }
        case Const.PGP, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.PGP.rawValue]:
            returnString += Const.URL_PGP
            if subBook.Name[appDelegate.Language.rawValue] == Const.PGP_LIST[appDelegate.Language.rawValue][0] {
                returnString += Const.URL_PGP_TITLE
            }else if subBook.Name[appDelegate.Language.rawValue] == Const.PGP_LIST[appDelegate.Language.rawValue][1] {
                returnString += Const.URL_PGP_INTRO
            }else {
                let index = getCurrentSubBookIndex()
                returnString += Const.URL_PGP_LIST[index]
                returnString += "\(appDelegate.chapter)"
            }
        case Const.DC, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.DC.rawValue]:
            returnString += Const.URL_DC
            if subBook.Name[appDelegate.Language.rawValue] == Const.DC_LIST[appDelegate.Language.rawValue][0] {
                returnString += Const.URL_DC_TITLE
            }else if subBook.Name[appDelegate.Language.rawValue] == Const.DC_LIST[appDelegate.Language.rawValue][1] {
                returnString += Const.URL_DC_INTRO
            }else if subBook.Name[appDelegate.Language.rawValue] == Const.DC_LIST[appDelegate.Language.rawValue][3]{
                returnString += Const.URL_DC_OFFICIAL_DECLARATIONS
                returnString += "\(1)"
            }else if subBook.Name[appDelegate.Language.rawValue] == Const.DC_LIST[appDelegate.Language.rawValue][4]{
                returnString += Const.URL_DC_OFFICIAL_DECLARATIONS
                returnString += "\(2)"
            }else {
                let index = getCurrentSubBookIndex()
                returnString += Const.URL_DC_LIST[index]
                returnString += "\(appDelegate.chapter)"
            }
        case Const.OT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.OT.rawValue]:
            returnString += Const.URL_OT
            if subBook.Name[appDelegate.Language.rawValue] == Const.OT_LIST[appDelegate.Language.rawValue][0] {
                returnString += Const.URL_OT_TITLE
            }else if subBook.Name[appDelegate.Language.rawValue] == Const.OT_LIST[appDelegate.Language.rawValue][1] {
                if appDelegate.Language == .English {
                    returnString += Const.URL_OT_EPISTLE
                }else {
                    returnString += Const.URL_OT_INTRO
                }
            }else {
                let index = getCurrentSubBookIndex()
                returnString += Const.URL_OT_LIST[index]
                returnString += "\(appDelegate.chapter)"
            }
        case Const.NT, Const.BOOK_LIST[appDelegate.Language.rawValue][Const.Book.NT.rawValue]:
            returnString += Const.URL_NT
            if subBook.Name[appDelegate.Language.rawValue] == Const.NT_LIST[appDelegate.Language.rawValue][0] {
                returnString += Const.URL_NT_TITLE
            }else {
                let index = getCurrentSubBookIndex()
                returnString += Const.URL_NT_LIST[index]
                returnString += "\(appDelegate.chapter)"
            }
        default:
            print("Book not added getScriptureUrl()")
        }
        
        returnString += appDelegate.languageURL
        
        return URL(string: returnString)!
    }
    
    func updateProgressPercentages_all() {
        print("updateProgressPercentages: start")
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        for book in Scripture.ALL {
            for subBook in book.SubBookArray {
                var subDirectory = "/" + appDelegate.userName.replacingOccurrences(of: " ", with: "").lowercased()
                subDirectory += "/" + book.Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
                subDirectory += "/" + subBook.Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
                let fullDirectory = documentsPath + subDirectory
                
                let dirContents = try? fileManager.contentsOfDirectory(atPath: fullDirectory)
                let count = dirContents?.count
                if dirContents != nil && count! > 0 {
                    print("\(subBook.Name) has some: \(count!)/\(getSubBookVerseCount(subBook))")
                }
            }
        }
        print("updateProgressPercentages: done")
    }
    
    func getProgressString_fraction(_ book: Scripture.Book, _ subBook: Scripture.SubBook) -> String{
        var returnString = ""
        
        let count = getProgressCount(book, subBook)
        returnString = "\(count)/\(getSubBookVerseCount(subBook))"
        
        return returnString
    }
    
    func getProgressCount(_ book: Scripture.Book, _ subBook: Scripture.SubBook) -> Int{
        var returnCount = 0
        
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        var subDirectory = "/" + appDelegate.userName.replacingOccurrences(of: " ", with: "").lowercased()
        subDirectory += "/" + book.Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
        subDirectory += "/" + subBook.Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
        let fullDirectory = documentsPath + subDirectory
        
        let dirContents = try? fileManager.contentsOfDirectory(atPath: fullDirectory)
        if dirContents != nil {
            returnCount = (dirContents?.count)!
        }
        
        return returnCount
    }
    
    func getSubBookVerseCount(_ subBook: Scripture.SubBook) -> Int {
        var verseCount = 0
        for chapter in subBook.ChapterArray {
            verseCount += chapter.verseCount
        }
        return verseCount
    }
    
    //https://stackoverflow.com/questions/30479403/concatenate-two-audio-files-in-swift-and-play-them
    /*
     audioFileUrls - array of files to merge
     fileName - e.g. "FinalAudio.m4a"
 
     */
    func mergeAudioFiles(audioFileUrls: NSArray, fileName: String) {
        let composition = AVMutableComposition()
        
        for i in 0 ..< audioFileUrls.count {
            
            let compositionAudioTrack :AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
            
            let asset = AVURLAsset(url: (audioFileUrls[i] as! NSURL) as URL)
            
            let track = asset.tracks(withMediaType: AVMediaTypeAudio)[0]
            
            let timeRange = CMTimeRange(start: CMTimeMake(0, 600), duration: track.timeRange.duration)
            
            try! compositionAudioTrack.insertTimeRange(timeRange, of: track, at: composition.duration)
        }
        
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        appDelegate.mergeAudioURL = documentDirectoryURL.appendingPathComponent(fileName)! as URL as NSURL
        
        do {
            try FileManager.default.removeItem(at: appDelegate.mergeAudioURL as URL)
        } catch let error as NSError {
            print("Error: \(error.domain)")
        }
        
        let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)
        assetExport?.outputFileType = AVFileTypeAppleM4A
        assetExport?.outputURL = appDelegate.mergeAudioURL as URL
        assetExport?.exportAsynchronously(completionHandler:
            {
                switch assetExport!.status
                {
                case AVAssetExportSessionStatus.failed:
                    print("failed \(String(describing: assetExport?.error))")
                case AVAssetExportSessionStatus.cancelled:
                    print("cancelled \(String(describing: assetExport?.error))")
                case AVAssetExportSessionStatus.unknown:
                    print("unknown\(String(describing: assetExport?.error))")
                case AVAssetExportSessionStatus.waiting:
                    print("waiting\(String(describing: assetExport?.error))")
                case AVAssetExportSessionStatus.exporting:
                    print("exporting\(String(describing: assetExport?.error))")
                default:
                    print("Audio Concatenation Complete")
                }
        })
    }
    
    func combineFile() -> Bool{
        var fullDirectory = ""
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let book = getBookFromString(appDelegate.bookString)
        let subBook = getSubBookFromStrings(appDelegate.bookString, appDelegate.subBookString)
        
        var subDirectory = "/" + appDelegate.userName.replacingOccurrences(of: " ", with: "").lowercased()
        subDirectory += "/" + book.Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
        
        if appDelegate.whatToShare == .SubBook || appDelegate.whatToShare == .Chapter {
            subDirectory += "/" + subBook.Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
        }
        
        fullDirectory = documentsPath + subDirectory
        
        var audioArray = [NSURL]()
        var directoryCount = 0
        var bookName = ""
        var directoryList = [String]()
        var i = 0
        if appDelegate.whatToShare == .Book {
            directoryList = try! fileManager.contentsOfDirectory(atPath: fullDirectory)
            directoryCount = directoryList.count
        }else {
            directoryCount = 1
            bookName = ""
        }
        
        while directoryCount > 0 {
            directoryCount -= 1
            
            if appDelegate.whatToShare == .Book {   //Make sure subbooks get combined in the correct order
                bookName = ""
                while i < book.SubBookArray.count {
                    for name in directoryList {
                        let subBookName = book.SubBookArray[i].Name[AppDelegate.Language.English.rawValue].replacingOccurrences(of: " ", with: "")
                        if name == subBookName {
                            bookName = "/" + name
                            break
                        }
                    }
                    i += 1
                    if bookName != "" {
                        break
                    }
                }
            }
        
            let dirContents = try? fileManager.contentsOfDirectory(atPath: fullDirectory + bookName)
            if dirContents != nil {
                
                var chapterMatchString = ""
                if appDelegate.whatToShare == .Chapter {
                    chapterMatchString = "S" + String(format: "%03d", appDelegate.chapter)
                }
                
                for file in dirContents!{
                    
                    if file.contains(".m4a") {
                        if appDelegate.whatToShare != .Chapter ||
                            (appDelegate.whatToShare == .Chapter && file.contains(chapterMatchString)) {
                            let path = "\(fullDirectory + bookName)/\(file)"
                            let audioData = NSURL(fileURLWithPath: path)
                            audioArray.append(audioData)
                        }
                    }
                }
                
                
            }else{
                print("Could not find directory")
                return false
            }
        }
        
        if audioArray.count > 0 {
            //set up file name and call mergeAudioFiles
            var fileName = "C_\(appDelegate.userName.replacingOccurrences(of: " ", with: ""))_"
            if appDelegate.whatToShare == .Book {
                fileName += "\(appDelegate.bookString).m4a"
            }else if appDelegate.whatToShare == .SubBook {
                fileName += "\(appDelegate.subBookString).m4a"
            }else if appDelegate.whatToShare == .Chapter {
                let chapterSring = String(format: "%03d", appDelegate.chapter)
                fileName += "\(appDelegate.subBookString)\(chapterSring).m4a"
            }
            fileName = fileName.replacingOccurrences(of: " ", with: "")
            mergeAudioFiles(audioFileUrls: audioArray as NSArray, fileName: fileName)
        }else{
            print("Could not find any files to share")
            return false
        }
        
        return true
    }
    
    public func popupMessage(view: ViewController, title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
