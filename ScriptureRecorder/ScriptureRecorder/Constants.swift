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
    
    static let LANGUAGE = ["English", "Español"]
    
    static let BOOKMARK_COUNT = 6
    
    //Books
    static let BOM = "Book of Mormon"
    static let PGP = "Pearl of Great Price"
    static let DC = "Doctrine & Covenants"
    static let OT = "Old Testament"
    static let NT = "New Testament"
    
    static let BOM_SPA = "Libro de Mormón"
    static let PGP_SPA = "Perla de Gran Precio"
    static let DC_SPA = "Doctrina y Convenios"
    static let OT_SPA = "Antiguo Testamento"
    static let NT_SPA = "Nuevo Testamento"
    static let BOOK_LIST: [[String]] = [[BOM, PGP, DC, OT, NT],
                                        [BOM_SPA, PGP_SPA, DC_SPA, OT_SPA, NT_SPA]]
    
    static let BOM_ARRAY = [BOM, BOM_SPA]
    static let PGP_ARRAY = [PGP, PGP_SPA]
    static let DC_ARRAY = [DC, DC_SPA]
    static let OT_ARRAY = [OT, OT_SPA]
    static let NT_ARRAY = [NT, NT_SPA]
    
    
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
    static let BOM_LIST_ENG: [String] = [BOM_INTRO, BOM_1NE, BOM_2NE, BOM_JAC, BOM_ENO, BOM_JAR, BOM_OMN, BOM_WofM, BOM_MSH, BOM_ALM, BOM_HEL, BOM_3NE, BOM_4NE, BOM_MOR, BOM_ETH, BOM_MNI, BOM_TESTIMONY]
    
    static let BOM_INTRO_SPA = "Introducción y testigos"
    static let BOM_1NE_SPA = "1 Nefi"
    static let BOM_2NE_SPA = "2 Nefi"
    static let BOM_JAC_SPA = "Jacob"
    static let BOM_ENO_SPA = "Enós"
    static let BOM_JAR_SPA = "Jarom"
    static let BOM_OMN_SPA = "Omni"
    static let BOM_WofM_SPA = "Palabras de Mormón"
    static let BOM_MSH_SPA = "Mosíah"
    static let BOM_ALM_SPA = "Alma"
    static let BOM_HEL_SPA = "Helamán"
    static let BOM_3NE_SPA = "3 Nefi"
    static let BOM_4NE_SPA = "4 Nefi"
    static let BOM_MOR_SPA = "Mormón"
    static let BOM_ETH_SPA = "Éter"
    static let BOM_MNI_SPA = "Moroni"
    static let BOM_TESTIMONY_SPA = "Testimonio del Libro de Mormón"
    static let BOM_LIST_SPA: [String] = [BOM_INTRO_SPA, BOM_1NE_SPA, BOM_2NE_SPA, BOM_JAC_SPA, BOM_ENO_SPA, BOM_JAR_SPA, BOM_OMN_SPA, BOM_WofM_SPA, BOM_MSH_SPA, BOM_ALM_SPA, BOM_HEL_SPA, BOM_3NE_SPA, BOM_4NE_SPA, BOM_MOR_SPA, BOM_ETH_SPA, BOM_MNI_SPA, BOM_TESTIMONY_SPA]
    
    static let BOM_LIST = [BOM_LIST_ENG, BOM_LIST_SPA]
    static let BOM_INTRO_ARRAY = [BOM_LIST[0][0], BOM_LIST[1][0]]
    static let BOM_1NE_ARRAY = [BOM_LIST[0][1], BOM_LIST[1][1]]
    static let BOM_2NE_ARRAY = [BOM_LIST[0][2], BOM_LIST[1][2]]
    static let BOM_JAC_ARRAY = [BOM_LIST[0][3], BOM_LIST[1][3]]
    static let BOM_ENO_ARRAY = [BOM_LIST[0][4], BOM_LIST[1][4]]
    static let BOM_JAR_ARRAY = [BOM_LIST[0][5], BOM_LIST[1][5]]
    static let BOM_OMN_ARRAY = [BOM_LIST[0][6], BOM_LIST[1][6]]
    static let BOM_WofM_ARRAY = [BOM_LIST[0][7], BOM_LIST[1][7]]
    static let BOM_MSH_ARRAY = [BOM_LIST[0][8], BOM_LIST[1][8]]
    static let BOM_ALM_ARRAY = [BOM_LIST[0][8], BOM_LIST[1][9]]
    static let BOM_HEL_ARRAY = [BOM_LIST[0][10], BOM_LIST[1][10]]
    static let BOM_3NE_ARRAY = [BOM_LIST[0][11], BOM_LIST[1][11]]
    static let BOM_4NE_ARRAY = [BOM_LIST[0][12], BOM_LIST[1][12]]
    static let BOM_MOR_ARRAY = [BOM_LIST[0][13], BOM_LIST[1][13]]
    static let BOM_ETH_ARRAY = [BOM_LIST[0][14], BOM_LIST[1][14]]
    static let BOM_MNI_ARRAY = [BOM_LIST[0][15], BOM_LIST[1][15]]
    static let BOM_TESTIMONY_ARRAY = [BOM_LIST[0][16], BOM_LIST[1][16]]
    
    
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
    static let PGP_LIST_ENG: [String] = [PGP_TITLE, PGP_INTRO, PGP_MOSES, PGP_ABRAHAM, PGP_JS_MATT, PGP_JS_HIST, PGP_AofF, PGP_TESTIMONY]
    
    static let PGP_TITLE_SPA = "Portada"
    static let PGP_INTRO_SPA = "Introducción"
    static let PGP_MOSES_SPA = "Moisés"
    static let PGP_ABRAHAM_SPA = "Abraham"
    static let PGP_JS_MATT_SPA = "José Smith—Mateo"
    static let PGP_JS_HIST_SPA = "José Smith—Historia"
    static let PGP_AofF_SPA = "Artículos de Fe"
    static let PGP_TESTIMONY_SPA = "Testimonio de La Perla de Gran Precio"
    static let PGP_LIST_SPA: [String] = [PGP_TITLE_SPA, PGP_INTRO_SPA, PGP_MOSES_SPA, PGP_ABRAHAM_SPA, PGP_JS_MATT_SPA, PGP_JS_HIST_SPA, PGP_AofF_SPA, PGP_TESTIMONY_SPA]
    
    static let PGP_LIST = [PGP_LIST_ENG, PGP_LIST_SPA]
    static let PGP_TITLE_ARRAY = [PGP_LIST[0][0], PGP_LIST[1][0]]
    static let PGP_INTRO_ARRAY = [PGP_LIST[0][1], PGP_LIST[1][1]]
    static let PGP_MOSES_ARRAY = [PGP_LIST[0][2], PGP_LIST[1][2]]
    static let PGP_ABRAHAM_ARRAY = [PGP_LIST[0][3], PGP_LIST[1][3]]
    static let PGP_JS_MATT_ARRAY = [PGP_LIST[0][4], PGP_LIST[1][4]]
    static let PGP_JS_HIST_ARRAY = [PGP_LIST[0][5], PGP_LIST[1][5]]
    static let PGP_AofF_ARRAY = [PGP_LIST[0][6], PGP_LIST[1][6]]
    static let PGP_TESTIMONY_ARRAY = [PGP_LIST[0][7], PGP_LIST[1][7]]
    
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
    static let DC_SECTIONS = "Section"
    static let DC_DECLARATION_1 = "Official Declaration 1"
    static let DC_DECLARATION_2 = "Official Declaration 2"
    static let DC_TESTIMONY = "Doctrine and Covenants Testimony"
    static let DC_LIST_ENG: [String] = [DC_TITLE, DC_INTRO, DC_SECTIONS, DC_DECLARATION_1, DC_DECLARATION_2, DC_TESTIMONY]
    
    static let DC_TITLE_SPA = "Portada"
    static let DC_INTRO_SPA = "Introducción"
    static let DC_SECTIONS_SPA = "Sección"
    static let DC_DECLARATION_1_SPA = "Declaración Oficial 1"
    static let DC_DECLARATION_2_SPA = "Declaración Oficial 2"
    static let DC_TESTIMONY_SPA = "Testimonio de Doctrina y Convenios"
    static let DC_LIST_SPA: [String] = [DC_TITLE_SPA, DC_INTRO_SPA, DC_SECTIONS_SPA, DC_DECLARATION_1_SPA, DC_DECLARATION_2_SPA, DC_TESTIMONY_SPA]
    
    static let DC_LIST = [DC_LIST_ENG, DC_LIST_SPA]
    static let DC_TITLE_ARRAY = [DC_LIST[0][0], DC_LIST[1][0]]
    static let DC_INTRO_ARRAY = [DC_LIST[0][1], DC_LIST[1][1]]
    static let DC_SECTIONS_ARRAY = [DC_LIST[0][2], DC_LIST[1][2]]
    static let DC_DECLARATION_1_ARRAY = [DC_LIST[0][3], DC_LIST[1][3]]
    static let DC_DECLARATION_2_ARRAY = [DC_LIST[0][4], DC_LIST[1][4]]
    static let DC_TESTIMONY_ARRAY = [DC_LIST[0][5], DC_LIST[1][5]]
    
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
    static let OT_LIST_ENG: [String] = [OT_TITLE, OT_EPISTLE, OT_GENESIS, OT_EXODUS, OT_LEVITICUS, OT_NUMBERS, OT_DEUTERONOMY, OT_JOSHUA, OT_JUDGES, OT_RUTH, OT_1SAM, OT_2SAM, OT_1KINGS, OT_2KINGS, OT_1CHRON, OT_2CHRON, OT_EZRA, OT_NEHEMIAH, OT_ESTHER, OT_JOB, OT_PSALMS, OT_PROVERBS, OT_ECCLESIASTES, OT_SONGofSOLOMON, OT_ISAIAH, OT_JEREMIAH, OT_LAMENTATIONS, OT_EZEKIEL, OT_DANIEL, OT_HOSEA, OT_JOEL, OT_AMOS, OT_OBADIAH, OT_JONAH, OT_MICAH, OT_NAHUM, OT_HABAKKUK, OT_ZEPHANIAH, OT_HAGGAI, OT_ZECHARIAH, OT_MALACHI, OT_TESTIMONY]
    
    static let OT_TITLE_SPA = "Portada"
    static let OT_EPISTLE_SPA = "Introducción"
    static let OT_GENESIS_SPA = "Génesis"
    static let OT_EXODUS_SPA = "Éxodo"
    static let OT_LEVITICUS_SPA = "Levítico"
    static let OT_NUMBERS_SPA = "Números"
    static let OT_DEUTERONOMY_SPA = "Deuteronomio"
    static let OT_JOSHUA_SPA = "Josué"
    static let OT_JUDGES_SPA = "Jueces"
    static let OT_RUTH_SPA = "Rut"
    static let OT_1SAM_SPA = "1 Samuel"
    static let OT_2SAM_SPA = "2 Samuel"
    static let OT_1KINGS_SPA = "1 Reyes"
    static let OT_2KINGS_SPA = "2 Reyes"
    static let OT_1CHRON_SPA = "1 Crónicas"
    static let OT_2CHRON_SPA = "2 Crónicas"
    static let OT_EZRA_SPA = "Esdras"
    static let OT_NEHEMIAH_SPA = "Nehemías"
    static let OT_ESTHER_SPA = "Ester"
    static let OT_JOB_SPA = "Job"
    static let OT_PSALMS_SPA = "Salmos"
    static let OT_PROVERBS_SPA = "Proverbios"
    static let OT_ECCLESIASTES_SPA = "Eclesiastés"
    static let OT_SONGofSOLOMON_SPA = "Cantares"
    static let OT_ISAIAH_SPA = "Isaías"
    static let OT_JEREMIAH_SPA = "Jeremías"
    static let OT_LAMENTATIONS_SPA = "Lamentaciones"
    static let OT_EZEKIEL_SPA = "Ezequiel"
    static let OT_DANIEL_SPA = "Daniel"
    static let OT_HOSEA_SPA = "Oseas"
    static let OT_JOEL_SPA = "Joel"
    static let OT_AMOS_SPA = "Amós"
    static let OT_OBADIAH_SPA = "Abdías"
    static let OT_JONAH_SPA = "Jonás"
    static let OT_MICAH_SPA = "Miqueas"
    static let OT_NAHUM_SPA = "Nahúm"
    static let OT_HABAKKUK_SPA = "Habacuc"
    static let OT_ZEPHANIAH_SPA = "Sofonías"
    static let OT_HAGGAI_SPA = "Hageo"
    static let OT_ZECHARIAH_SPA = "Zacarías"
    static let OT_MALACHI_SPA = "Malaquías"
    static let OT_TESTIMONY_SPA = "Testimonio del Antiguo Testamento"
    static let OT_LIST_SPA: [String] = [OT_TITLE_SPA, OT_EPISTLE_SPA, OT_GENESIS_SPA, OT_EXODUS_SPA, OT_LEVITICUS_SPA, OT_NUMBERS_SPA, OT_DEUTERONOMY_SPA, OT_JOSHUA_SPA, OT_JUDGES_SPA, OT_RUTH_SPA, OT_1SAM_SPA, OT_2SAM_SPA, OT_1KINGS_SPA, OT_2KINGS_SPA, OT_1CHRON_SPA, OT_2CHRON_SPA, OT_EZRA_SPA, OT_NEHEMIAH_SPA, OT_ESTHER_SPA, OT_JOB_SPA, OT_PSALMS_SPA, OT_PROVERBS_SPA, OT_ECCLESIASTES_SPA, OT_SONGofSOLOMON_SPA, OT_ISAIAH_SPA, OT_JEREMIAH_SPA, OT_LAMENTATIONS_SPA, OT_EZEKIEL_SPA, OT_DANIEL_SPA, OT_HOSEA_SPA, OT_JOEL_SPA, OT_AMOS_SPA, OT_OBADIAH_SPA, OT_JONAH_SPA, OT_MICAH_SPA, OT_NAHUM_SPA, OT_HABAKKUK_SPA, OT_ZEPHANIAH_SPA, OT_HAGGAI_SPA, OT_ZECHARIAH_SPA, OT_MALACHI_SPA, OT_TESTIMONY_SPA]
    
    static let OT_LIST = [OT_LIST_ENG, OT_LIST_SPA]
    static let OT_TITLE_ARRAY = [OT_LIST[0][0], OT_LIST[1][0]]
    static let OT_EPISTLE_ARRAY = [OT_LIST[0][1], OT_LIST[1][1]]
    static let OT_GENESIS_ARRAY = [OT_LIST[0][2], OT_LIST[1][2]]
    static let OT_EXODUS_ARRAY = [OT_LIST[0][3], OT_LIST[1][3]]
    static let OT_LEVITICUS_ARRAY = [OT_LIST[0][4], OT_LIST[1][4]]
    static let OT_NUMBERS_ARRAY = [OT_LIST[0][5], OT_LIST[1][5]]
    static let OT_DEUTERONOMY_ARRAY = [OT_LIST[0][6], OT_LIST[1][6]]
    static let OT_JOSHUA_ARRAY = [OT_LIST[0][7], OT_LIST[1][7]]
    static let OT_JUDGES_ARRAY = [OT_LIST[0][8], OT_LIST[1][8]]
    static let OT_RUTH_ARRAY = [OT_LIST[0][9], OT_LIST[1][9]]
    static let OT_1SAM_ARRAY = [OT_LIST[0][10], OT_LIST[1][10]]
    static let OT_2SAM_ARRAY = [OT_LIST[0][11], OT_LIST[1][11]]
    static let OT_1KINGS_ARRAY = [OT_LIST[0][12], OT_LIST[1][12]]
    static let OT_2KINGS_ARRAY = [OT_LIST[0][13], OT_LIST[1][13]]
    static let OT_1CHRON_ARRAY = [OT_LIST[0][14], OT_LIST[1][14]]
    static let OT_2CHRON_ARRAY = [OT_LIST[0][15], OT_LIST[1][15]]
    static let OT_EZRA_ARRAY = [OT_LIST[0][16], OT_LIST[1][16]]
    static let OT_NEHEMIAH_ARRAY = [OT_LIST[0][17], OT_LIST[1][17]]
    static let OT_ESTHER_ARRAY = [OT_LIST[0][18], OT_LIST[1][18]]
    static let OT_JOB_ARRAY = [OT_LIST[0][19], OT_LIST[1][19]]
    static let OT_PSALMS_ARRAY = [OT_LIST[0][20], OT_LIST[1][20]]
    static let OT_PROVERBS_ARRAY = [OT_LIST[0][21], OT_LIST[1][21]]
    static let OT_ECCLESIASTES_ARRAY = [OT_LIST[0][22], OT_LIST[1][22]]
    static let OT_SONGofSOLOMON_ARRAY = [OT_LIST[0][23], OT_LIST[1][23]]
    static let OT_ISAIAH_ARRAY = [OT_LIST[0][24], OT_LIST[1][24]]
    static let OT_JEREMIAH_ARRAY = [OT_LIST[0][25], OT_LIST[1][25]]
    static let OT_LAMENTATIONS_ARRAY = [OT_LIST[0][26], OT_LIST[1][26]]
    static let OT_EZEKIEL_ARRAY = [OT_LIST[0][27], OT_LIST[1][27]]
    static let OT_DANIEL_ARRAY = [OT_LIST[0][28], OT_LIST[1][28]]
    static let OT_HOSEA_ARRAY = [OT_LIST[0][29], OT_LIST[1][29]]
    static let OT_JOEL_ARRAY = [OT_LIST[0][30], OT_LIST[1][30]]
    static let OT_AMOS_ARRAY = [OT_LIST[0][31], OT_LIST[1][31]]
    static let OT_OBADIAH_ARRAY = [OT_LIST[0][32], OT_LIST[1][32]]
    static let OT_JONAH_ARRAY = [OT_LIST[0][33], OT_LIST[1][33]]
    static let OT_MICAH_ARRAY = [OT_LIST[0][34], OT_LIST[1][34]]
    static let OT_NAHUM_ARRAY = [OT_LIST[0][35], OT_LIST[1][35]]
    static let OT_HABAKKUK_ARRAY = [OT_LIST[0][36], OT_LIST[1][36]]
    static let OT_ZEPHANIAH_ARRAY = [OT_LIST[0][37], OT_LIST[1][37]]
    static let OT_HAGGAI_ARRAY = [OT_LIST[0][38], OT_LIST[1][38]]
    static let OT_ZECHARIAH_ARRAY = [OT_LIST[0][39], OT_LIST[1][39]]
    static let OT_MALACHI_ARRAY = [OT_LIST[0][40], OT_LIST[1][40]]
    static let OT_TESTIMONY_ARRAY = [OT_LIST[0][41], OT_LIST[1][41]]
    
    //Sub Books URLs - Old Testament
    static let URL_OT = "ot/"
    static let URL_OT_TITLE = "title-page.html"
    static let URL_OT_EPISTLE = "dedication"
    static let URL_OT_INTRO = "introduction"
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
    static let NT_TESTIMONY = "New Testament Testimony"
    static let NT_LIST_ENG: [String] = [NT_TITLE, NT_MATTHEW, NT_MARK, NT_LUKE, NT_JOHN, NT_ACTS, NT_ROMANS, NT_1COR, NT_2COR, NT_GALATIANS, NT_EPHESIANS, NT_PHILIPPIANS, NT_COLOSSIANS, NT_1THES, NT_2THES, NT_1TIM, NT_2TIM, NT_TITUS, NT_PHILEMON, NT_HEBREWS, NT_JAMES, NT_1PETER, NT_2PETER, NT_1JOHN, NT_2JOHN, NT_3JOHN, NT_JUDE, NT_REVELATION, NT_TESTIMONY]
    
    static let NT_TITLE_SPA = "Portada"
    static let NT_MATTHEW_SPA = "Mateo"
    static let NT_MARK_SPA = "Marcos"
    static let NT_LUKE_SPA = "Lucas"
    static let NT_JOHN_SPA = "Juan"
    static let NT_ACTS_SPA = "Hechos"
    static let NT_ROMANS_SPA = "Romanos"
    static let NT_1COR_SPA = "1 Corintios"
    static let NT_2COR_SPA = "2 Corintios"
    static let NT_GALATIANS_SPA = "Gálatas"
    static let NT_EPHESIANS_SPA = "Efesios"
    static let NT_PHILIPPIANS_SPA = "Filipenses"
    static let NT_COLOSSIANS_SPA = "Colosenses"
    static let NT_1THES_SPA = "1 Tesalonicenses"
    static let NT_2THES_SPA = "2 Tesalonicenses"
    static let NT_1TIM_SPA = "1 Timoteo"
    static let NT_2TIM_SPA = "2 Timoteo"
    static let NT_TITUS_SPA = "Tito"
    static let NT_PHILEMON_SPA = "Filemón"
    static let NT_HEBREWS_SPA = "Hebreos"
    static let NT_JAMES_SPA = "Santiago"
    static let NT_1PETER_SPA = "1 Pedro"
    static let NT_2PETER_SPA = "2 Pedro"
    static let NT_1JOHN_SPA = "1 Juan"
    static let NT_2JOHN_SPA = "2 Juan"
    static let NT_3JOHN_SPA = "3 Juan"
    static let NT_JUDE_SPA = "Jude"
    static let NT_REVELATION_SPA = "Apocalipsis"
    static let NT_TESTIMONY_SPA = "Testimonio del Nuevo Testamento"
    static let NT_LIST_SPA: [String] = [NT_TITLE_SPA, NT_MATTHEW_SPA, NT_MARK_SPA, NT_LUKE_SPA, NT_JOHN_SPA, NT_ACTS_SPA, NT_ROMANS_SPA, NT_1COR_SPA, NT_2COR_SPA, NT_GALATIANS_SPA, NT_EPHESIANS_SPA, NT_PHILIPPIANS_SPA, NT_COLOSSIANS_SPA, NT_1THES_SPA, NT_2THES_SPA, NT_1TIM_SPA, NT_2TIM_SPA, NT_TITUS_SPA, NT_PHILEMON_SPA, NT_HEBREWS_SPA, NT_JAMES_SPA, NT_1PETER_SPA, NT_2PETER_SPA, NT_1JOHN_SPA, NT_2JOHN_SPA, NT_3JOHN_SPA, NT_JUDE_SPA, NT_REVELATION_SPA, NT_TESTIMONY_SPA]
    
    static let NT_LIST = [NT_LIST_ENG, NT_LIST_SPA]
    static let NT_TITLE_ARRAY = [NT_LIST[0][0], NT_LIST[1][0]]
    static let NT_MATTHEW_ARRAY = [NT_LIST[0][1], NT_LIST[1][1]]
    static let NT_MARK_ARRAY = [NT_LIST[0][2], NT_LIST[1][2]]
    static let NT_LUKE_ARRAY = [NT_LIST[0][3], NT_LIST[1][3]]
    static let NT_JOHN_ARRAY = [NT_LIST[0][4], NT_LIST[1][4]]
    static let NT_ACTS_ARRAY = [NT_LIST[0][5], NT_LIST[1][5]]
    static let NT_ROMANS_ARRAY = [NT_LIST[0][6], NT_LIST[1][6]]
    static let NT_1COR_ARRAY = [NT_LIST[0][7], NT_LIST[1][7]]
    static let NT_2COR_ARRAY = [NT_LIST[0][8], NT_LIST[1][8]]
    static let NT_GALATIANS_ARRAY = [NT_LIST[0][9], NT_LIST[1][9]]
    static let NT_EPHESIANS_ARRAY = [NT_LIST[0][10], NT_LIST[1][10]]
    static let NT_PHILIPPIANS_ARRAY = [NT_LIST[0][11], NT_LIST[1][11]]
    static let NT_COLOSSIANS_ARRAY = [NT_LIST[0][12], NT_LIST[1][12]]
    static let NT_1THES_ARRAY = [NT_LIST[0][13], NT_LIST[1][13]]
    static let NT_2THES_ARRAY = [NT_LIST[0][14], NT_LIST[1][14]]
    static let NT_1TIM_ARRAY = [NT_LIST[0][15], NT_LIST[1][15]]
    static let NT_2TIM_ARRAY = [NT_LIST[0][16], NT_LIST[1][16]]
    static let NT_TITUS_ARRAY = [NT_LIST[0][17], NT_LIST[1][17]]
    static let NT_PHILEMON_ARRAY = [NT_LIST[0][18], NT_LIST[1][18]]
    static let NT_HEBREWS_ARRAY = [NT_LIST[0][19], NT_LIST[1][19]]
    static let NT_JAMES_ARRAY = [NT_LIST[0][20], NT_LIST[1][20]]
    static let NT_1PETER_ARRAY = [NT_LIST[0][21], NT_LIST[1][21]]
    static let NT_2PETER_ARRAY = [NT_LIST[0][22], NT_LIST[1][22]]
    static let NT_1JOHN_ARRAY = [NT_LIST[0][23], NT_LIST[1][23]]
    static let NT_2JOHN_ARRAY = [NT_LIST[0][24], NT_LIST[1][24]]
    static let NT_3JOHN_ARRAY = [NT_LIST[0][25], NT_LIST[1][25]]
    static let NT_JUDE_ARRAY = [NT_LIST[0][26], NT_LIST[1][26]]
    static let NT_REVELATION_ARRAY = [NT_LIST[0][27], NT_LIST[1][27]]
    static let NT_TESTIMONY_ARRAY = [NT_LIST[0][28], NT_LIST[1][28]]
    
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
    
    static let SUB_BOOK_LIST = [[BOM_LIST_ENG, PGP_LIST_ENG, DC_LIST_ENG, OT_LIST_ENG, NT_LIST_ENG],
                                [BOM_LIST_SPA, PGP_LIST_SPA, DC_LIST_SPA, OT_LIST_SPA, NT_LIST_SPA]]
    
    //https://www.lds.org/general-conference/2011/10/the-power-of-scripture?lang=eng
    //http://storiesforseminary.wikispaces.com/Richard+G.+Scott+makes+audio+recording+of+the+Book+of+Mormon+for+his+family
    static let SCOTT_QUOTE: [String] =
        ["My precious wife, Jeanene, loved the Book of Mormon. In her youth, as a teenager, it became the foundation of her life. It was a source of testimony and teaching during her full-time missionary service in the northwest United States. When we served in the mission field in Córdoba, Argentina, she strongly encouraged the use of the Book of Mormon in our proselytizing efforts. Jeanene confirmed early in her life that those who consistently read the Book of Mormon are blessed with an added measure of the Spirit of the Lord, a greater resolve to obey His commandments, and a stronger testimony of the divinity of the Son of God. 1 For I don’t know how many years, as the end of the year approached, I would see her sitting quietly, carefully finishing the entire Book of Mormon yet another time before year’s end.\n\nIn 1991 I wanted to give a special Christmas gift to my family. In recording the fulfillment of that desire, my personal journal states: “It is 12:38 p.m., Wednesday, December 18, 1991. I’ve just concluded an audio recording of the Book of Mormon for my family. This has been an experience that has increased my testimony of this divine work and strengthened in me a desire to be more familiar with its pages to distill from these scriptures truths to be used in my service to the Lord. I love this book. I testify with my soul that it is true, that it was prepared for the blessing of the House of Israel, and all of its component parts spread throughout the world. All who will study its message in humility, in faith believing in Jesus Christ, will know of its truthfulness and will find a treasure to lead them to greater happiness, peace, and attainment in this life. I testify by all that is sacred, this book is true.\n\nThe Power of Scripture\n\nRichard G. Scott, October 2011 General Conference",
         "Mi querida esposa Jeanene amaba el Libro de Mormón. En su juventud, de adolecente, llegó a ser el cimiento de su vida y una fuente de testimonio y enseñanza durante su servicio misional de tiempo completo en los estados del noroeste de los Estados Unidos. Cuando servimos en el campo misional en Córdoba, Argentina, ella alentaba con gran firmeza el uso del Libro de Mormón en nuestro esfuerzo proselitista. Jeanene confirmó desde muy joven que quienes leían en forma consecuente el Libro de Mormón eran bendecidos con una porción más del Espíritu del Señor, con una gran resolución de obedecer Sus mandamientos y un firme testimonio de la divinidad del Hijo de Dios1. No sé por cuántos años, al acercarse el fin del año, la veía sentada muy callada terminando de leer detenidamente el Libro de Mormón una vez más antes de que terminase el año.\n\nEn 1991, quise dar a mi familia un regalo especial de Navidad. Al registrar el logro de ese deseo, en mi diario personal anoté: “Son las 12:38 de la noche del miércoles 18 de diciembre de 1991. He terminado recién la grabación en audio del Libro de Mormón para mi familia. Ésta ha sido una experiencia que ha acrecentado mi testimonio de esta divina obra y fortalecido mi deseo de familiarizarme más con sus páginas, para extraer de estas Escrituras verdades para utilizar en mi servicio al Señor. Amo este libro. Testifico con toda mi alma que es verdadero, que fue preparado para bendecir la Casa de Israel y que todas sus partes se propagan por el mundo. Todos los que estudien su mensaje con humildad, con fe, creyendo en Jesucristo, sabrán de su veracidad y encontrarán un tesoro que les conducirá a una mayor felicidad, paz y logro en esta vida. Testifico, por todo lo que es sagrado, que este libro es verdadero.\n\nEl poder de las Escrituras\n\nRichard G. Scott, Octubre 2011, Conferencia general"]
    
}
