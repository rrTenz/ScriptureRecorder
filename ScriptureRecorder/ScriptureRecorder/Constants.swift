//
//  Constants.swift
//  ScriptureRecorder
//
//  Created by Ryan Tensmeyer on 5/25/17.
//  Copyright © 2017 rrTenz Games. All rights reserved.
//

import Foundation

struct Const {
    
    //Book enums
    enum Book: Int{
        case BOM = 0
        case PGP = 1
        case DC = 2
        case OT = 3
        case NT = 4
    }
    
    //What to Share enums
    enum WhatToShare: Int{
        case Book = 0
        case SubBook = 1
        case Chapter = 2
        case Verse = 3
    }
    
    static let BOOKMARK_COUNT = 6
    
    //Books
    static let BOM = "Book of Mormon"
    static let PGP = "Pearl of Great Price"
    static let DC = "Doctrine & Covenants"
    static let OT = "Old Testament"
    static let NT = "New Testament"
    static let BOOK_LIST: [String] = [BOM, PGP, DC, OT, NT]
    
    //Sub Books - Book of Mormon
    static let BOM_INTRO = "Introduction and Witnesses"
    static let BOM_1NE = "1 Nephi"
    static let BOM_2NE = "2 Nephi"
    static let BOM_JAC = "Jacob"
    static let BOM_ENO = "Enos"
    static let BOM_JAR = "Jarom"
    static let BOM_OMN = "Omni"
    static let BOM_WofM = "Words of Mormon"
    static let BOM_MSH = "Mosiah"
    static let BOM_ALM = "Alma"
    static let BOM_HEL = "Helaman"
    static let BOM_3NE = "3 Nephi"
    static let BOM_4NE = "4 Nephi"
    static let BOM_MOR = "Mormon"
    static let BOM_ETH = "Ether"
    static let BOM_MNI = "Moroni"
    static let BOM_TESTIMONY = "Book of Mormon Testimony"
    static let BOM_LIST: [String] = [BOM_INTRO, BOM_1NE, BOM_2NE, BOM_JAC, BOM_ENO, BOM_JAR, BOM_OMN, BOM_WofM, BOM_MSH, BOM_ALM , BOM_HEL, BOM_3NE, BOM_4NE, BOM_MOR, BOM_ETH, BOM_MNI, BOM_TESTIMONY]
    
    
    static let URL_LDS_SCRIPTURES = "https://www.lds.org/scriptures/"
    static let URL_LDS_TESTIMONY = "https://www.lds.org/topics/testimony"
    
    //Sub Book URLs - Book of Mormon
    static let URL_BOM = "bofm/"
    static let URL_BOM_TITLE_PAGE = "title-page"
    static let URL_BOM_TITLE = "bofm-title"
    static let URL_BOM_INTRO = "introduction"
    static let URL_BOM_3_WITNESSES = "three"
    static let URL_BOM_8_WITNESSES = "eight"
    static let URL_BOM_JS_TESTIMONY = "js"
    static let URL_BOM_EXPLANATION = "explanation"
    static let URL_BOM_1NE = "1-ne/"
    static let URL_BOM_2NE = "2-ne/"
    static let URL_BOM_JAC = "jacob/"
    static let URL_BOM_ENO = "enos/"
    static let URL_BOM_JAR = "jarom/"
    static let URL_BOM_OMN = "omni/"
    static let URL_BOM_WofM = "w-of-m/"
    static let URL_BOM_MSH = "mosiah/"
    static let URL_BOM_ALM = "alma/"
    static let URL_BOM_HEL = "hel/"
    static let URL_BOM_3NE = "3-ne/"
    static let URL_BOM_4NE = "4-ne/"
    static let URL_BOM_MOR = "morm/"
    static let URL_BOM_ETH = "ether/"
    static let URL_BOM_MNI = "moro/"
    static let URL_BOM_LIST: [String] = [URL_BOM_INTRO, URL_BOM_1NE, URL_BOM_2NE, URL_BOM_JAC, URL_BOM_ENO, URL_BOM_JAR, URL_BOM_OMN, URL_BOM_WofM, URL_BOM_MSH, URL_BOM_ALM , URL_BOM_HEL, URL_BOM_3NE, URL_BOM_4NE, URL_BOM_MOR, URL_BOM_ETH, URL_BOM_MNI]
    
    //TODO add more books
    
    //Sub Books - Pearl of Great Price
    static let PGP_TITLE = "Title Page"
    static let PGP_INTRO = "Introduction"
    static let PGP_MOSES = "Moses"
    static let PGP_ABRAHAM = "Abraham"
    static let PGP_JS_MATT = "Joseph Smith-Matthew"
    static let PGP_JS_HIST = "Joseph Smith-History"
    static let PGP_AofF = "Articles of Faith"
    static let PGP_TESTIMONY = "Pearl of Great Price Testimony"
    static let PGP_LIST: [String] = [PGP_TITLE, PGP_INTRO, PGP_MOSES, PGP_ABRAHAM, PGP_JS_MATT, PGP_JS_HIST, PGP_AofF, PGP_TESTIMONY]
    
    //Sub Book URLs - Pearl of Great Price
    static let URL_PGP = "pgp/"
    static let URL_PGP_TITLE = "title-page.html"
    static let URL_PGP_INTRO = "introduction"
    static let URL_PGP_MOSES = "moses/"
    static let URL_PGP_ABRAHAM = "abr/"
    static let URL_PGP_JS_MATT = "js-m/"
    static let URL_PGP_JS_HIST = "js-h/"
    static let URL_PGP_AofF = "a-of-f/"
    static let URL_PGP_LIST: [String] = [URL_PGP_TITLE, URL_PGP_INTRO, URL_PGP_MOSES, URL_PGP_ABRAHAM, URL_PGP_JS_MATT, URL_PGP_JS_HIST, URL_PGP_AofF]
    
    //Sub Books - Doctrine & Covenants
    static let DC_TITLE = "Title Page"
    static let DC_INTRO = "Introduction"
    static let DC_SECTIONS = "Sections"
    static let DC_DECLARATION_1 = "Official Declaration 1"
    static let DC_DECLARATION_2 = "Official Declaration 2"
    static let DC_TESTIMONY = "Doctrine and Covenants Testimony"
    static let DC_LIST: [String] = [DC_TITLE, DC_INTRO, DC_SECTIONS, DC_DECLARATION_1, DC_DECLARATION_2, DC_TESTIMONY]
    
    //Sub Books URLs - Doctrine & Covenants
    static let URL_DC = "dc-testament/"
    static let URL_DC_TITLE = "title-page.html"
    static let URL_DC_INTRO = "introduction.html"
    static let URL_DC_SECTIONS = "dc/"
    static let URL_DC_OFFICIAL_DECLARATIONS = "od/"
    static let URL_DC_LIST: [String] = [URL_DC_TITLE, URL_DC_INTRO, URL_DC_SECTIONS, URL_DC_OFFICIAL_DECLARATIONS, URL_DC_OFFICIAL_DECLARATIONS]
    
    //Sub Books - Old Testament
    static let OT_TITLE = "Title Page"
    static let OT_EPISTLE = "Epistle Dedicatory"
    static let OT_GENESIS = "Genesis"
    static let OT_EXODUS = "Exodus"
    static let OT_LEVITICUS = "Leviticus"
    static let OT_NUMBERS = "Numbers"
    static let OT_DEUTERONOMY = "Deuteronomy"
    static let OT_JOSHUA = "Joshua"
    static let OT_JUDGES = "Judges"
    static let OT_RUTH = "Ruth"
    static let OT_1SAM = "1 Samuel"
    static let OT_2SAM = "2 Samuel"
    static let OT_1KINGS = "1 Kings"
    static let OT_2KINGS = "2 Kings"
    static let OT_1CHRON = "1 Chronicles"
    static let OT_2CHRON = "2 Chronicles"
    static let OT_EZRA = "Ezra"
    static let OT_NEHEMIAH = "Nehemiah"
    static let OT_ESTHER = "Esther"
    static let OT_JOB = "Job"
    static let OT_PSALMS = "Psalms"
    static let OT_PROVERBS = "Proverbs"
    static let OT_ECCLESIASTES = "Ecclesiastes"
    static let OT_SONGofSOLOMON = "Song of Solomon"
    static let OT_ISAIAH = "Isaiah"
    static let OT_JEREMIAH = "Jeremiah"
    static let OT_LAMENTATIONS = "Lamentations"
    static let OT_EZEKIEL = "Ezekiel"
    static let OT_DANIEL = "Daniel"
    static let OT_HOSEA = "Hosea"
    static let OT_JOEL = "Joel"
    static let OT_AMOS = "Amos"
    static let OT_OBADIAH = "Obadiah"
    static let OT_JONAH = "Jonah"
    static let OT_MICAH = "Micah"
    static let OT_NAHUM = "Nahum"
    static let OT_HABAKKUK = "Habakkuk"
    static let OT_ZEPHANIAH = "Zephaniah"
    static let OT_HAGGAI = "Haggai"
    static let OT_ZECHARIAH = "Zechariah"
    static let OT_MALACHI = "Malachi"
    static let OT_TESTIMONY = "Old Testament Testimony"
    static let OT_LIST: [String] = [OT_TITLE, OT_EPISTLE, OT_GENESIS, OT_EXODUS, OT_LEVITICUS, OT_NUMBERS, OT_DEUTERONOMY, OT_JOSHUA, OT_JUDGES, OT_RUTH, OT_1SAM, OT_2SAM, OT_1KINGS, OT_2KINGS, OT_1CHRON, OT_2CHRON, OT_EZRA, OT_NEHEMIAH, OT_ESTHER, OT_JOB, OT_PSALMS, OT_PROVERBS, OT_ECCLESIASTES, OT_SONGofSOLOMON, OT_ISAIAH, OT_JEREMIAH, OT_LAMENTATIONS, OT_EZEKIEL, OT_DANIEL, OT_HOSEA, OT_JOEL, OT_AMOS, OT_OBADIAH, OT_JONAH, OT_MICAH, OT_NAHUM, OT_HABAKKUK, OT_ZEPHANIAH, OT_HAGGAI, OT_ZECHARIAH, OT_MALACHI, OT_TESTIMONY]
    
    //Sub Books URLs - Old Testament
    static let URL_OT = "ot/"
    static let URL_OT_TITLE = "title-page.html"
    static let URL_OT_EPISTLE = "dedication"
    static let URL_OT_GENESIS = "gen/"
    static let URL_OT_EXODUS = "ex/"
    static let URL_OT_LEVITICUS = "lev/"
    static let URL_OT_NUMBERS = "num/"
    static let URL_OT_DEUTERONOMY = "deut/"
    static let URL_OT_JOSHUA = "josh/"
    static let URL_OT_JUDGES = "judg/"
    static let URL_OT_RUTH = "ruth/"
    static let URL_OT_1SAM = "1-sam/"
    static let URL_OT_2SAM = "2-sam/"
    static let URL_OT_1KINGS = "1-kgs/"
    static let URL_OT_2KINGS = "2-kgs/"
    static let URL_OT_1CHRON = "1-chr/"
    static let URL_OT_2CHRON = "2-chr/"
    static let URL_OT_EZRA = "ezra/"
    static let URL_OT_NEHEMIAH = "neh/"
    static let URL_OT_ESTHER = "esth/"
    static let URL_OT_JOB = "job/"
    static let URL_OT_PSALMS = "ps/"
    static let URL_OT_PROVERBS = "prov/"
    static let URL_OT_ECCLESIASTES = "eccl/"
    static let URL_OT_SONGofSOLOMON = "song/"
    static let URL_OT_ISAIAH = "isa/"
    static let URL_OT_JEREMIAH = "jer/"
    static let URL_OT_LAMENTATIONS = "lam/"
    static let URL_OT_EZEKIEL = "ezek/"
    static let URL_OT_DANIEL = "dan/"
    static let URL_OT_HOSEA = "hosea/"
    static let URL_OT_JOEL = "joel/"
    static let URL_OT_AMOS = "amos/"
    static let URL_OT_OBADIAH = "obad/"
    static let URL_OT_JONAH = "jonah/"
    static let URL_OT_MICAH = "micah/"
    static let URL_OT_NAHUM = "nahum/"
    static let URL_OT_HABAKKUK = "hab/"
    static let URL_OT_ZEPHANIAH = "zeph/"
    static let URL_OT_HAGGAI = "hag/"
    static let URL_OT_ZECHARIAH = "zech/"
    static let URL_OT_MALACHI = "mal/"
    static let URL_OT_LIST: [String] = [URL_OT_TITLE, URL_OT_EPISTLE, URL_OT_GENESIS, URL_OT_EXODUS, URL_OT_LEVITICUS, URL_OT_NUMBERS, URL_OT_DEUTERONOMY, URL_OT_JOSHUA, URL_OT_JUDGES, URL_OT_RUTH, URL_OT_1SAM, URL_OT_2SAM, URL_OT_1KINGS, URL_OT_2KINGS, URL_OT_1CHRON, URL_OT_2CHRON, URL_OT_EZRA, URL_OT_NEHEMIAH, URL_OT_ESTHER, URL_OT_JOB, URL_OT_PSALMS, URL_OT_PROVERBS, URL_OT_ECCLESIASTES, URL_OT_SONGofSOLOMON, URL_OT_ISAIAH, URL_OT_JEREMIAH, URL_OT_LAMENTATIONS, URL_OT_EZEKIEL, URL_OT_DANIEL, URL_OT_HOSEA, URL_OT_JOEL, URL_OT_AMOS, URL_OT_OBADIAH, URL_OT_JONAH, URL_OT_MICAH, URL_OT_NAHUM, URL_OT_HABAKKUK, URL_OT_ZEPHANIAH, URL_OT_HAGGAI, URL_OT_ZECHARIAH, URL_OT_MALACHI]
    
    //Sub Books - New Testament
    static let NT_TITLE = "Title Page"
    static let NT_MATTHEW = "Matthew"
    static let NT_MARK = "Mark"
    static let NT_LUKE = "Luke"
    static let NT_JOHN = "John"
    static let NT_ACTS = "Acts"
    static let NT_ROMANS = "Romans"
    static let NT_1COR = "1 Corinthians"
    static let NT_2COR = "2 Corinthians"
    static let NT_GALATIANS = "Galatians"
    static let NT_EPHESIANS = "Ephesians"
    static let NT_PHILIPPIANS = "Philippians"
    static let NT_COLOSSIANS = "Colossians"
    static let NT_1THES = "1 Thessalonians"
    static let NT_2THES = "2 Thessalonians"
    static let NT_1TIM = "1 Timothy"
    static let NT_2TIM = "2 Timothy"
    static let NT_TITUS = "Titus"
    static let NT_PHILEMON = "Philemon"
    static let NT_HEBREWS = "Hebrews"
    static let NT_JAMES = "James"
    static let NT_1PETER = "1 Peter"
    static let NT_2PETER = "2 Peter"
    static let NT_1JOHN = "1 John"
    static let NT_2JOHN = "2 John"
    static let NT_3JOHN = "3 John"
    static let NT_JUDE = "Jude"
    static let NT_REVELATION = "Revelation"
    static let NT_TESTIMONY = "Book of Mormon Testimony"
    static let NT_LIST: [String] = [NT_TITLE, NT_MATTHEW, NT_MARK, NT_LUKE, NT_JOHN, NT_ACTS, NT_ROMANS, NT_1COR, NT_2COR, NT_GALATIANS, NT_EPHESIANS, NT_PHILIPPIANS, NT_COLOSSIANS, NT_1THES, NT_2THES, NT_1TIM, NT_2TIM, NT_TITUS, NT_PHILEMON, NT_HEBREWS, NT_JAMES, NT_1PETER, NT_2PETER, NT_1JOHN, NT_2JOHN, NT_3JOHN, NT_JUDE, NT_REVELATION, NT_TESTIMONY]
    
    //Sub Books URLs - New Testament
    static let URL_NT = "nt/"
    static let URL_NT_TITLE = "title-page.html"
    static let URL_NT_MATTHEW = "matt/"
    static let URL_NT_MARK = "mark/"
    static let URL_NT_LUKE = "luke/"
    static let URL_NT_JOHN = "john/"
    static let URL_NT_ACTS = "acts/"
    static let URL_NT_ROMANS = "rom/"
    static let URL_NT_1COR = "1-cor/"
    static let URL_NT_2COR = "2-cor/"
    static let URL_NT_GALATIANS = "gal/"
    static let URL_NT_EPHESIANS = "eph/"
    static let URL_NT_PHILIPPIANS = "philip/"
    static let URL_NT_COLOSSIANS = "col/"
    static let URL_NT_1THES = "1-thes/"
    static let URL_NT_2THES = "2-thes/"
    static let URL_NT_1TIM = "1-tim/"
    static let URL_NT_2TIM = "2-tim/"
    static let URL_NT_TITUS = "titus/"
    static let URL_NT_PHILEMON = "philem/"
    static let URL_NT_HEBREWS = "heb/"
    static let URL_NT_JAMES = "james/"
    static let URL_NT_1PETER = "1-pet/"
    static let URL_NT_2PETER = "2-pet/"
    static let URL_NT_1JOHN = "1-jn/"
    static let URL_NT_2JOHN = "2-jn/"
    static let URL_NT_3JOHN = "3-jn/"
    static let URL_NT_JUDE = "jude/"
    static let URL_NT_REVELATION = "rev/"
    static let URL_NT_LIST: [String] = [URL_NT_TITLE, URL_NT_MATTHEW, URL_NT_MARK, URL_NT_LUKE, URL_NT_JOHN, URL_NT_ACTS, URL_NT_ROMANS, URL_NT_1COR, URL_NT_2COR, URL_NT_GALATIANS, URL_NT_EPHESIANS, URL_NT_PHILIPPIANS, URL_NT_COLOSSIANS, URL_NT_1THES, URL_NT_2THES, URL_NT_1TIM, URL_NT_2TIM, URL_NT_TITUS, URL_NT_PHILEMON, URL_NT_HEBREWS, URL_NT_JAMES, URL_NT_1PETER, URL_NT_2PETER, URL_NT_1JOHN, URL_NT_2JOHN, URL_NT_3JOHN, URL_NT_JUDE, URL_NT_REVELATION]
    
    static let SUB_BOOK_LIST = [BOM_LIST, PGP_LIST, DC_LIST, OT_LIST, NT_LIST]
    
    //https://www.lds.org/general-conference/2011/10/the-power-of-scripture?lang=eng
    //http://storiesforseminary.wikispaces.com/Richard+G.+Scott+makes+audio+recording+of+the+Book+of+Mormon+for+his+family
    static let SCOTT_QUOTE = "My precious wife, Jeanene, loved the Book of Mormon. In her youth, as a teenager, it became the foundation of her life. It was a source of testimony and teaching during her full-time missionary service in the northwest United States. When we served in the mission field in Córdoba, Argentina, she strongly encouraged the use of the Book of Mormon in our proselytizing efforts. Jeanene confirmed early in her life that those who consistently read the Book of Mormon are blessed with an added measure of the Spirit of the Lord, a greater resolve to obey His commandments, and a stronger testimony of the divinity of the Son of God. 1 For I don’t know how many years, as the end of the year approached, I would see her sitting quietly, carefully finishing the entire Book of Mormon yet another time before year’s end./n/nIn 1991 I wanted to give a special Christmas gift to my family. In recording the fulfillment of that desire, my personal journal states: “It is 12:38 p.m., Wednesday, December 18, 1991. I’ve just concluded an audio recording of the Book of Mormon for my family. This has been an experience that has increased my testimony of this divine work and strengthened in me a desire to be more familiar with its pages to distill from these scriptures truths to be used in my service to the Lord. I love this book. I testify with my soul that it is true, that it was prepared for the blessing of the House of Israel, and all of its component parts spread throughout the world. All who will study its message in humility, in faith believing in Jesus Christ, will know of its truthfulness and will find a treasure to lead them to greater happiness, peace, and attainment in this life. I testify by all that is sacred, this book is true./n/nThe Power of Scripture/n/nRichard G. Scott, October 2011 General Conference"
    
}
