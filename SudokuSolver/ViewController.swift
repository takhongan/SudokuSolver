//
//  ViewController.swift
//  SudokuSolver
//
//  Created by Takayoshi Hongan on 5/17/15.
//  Copyright (c) 2015 Takayoshi Hongan. All rights reserved.
//
//  The MIT License (MIT)
//  https://opensource.org/licenses/MIT
//


import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var btnLoadCSVFile: NSButton!
    @IBOutlet var btnSolve: NSView!
    @IBOutlet weak var btnQuit: NSButton!
    @IBOutlet weak var lblCell11: NSTextField!
    @IBOutlet weak var lblCell12: NSTextField!
    @IBOutlet weak var lblCell13: NSTextField!
    @IBOutlet weak var lblCell14: NSTextField!
    @IBOutlet weak var lblCell15: NSTextField!
    @IBOutlet weak var lblCell16: NSTextField!
    @IBOutlet weak var lblCell17: NSTextField!
    @IBOutlet weak var lblCell18: NSTextField!
    @IBOutlet weak var lblCell19: NSTextField!
    @IBOutlet weak var lblCell21: NSTextField!
    @IBOutlet weak var lblCell22: NSTextField!
    @IBOutlet weak var lblCell23: NSTextField!
    @IBOutlet weak var lblCell24: NSTextField!
    @IBOutlet weak var lblCell25: NSTextField!
    @IBOutlet weak var lblCell26: NSTextField!
    @IBOutlet weak var lblCell27: NSTextField!
    @IBOutlet weak var lblCell28: NSTextField!
    @IBOutlet weak var lblCell29: NSTextField!
    @IBOutlet weak var lblCell31: NSTextField!
    @IBOutlet weak var lblCell32: NSTextField!
    @IBOutlet weak var lblCell33: NSTextField!
    @IBOutlet weak var lblCell34: NSTextField!
    @IBOutlet weak var lblCell35: NSTextField!
    @IBOutlet weak var lblCell36: NSTextField!
    @IBOutlet weak var lblCell37: NSTextField!
    @IBOutlet weak var lblCell38: NSTextField!
    @IBOutlet weak var lblCell39: NSTextField!
    @IBOutlet weak var lblCell41: NSTextField!
    @IBOutlet weak var lblCell42: NSTextField!
    @IBOutlet weak var lblCell43: NSTextField!
    @IBOutlet weak var lblCell44: NSTextField!
    @IBOutlet weak var lblCell45: NSTextField!
    @IBOutlet weak var lblCell46: NSTextField!
    @IBOutlet weak var lblCell47: NSTextField!
    @IBOutlet weak var lblCell48: NSTextField!
    @IBOutlet weak var lblCell49: NSTextField!
    @IBOutlet weak var lblCell51: NSTextField!
    @IBOutlet weak var lblCell52: NSTextField!
    @IBOutlet weak var lblCell53: NSTextField!
    @IBOutlet weak var lblCell54: NSTextField!
    @IBOutlet weak var lblCell55: NSTextField!
    @IBOutlet weak var lblCell56: NSTextField!
    @IBOutlet weak var lblCell57: NSTextField!
    @IBOutlet weak var lblCell58: NSTextField!
    @IBOutlet weak var lblCell59: NSTextField!
    @IBOutlet weak var lblCell61: NSTextField!
    @IBOutlet weak var lblCell62: NSTextField!
    @IBOutlet weak var lblCell63: NSTextField!
    @IBOutlet weak var lblCell64: NSTextField!
    @IBOutlet weak var lblCell65: NSTextField!
    @IBOutlet weak var lblCell66: NSTextField!
    @IBOutlet weak var lblCell67: NSTextField!
    @IBOutlet weak var lblCell68: NSTextField!
    @IBOutlet weak var lblCell69: NSTextField!
    @IBOutlet weak var lblCell71: NSTextField!
    @IBOutlet weak var lblCell72: NSTextField!
    @IBOutlet weak var lblCell73: NSTextField!
    @IBOutlet weak var lblCell74: NSTextField!
    @IBOutlet weak var lblCell75: NSTextField!
    @IBOutlet weak var lblCell76: NSTextField!
    @IBOutlet weak var lblCell77: NSTextField!
    @IBOutlet weak var lblCell78: NSTextField!
    @IBOutlet weak var lblCell79: NSTextField!
    @IBOutlet weak var lblCell81: NSTextField!
    @IBOutlet weak var lblCell82: NSTextField!
    @IBOutlet weak var lblCell83: NSTextField!
    @IBOutlet weak var lblCell84: NSTextField!
    @IBOutlet weak var lblCell85: NSTextField!
    @IBOutlet weak var lblCell86: NSTextField!
    @IBOutlet weak var lblCell87: NSTextField!
    @IBOutlet weak var lblCell88: NSTextField!
    @IBOutlet weak var lblCell89: NSTextField!
    @IBOutlet weak var lblCell91: NSTextField!
    @IBOutlet weak var lblCell92: NSTextField!
    @IBOutlet weak var lblCell93: NSTextField!
    @IBOutlet weak var lblCell94: NSTextField!
    @IBOutlet weak var lblCell95: NSTextField!
    @IBOutlet weak var lblCell96: NSTextField!
    @IBOutlet weak var lblCell97: NSTextField!
    @IBOutlet weak var lblCell98: NSTextField!
    @IBOutlet weak var lblCell99: NSTextField!

    var blFirstTime : Bool = false

    @IBAction func btnSolve(sender: AnyObject) {
        var strValues : [[String]] = GetAllCells()
        let obj9x9Cell : Sudoku9x9Cells = Sudoku9x9Cells (strV: strValues as [[String]]) as Sudoku9x9Cells
        var objCells : [[SudokuCell]] = obj9x9Cell.getSudokuCells() as [[SudokuCell]]
        objCells = Sudoku9x9Cells.applyRules( objCells as [[SudokuCell]] )
        strValues = obj9x9Cell.resultCells() as [[String]]

        SetAllCells(strValues as [[String]])
    }

    @IBAction func btnLoadCSVFile(sender: AnyObject) {
        var strValues = [[]]
        var strCsvFilePath : String?
        blFirstTime = true

        strValues.removeAll(keepCapacity: false)
        strCsvFilePath = OpenFile()
        if (strCsvFilePath != nil){
            //            println(strCsvFilePath);
            
            let strCsvContents = try? String(contentsOfFile: strCsvFilePath!, encoding: NSUTF8StringEncoding)
            
            //var strCsvContentLine : NSString
            //var intRow : Int = 0
            strCsvContents?.enumerateLines {
                strCsvContentLine, stop in
                
                NSFileManager().fileExistsAtPath(strCsvContentLine)
                let strCsvParagraphs = strCsvContentLine.componentsSeparatedByString("\r")
                if strCsvParagraphs.count > 0 {
                    for items in strCsvParagraphs {
                        strValues.append (items.componentsSeparatedByString(","))
                    }
                }
            }
//            println(strValues)

            SetAllCells(strValues as! [[String]])
        }
        else {
            print("nothing");
        }
    }

    private func GetAllCells() -> [[String]]{
        // -----
        return [
            [
                GetCell(lblCell11 as NSTextField) as String,
                GetCell(lblCell12 as NSTextField) as String,
                GetCell(lblCell13 as NSTextField) as String,
                GetCell(lblCell14 as NSTextField) as String,
                GetCell(lblCell15 as NSTextField) as String,
                GetCell(lblCell16 as NSTextField) as String,
                GetCell(lblCell17 as NSTextField) as String,
                GetCell(lblCell18 as NSTextField) as String,
                GetCell(lblCell19 as NSTextField) as String
            ], [
                GetCell(lblCell21 as NSTextField) as String,
                GetCell(lblCell22 as NSTextField) as String,
                GetCell(lblCell23 as NSTextField) as String,
                GetCell(lblCell24 as NSTextField) as String,
                GetCell(lblCell25 as NSTextField) as String,
                GetCell(lblCell26 as NSTextField) as String,
                GetCell(lblCell27 as NSTextField) as String,
                GetCell(lblCell28 as NSTextField) as String,
                GetCell(lblCell29 as NSTextField) as String
            ], [
                GetCell(lblCell31 as NSTextField) as String,
                GetCell(lblCell32 as NSTextField) as String,
                GetCell(lblCell33 as NSTextField) as String,
                GetCell(lblCell34 as NSTextField) as String,
                GetCell(lblCell35 as NSTextField) as String,
                GetCell(lblCell36 as NSTextField) as String,
                GetCell(lblCell37 as NSTextField) as String,
                GetCell(lblCell38 as NSTextField) as String,
                GetCell(lblCell39 as NSTextField) as String
            ], [
                GetCell(lblCell41 as NSTextField) as String,
                GetCell(lblCell42 as NSTextField) as String,
                GetCell(lblCell43 as NSTextField) as String,
                GetCell(lblCell44 as NSTextField) as String,
                GetCell(lblCell45 as NSTextField) as String,
                GetCell(lblCell46 as NSTextField) as String,
                GetCell(lblCell47 as NSTextField) as String,
                GetCell(lblCell48 as NSTextField) as String,
                GetCell(lblCell49 as NSTextField) as String
            ], [
                GetCell(lblCell51 as NSTextField) as String,
                GetCell(lblCell52 as NSTextField) as String,
                GetCell(lblCell53 as NSTextField) as String,
                GetCell(lblCell54 as NSTextField) as String,
                GetCell(lblCell55 as NSTextField) as String,
                GetCell(lblCell56 as NSTextField) as String,
                GetCell(lblCell57 as NSTextField) as String,
                GetCell(lblCell58 as NSTextField) as String,
                GetCell(lblCell59 as NSTextField) as String
            ], [
                GetCell(lblCell61 as NSTextField) as String,
                GetCell(lblCell62 as NSTextField) as String,
                GetCell(lblCell63 as NSTextField) as String,
                GetCell(lblCell64 as NSTextField) as String,
                GetCell(lblCell65 as NSTextField) as String,
                GetCell(lblCell66 as NSTextField) as String,
                GetCell(lblCell67 as NSTextField) as String,
                GetCell(lblCell68 as NSTextField) as String,
                GetCell(lblCell69 as NSTextField) as String
            ], [
                GetCell(lblCell71 as NSTextField) as String,
                GetCell(lblCell72 as NSTextField) as String,
                GetCell(lblCell73 as NSTextField) as String,
                GetCell(lblCell74 as NSTextField) as String,
                GetCell(lblCell75 as NSTextField) as String,
                GetCell(lblCell76 as NSTextField) as String,
                GetCell(lblCell77 as NSTextField) as String,
                GetCell(lblCell78 as NSTextField) as String,
                GetCell(lblCell79 as NSTextField) as String
            ], [
                GetCell(lblCell81 as NSTextField) as String,
                GetCell(lblCell82 as NSTextField) as String,
                GetCell(lblCell83 as NSTextField) as String,
                GetCell(lblCell84 as NSTextField) as String,
                GetCell(lblCell85 as NSTextField) as String,
                GetCell(lblCell86 as NSTextField) as String,
                GetCell(lblCell87 as NSTextField) as String,
                GetCell(lblCell88 as NSTextField) as String,
                GetCell(lblCell89 as NSTextField) as String
            ], [
                GetCell(lblCell91 as NSTextField) as String,
                GetCell(lblCell92 as NSTextField) as String,
                GetCell(lblCell93 as NSTextField) as String,
                GetCell(lblCell94 as NSTextField) as String,
                GetCell(lblCell95 as NSTextField) as String,
                GetCell(lblCell96 as NSTextField) as String,
                GetCell(lblCell97 as NSTextField) as String,
                GetCell(lblCell98 as NSTextField) as String,
                GetCell(lblCell99 as NSTextField) as String
                ]
        ]
    }
    private func GetCell(lblCell : NSTextField) -> String{
        let str : String = lblCell.stringValue
        return str
    }
    private func SetAllCells(var strValues : [[String]]) {
//        println(count(self.strValues[0][0] as! String))

        // -----
        SetCell(lblCell11 as NSTextField , strV: strValues[0][0] as String)
        SetCell(lblCell12 as NSTextField , strV: strValues[0][1] as String)
        SetCell(lblCell13 as NSTextField , strV: strValues[0][2] as String)
        SetCell(lblCell14 as NSTextField , strV: strValues[0][3] as String)
        SetCell(lblCell15 as NSTextField , strV: strValues[0][4] as String)
        SetCell(lblCell16 as NSTextField , strV: strValues[0][5] as String)
        SetCell(lblCell17 as NSTextField , strV: strValues[0][6] as String)
        SetCell(lblCell18 as NSTextField , strV: strValues[0][7] as String)
        SetCell(lblCell19 as NSTextField , strV: strValues[0][8] as String)
        SetCell(lblCell21 as NSTextField , strV: strValues[1][0] as String)
        SetCell(lblCell22 as NSTextField , strV: strValues[1][1] as String)
        SetCell(lblCell23 as NSTextField , strV: strValues[1][2] as String)
        SetCell(lblCell24 as NSTextField , strV: strValues[1][3] as String)
        SetCell(lblCell25 as NSTextField , strV: strValues[1][4] as String)
        SetCell(lblCell26 as NSTextField , strV: strValues[1][5] as String)
        SetCell(lblCell27 as NSTextField , strV: strValues[1][6] as String)
        SetCell(lblCell28 as NSTextField , strV: strValues[1][7] as String)
        SetCell(lblCell29 as NSTextField , strV: strValues[1][8] as String)
        SetCell(lblCell31 as NSTextField , strV: strValues[2][0] as String)
        SetCell(lblCell32 as NSTextField , strV: strValues[2][1] as String)
        SetCell(lblCell33 as NSTextField , strV: strValues[2][2] as String)
        SetCell(lblCell34 as NSTextField , strV: strValues[2][3] as String)
        SetCell(lblCell35 as NSTextField , strV: strValues[2][4] as String)
        SetCell(lblCell36 as NSTextField , strV: strValues[2][5] as String)
        SetCell(lblCell37 as NSTextField , strV: strValues[2][6] as String)
        SetCell(lblCell38 as NSTextField , strV: strValues[2][7] as String)
        SetCell(lblCell39 as NSTextField , strV: strValues[2][8] as String)
        // -----
        SetCell(lblCell41 as NSTextField , strV: strValues[3][0] as String)
        SetCell(lblCell42 as NSTextField , strV: strValues[3][1] as String)
        SetCell(lblCell43 as NSTextField , strV: strValues[3][2] as String)
        SetCell(lblCell44 as NSTextField , strV: strValues[3][3] as String)
        SetCell(lblCell45 as NSTextField , strV: strValues[3][4] as String)
        SetCell(lblCell46 as NSTextField , strV: strValues[3][5] as String)
        SetCell(lblCell47 as NSTextField , strV: strValues[3][6] as String)
        SetCell(lblCell48 as NSTextField , strV: strValues[3][7] as String)
        SetCell(lblCell49 as NSTextField , strV: strValues[3][8] as String)
        SetCell(lblCell51 as NSTextField , strV: strValues[4][0] as String)
        SetCell(lblCell52 as NSTextField , strV: strValues[4][1] as String)
        SetCell(lblCell53 as NSTextField , strV: strValues[4][2] as String)
        SetCell(lblCell54 as NSTextField , strV: strValues[4][3] as String)
        SetCell(lblCell55 as NSTextField , strV: strValues[4][4] as String)
        SetCell(lblCell56 as NSTextField , strV: strValues[4][5] as String)
        SetCell(lblCell57 as NSTextField , strV: strValues[4][6] as String)
        SetCell(lblCell58 as NSTextField , strV: strValues[4][7] as String)
        SetCell(lblCell59 as NSTextField , strV: strValues[4][8] as String)
        SetCell(lblCell61 as NSTextField , strV: strValues[5][0] as String)
        SetCell(lblCell62 as NSTextField , strV: strValues[5][1] as String)
        SetCell(lblCell63 as NSTextField , strV: strValues[5][2] as String)
        SetCell(lblCell64 as NSTextField , strV: strValues[5][3] as String)
        SetCell(lblCell65 as NSTextField , strV: strValues[5][4] as String)
        SetCell(lblCell66 as NSTextField , strV: strValues[5][5] as String)
        SetCell(lblCell67 as NSTextField , strV: strValues[5][6] as String)
        SetCell(lblCell68 as NSTextField , strV: strValues[5][7] as String)
        SetCell(lblCell69 as NSTextField , strV: strValues[5][8] as String)
        // -----
        SetCell(lblCell71 as NSTextField , strV: strValues[6][0] as String)
        SetCell(lblCell72 as NSTextField , strV: strValues[6][1] as String)
        SetCell(lblCell73 as NSTextField , strV: strValues[6][2] as String)
        SetCell(lblCell74 as NSTextField , strV: strValues[6][3] as String)
        SetCell(lblCell75 as NSTextField , strV: strValues[6][4] as String)
        SetCell(lblCell76 as NSTextField , strV: strValues[6][5] as String)
        SetCell(lblCell77 as NSTextField , strV: strValues[6][6] as String)
        SetCell(lblCell78 as NSTextField , strV: strValues[6][7] as String)
        SetCell(lblCell79 as NSTextField , strV: strValues[6][8] as String)
        SetCell(lblCell81 as NSTextField , strV: strValues[7][0] as String)
        SetCell(lblCell82 as NSTextField , strV: strValues[7][1] as String)
        SetCell(lblCell83 as NSTextField , strV: strValues[7][2] as String)
        SetCell(lblCell84 as NSTextField , strV: strValues[7][3] as String)
        SetCell(lblCell85 as NSTextField , strV: strValues[7][4] as String)
        SetCell(lblCell86 as NSTextField , strV: strValues[7][5] as String)
        SetCell(lblCell87 as NSTextField , strV: strValues[7][6] as String)
        SetCell(lblCell88 as NSTextField , strV: strValues[7][7] as String)
        SetCell(lblCell89 as NSTextField , strV: strValues[7][8] as String)
        SetCell(lblCell91 as NSTextField , strV: strValues[8][0] as String)
        SetCell(lblCell92 as NSTextField , strV: strValues[8][1] as String)
        SetCell(lblCell93 as NSTextField , strV: strValues[8][2] as String)
        SetCell(lblCell94 as NSTextField , strV: strValues[8][3] as String)
        SetCell(lblCell95 as NSTextField , strV: strValues[8][4] as String)
        SetCell(lblCell96 as NSTextField , strV: strValues[8][5] as String)
        SetCell(lblCell97 as NSTextField , strV: strValues[8][6] as String)
        SetCell(lblCell98 as NSTextField , strV: strValues[8][7] as String)
        SetCell(lblCell99 as NSTextField , strV: strValues[8][8] as String)
        blFirstTime = false

    }
    private func SetCell(lblCell : NSTextField, strV : String) {

        if ((strV as String).characters.count > 0) {
            if blFirstTime {
                lblCell.textColor = NSColor.magentaColor()
            }
            lblCell.stringValue = strV as String
        } else {
            lblCell.textColor = NSColor.blackColor()
            lblCell.stringValue = ""
        }
    }
    
    private func OpenFile() -> String?{
        let myFiledialog: NSOpenPanel = NSOpenPanel()
        var strCsvFilePath : String?
        
        myFiledialog.prompt = "Open CSV File"
        myFiledialog.worksWhenModal = true
        myFiledialog.allowsMultipleSelection = false
        myFiledialog.canChooseDirectories = false
        myFiledialog.resolvesAliases = true
        myFiledialog.title = "File Open"
        myFiledialog.message = "File Open"
        myFiledialog.runModal()
        let chosenfile = myFiledialog.URL
        if (chosenfile != nil)
        {
            strCsvFilePath = chosenfile!.absoluteString;
            let idx = strCsvFilePath!.rangeOfString("file://")?.endIndex
            if (idx != nil) {
                strCsvFilePath = strCsvFilePath!.substringFromIndex(idx!)
            }
            return strCsvFilePath;
            //            println(strCsvFilePath);
        } else {
            return nil
        }
    }

    @IBAction func btnQuit(sender: AnyObject) {
        exit(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

