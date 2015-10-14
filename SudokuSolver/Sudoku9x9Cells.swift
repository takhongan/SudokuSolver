//
//  Sudoku9x9Cells.swift
//  SudokuSolver
//
//  Created by Takayoshi Hongan on 5/17/15.
//  Copyright (c) 2015 Takayoshi Hongan. All rights reserved.
//
//  GNU LESSER GENERAL PUBLIC LICENSE Version 3
//  http://www.gnu.org/licenses/lgpl-3.0.en.html


import Cocoa

class Sudoku9x9Cells {
    var cell3x3Candidate = [[Sudoku3x3Cells]]()
    
    init ( strV : [[String]] ) {
        let strV11 : [[String]] = [
            [strV[0][0],strV[0][1],strV[0][2]],
            [strV[1][0],strV[1][1],strV[1][2]],
            [strV[2][0],strV[2][1],strV[2][2]]]
        let strV12 : [[String]] = [
            [strV[0][3],strV[0][4],strV[0][5]],
            [strV[1][3],strV[1][4],strV[1][5]],
            [strV[2][3],strV[2][4],strV[2][5]]]
        let strV13 : [[String]] = [
            [strV[0][6],strV[0][7],strV[0][8]],
            [strV[1][6],strV[1][7],strV[1][8]],
            [strV[2][6],strV[2][7],strV[2][8]]]
        let strV21 : [[String]] = [
            [strV[3][0],strV[3][1],strV[3][2]],
            [strV[4][0],strV[4][1],strV[4][2]],
            [strV[5][0],strV[5][1],strV[5][2]]]
        let strV22 : [[String]] = [
            [strV[3][3],strV[3][4],strV[3][5]],
            [strV[4][3],strV[4][4],strV[4][5]],
            [strV[5][3],strV[5][4],strV[5][5]]]
        let strV23 : [[String]] = [
            [strV[3][6],strV[3][7],strV[3][8]],
            [strV[4][6],strV[4][7],strV[4][8]],
            [strV[5][6],strV[5][7],strV[5][8]]]
        let strV31 : [[String]] = [
            [strV[6][0],strV[6][1],strV[6][2]],
            [strV[7][0],strV[7][1],strV[7][2]],
            [strV[8][0],strV[8][1],strV[8][2]]]
        let strV32 : [[String]] = [
            [strV[6][3],strV[6][4],strV[6][5]],
            [strV[7][3],strV[7][4],strV[7][5]],
            [strV[8][3],strV[8][4],strV[8][5]]]
        let strV33 : [[String]] = [
            [strV[6][6],strV[6][7],strV[6][8]],
            [strV[7][6],strV[7][7],strV[7][8]],
            [strV[8][6],strV[8][7],strV[8][8]]]
        cell3x3Candidate = [
            [Sudoku3x3Cells(strV: strV11 as [[String]]), Sudoku3x3Cells(strV: strV12 as [[String]]), Sudoku3x3Cells(strV: strV13 as [[String]])],
            [Sudoku3x3Cells(strV: strV21 as [[String]]), Sudoku3x3Cells(strV: strV22 as [[String]]), Sudoku3x3Cells(strV: strV23 as [[String]])],
            [Sudoku3x3Cells(strV: strV31 as [[String]]), Sudoku3x3Cells(strV: strV32 as [[String]]), Sudoku3x3Cells(strV: strV33 as [[String]])]
        ]
    }
    init ( objV : [[SudokuCell]] ) {
        setSudokuCells(objV)
    }

    class func applyRules (objV : [[SudokuCell]]) -> [[SudokuCell]]{
        let obj9x9 : Sudoku9x9Cells = Sudoku9x9Cells (objV : objV as [[SudokuCell]])
        var strTmpCells : [[String]]
        var strV_backup  : [[String]]
        var intCount : Int = 0
        repeat {
            strV_backup  = obj9x9.resultCells() as [[String]]
            obj9x9.applyBasicRule1 ()
            obj9x9.applyBasicRule2 ()
            obj9x9.applyBasicRule3 ()
            obj9x9.setSudokuCells(obj9x9.getSudokuCells() as [[SudokuCell]])
            strTmpCells = obj9x9.resultCells() as [[String]]
        } while strV_backup != strTmpCells && intCount++ < 99

        if !obj9x9.isSolved() {
            var objCells2 : [[SudokuCell]] = obj9x9.getSudokuCells() as [[SudokuCell]]
            for (var i : Int = 0; i < 9; i++) {
                for (var j : Int = 0; j < 9; j++) {
                    if !objCells2[i][j].isSolved() {
                        var objCells_backup = objCells2
                        let strV : String = objCells2[i][j].getCandidatesValue()
                        print("\(i) : \(j) ; \(strV) ")
                        objCells2[i][j].setSolvedValue (strV)
                        objCells2 = Sudoku9x9Cells.applyRules(objCells2)
                        if obj9x9.isSolved() {
                            obj9x9.setSudokuCells( obj9x9.getSudokuCells())
                            break;
                        } else {
                            objCells2[i][j] = objCells_backup[i][j]
                            objCells2[i][j].removeCandidate(strV)
                            //objCells2 = obj9x9Cell.getSudokuCells()
                            //return obj9x9Cell.adoptRule4(objCells2)
                        }
                    }
                }
            }
        }
        return obj9x9.getSudokuCells()
    }

    func applyBasicRule1 () {
        // rule 1
        var objS : [[SudokuCell]] = self.getSudokuCells()
        for (var i : Int = 0 ; i < 9 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if objS[i][j].isSolved() {
                    //                    println("\(i), \(j), \(objS[i][j].isSolved()) , \(objS[i][j].resultValue())")
                    for (var k : Int = 0; k < 9; k++) {
                        objS[i][k].removeCandidate(objS[i][j].resultValue())
                        objS[k][j].removeCandidate(objS[i][j].resultValue())
                    }
                }
            }
        }
        self.setSudokuCells(objS)
    }
    func applyBasicRule1 (strV : [[String]]) {
        // rule 1
        for (var i : Int = 0 ; i < 3 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if ((strV[i][j] as String).characters.count > 0) {
                    cell3x3Candidate[0][0].removeColCandidate(i as Int, strValue: strV[i][j] as String)
                    cell3x3Candidate[0][1].removeColCandidate(i as Int, strValue: strV[i][j] as String)
                    cell3x3Candidate[0][2].removeColCandidate(i as Int, strValue: strV[i][j] as String)
                }
            }
        }
        for (var i : Int = 3 ; i < 6 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if ((strV[i][j] as String).characters.count > 0) {
                    cell3x3Candidate[1][0].removeColCandidate(i%3 as Int, strValue: strV[i][j] as String)
                    cell3x3Candidate[1][1].removeColCandidate(i%3 as Int, strValue: strV[i][j] as String)
                    cell3x3Candidate[1][2].removeColCandidate(i%3 as Int, strValue: strV[i][j] as String)
                }
            }
        }
        for (var i : Int = 6 ; i < 9 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if ((strV[i][j] as String).characters.count > 0) {
                    cell3x3Candidate[2][0].removeColCandidate(i%3 as Int, strValue: strV[i][j] as String)
                    cell3x3Candidate[2][1].removeColCandidate(i%3 as Int, strValue: strV[i][j] as String)
                    cell3x3Candidate[2][2].removeColCandidate(i%3 as Int, strValue: strV[i][j] as String)
                }
            }
        }
        
        for (var i : Int = 0 ; i < 3 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if ((strV[j][i] as String).characters.count > 0) {
                    cell3x3Candidate[0][0].removeRowCandidate(i as Int, strValue: strV[j][i] as String)
                    cell3x3Candidate[1][0].removeRowCandidate(i as Int, strValue: strV[j][i] as String)
                    cell3x3Candidate[2][0].removeRowCandidate(i as Int, strValue: strV[j][i] as String)
                }
            }
        }
        for (var i : Int = 3 ; i < 6 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if ((strV[j][i] as String).characters.count > 0) {
                    cell3x3Candidate[0][1].removeRowCandidate(i%3 as Int, strValue: strV[j][i] as String)
                    cell3x3Candidate[1][1].removeRowCandidate(i%3 as Int, strValue: strV[j][i] as String)
                    cell3x3Candidate[2][1].removeRowCandidate(i%3 as Int, strValue: strV[j][i] as String)
                }
            }
        }
        for (var i : Int = 6 ; i < 9 ; i++) {
            for (var j : Int = 0 ; j < 9 ; j++) {
                if ((strV[j][i] as String).characters.count > 0) {
                    cell3x3Candidate[0][2].removeRowCandidate(i%3 as Int, strValue: strV[j][i] as String)
                    cell3x3Candidate[1][2].removeRowCandidate(i%3 as Int, strValue: strV[j][i] as String)
                    cell3x3Candidate[2][2].removeRowCandidate(i%3 as Int, strValue: strV[j][i] as String)
                }
            }
        }
    }
    func applyBasicRule2 () {
        cell3x3Candidate[0][0].removeOverlappingCandidate()
        cell3x3Candidate[0][1].removeOverlappingCandidate()
        cell3x3Candidate[0][2].removeOverlappingCandidate()
        cell3x3Candidate[1][0].removeOverlappingCandidate()
        cell3x3Candidate[1][1].removeOverlappingCandidate()
        cell3x3Candidate[1][2].removeOverlappingCandidate()
        cell3x3Candidate[2][0].removeOverlappingCandidate()
        cell3x3Candidate[2][1].removeOverlappingCandidate()
        cell3x3Candidate[2][2].removeOverlappingCandidate()
        
    }
    func applyBasicRule3 () {
        // rule 2
        for (var intC1 : Int = 0; intC1 < 3; intC1++) {
            for (var intC2 : Int = 0; intC2 < 3; intC2++) {
                for (var intCV : Int = 1; intCV <= 9; intCV++ ) {
                    var objR1 : [SudokuCell] = cell3x3Candidate[intC1][intC2].getRowCells(0)
                    var objR2 : [SudokuCell] = cell3x3Candidate[intC1][intC2].getRowCells(1)
                    var objR3 : [SudokuCell] = cell3x3Candidate[intC1][intC2].getRowCells(2)
                    var intExistCount : Int = 0
                    var intExistCellR1 : Int = -1
                    var intExistCellR2 : Int = -1
                    var intExistCellR3 : Int = -1
                    if (objR1[0].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR1[1].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR1[2].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR2[0].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR2[1].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR2[2].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR3[0].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR3[1].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                        objR3[2].getNumberOfCandidatesIfIncluded(intCV.description) != 1)
                    {
                        for (var intR : Int = 0 ; intR < 3 ; intR++) {
                            if objR1[intR].isExist(intCV.description) {
                                intExistCount++;
                                intExistCellR1 = intR % 3
                            }
                            if objR2[intR].isExist(intCV.description) {
                                intExistCount++;
                                intExistCellR2 = intR % 3
                            }
                            if objR3[intR].isExist(intCV.description) {
                                intExistCount++;
                                intExistCellR3 = intR % 3
                            }
                        }
                        if intExistCount == 1 {
                            //                            println("\(intCV.description) ; \(intC1) : \(intC2) ; \(intExistCellR1) : \(intExistCellR2) : \(intExistCellR3) ")
                            if intExistCellR1 >= 0 {
                                cell3x3Candidate[intC1][intC2].setInitValue(0,
                                    intRow : intExistCellR1 as Int,
                                    strValue : intCV.description as String)
                            }
                            if intExistCellR2 >= 0 {
                                cell3x3Candidate[intC1][intC2].setInitValue(1,
                                    intRow : intExistCellR2 as Int,
                                    strValue : intCV.description as String)
                            }
                            if intExistCellR3 >= 0 {
                                cell3x3Candidate[intC1][intC2].setInitValue(2,
                                    intRow : intExistCellR3 as Int,
                                    strValue : intCV.description as String)
                            }
                        }
                    }
                }
            }
            for (var intC1 : Int = 0; intC1 < 3; intC1++) {
                for (var intC2 : Int = 0; intC2 < 3; intC2++) {
                    for (var intCV : Int = 1; intCV <= 9; intCV++ ) {
                        var objR1 : [SudokuCell] = cell3x3Candidate[intC1][intC2].getColCells(0)
                        var objR2 : [SudokuCell] = cell3x3Candidate[intC1][intC2].getColCells(1)
                        var objR3 : [SudokuCell] = cell3x3Candidate[intC1][intC2].getColCells(2)
                        var intExistCount : Int = 0
                        var intExistCellR1 : Int = -1
                        var intExistCellR2 : Int = -1
                        var intExistCellR3 : Int = -1
                        if (objR1[0].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR1[1].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR1[2].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR2[0].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR2[1].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR2[2].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR3[0].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR3[1].getNumberOfCandidatesIfIncluded(intCV.description) != 1 &&
                            objR3[2].getNumberOfCandidatesIfIncluded(intCV.description) != 1)
                        {
                            for (var intR : Int = 0 ; intR < 3 ; intR++) {
                                if objR1[intR].isExist(intCV.description) {
                                    intExistCount++;
                                    intExistCellR1 = intR % 3
                                }
                                if objR2[intR].isExist(intCV.description) {
                                    intExistCount++;
                                    intExistCellR2 = intR % 3
                                }
                                if objR3[intR].isExist(intCV.description) {
                                    intExistCount++;
                                    intExistCellR3 = intR % 3
                                }
                            }
                            if intExistCount == 1 {
                                //                                println("\(intCV.description) ; \(intC1) : \(intC2) ; \(intExistCellR1) : \(intExistCellR2) : \(intExistCellR3) ")
                                if intExistCellR1 >= 0 {
                                    cell3x3Candidate[intC1][intC2].setInitValue(intExistCellR1, intRow : 0,
                                        strValue : intCV.description as String)
                                }
                                if intExistCellR2 >= 0 {
                                    cell3x3Candidate[intC1][intC2].setInitValue(intExistCellR2, intRow : 1,
                                        strValue : intCV.description as String)
                                }
                                if intExistCellR3 >= 0 {
                                    cell3x3Candidate[intC1][intC2].setInitValue(intExistCellR3, intRow : 2,
                                        strValue : intCV.description as String)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setSudokuCells(objV : [[SudokuCell]] ) {
        let objV00 : [[SudokuCell]] = [
            [objV[0][0],objV[0][1],objV[0][2]],
            [objV[1][0],objV[1][1],objV[1][2]],
            [objV[2][0],objV[2][1],objV[2][2]]]
        let objV01 : [[SudokuCell]] = [
            [objV[0][3],objV[0][4],objV[0][5]],
            [objV[1][3],objV[1][4],objV[1][5]],
            [objV[2][3],objV[2][4],objV[2][5]]]
        let objV02 : [[SudokuCell]] = [
            [objV[0][6],objV[0][7],objV[0][8]],
            [objV[1][6],objV[1][7],objV[1][8]],
            [objV[2][6],objV[2][7],objV[2][8]]]
        let objV10 : [[SudokuCell]] = [
            [objV[3][0],objV[3][1],objV[3][2]],
            [objV[4][0],objV[4][1],objV[4][2]],
            [objV[5][0],objV[5][1],objV[5][2]]]
        let objV11 : [[SudokuCell]] = [
            [objV[3][3],objV[3][4],objV[3][5]],
            [objV[4][3],objV[4][4],objV[4][5]],
            [objV[5][3],objV[5][4],objV[5][5]]]
        let objV12 : [[SudokuCell]] = [
            [objV[3][6],objV[3][7],objV[3][8]],
            [objV[4][6],objV[4][7],objV[4][8]],
            [objV[5][6],objV[5][7],objV[5][8]]]
        let objV20 : [[SudokuCell]] = [
            [objV[6][0],objV[6][1],objV[6][2]],
            [objV[7][0],objV[7][1],objV[7][2]],
            [objV[8][0],objV[8][1],objV[8][2]]]
        let objV21 : [[SudokuCell]] = [
            [objV[6][3],objV[6][4],objV[6][5]],
            [objV[7][3],objV[7][4],objV[7][5]],
            [objV[8][3],objV[8][4],objV[8][5]]]
        let objV22 : [[SudokuCell]] = [
            [objV[6][6],objV[6][7],objV[6][8]],
            [objV[7][6],objV[7][7],objV[7][8]],
            [objV[8][6],objV[8][7],objV[8][8]]]
        cell3x3Candidate = [
            [Sudoku3x3Cells(objCell : objV00 as [[SudokuCell]]), Sudoku3x3Cells(objCell: objV01 as [[SudokuCell]]), Sudoku3x3Cells(objCell: objV02 as [[SudokuCell]])],
            [Sudoku3x3Cells(objCell: objV10 as [[SudokuCell]]), Sudoku3x3Cells(objCell: objV11 as [[SudokuCell]]), Sudoku3x3Cells(objCell: objV12 as [[SudokuCell]])],
            [Sudoku3x3Cells(objCell: objV20 as [[SudokuCell]]), Sudoku3x3Cells(objCell: objV21 as [[SudokuCell]]), Sudoku3x3Cells(objCell: objV22 as [[SudokuCell]])]
        ]
    }
    func getSudokuCells() -> [[SudokuCell]] {
        var obj3x3Cells00 : [[SudokuCell]] = cell3x3Candidate[0][0].getCells()
        var obj3x3Cells01 : [[SudokuCell]] = cell3x3Candidate[0][1].getCells()
        var obj3x3Cells02 : [[SudokuCell]] = cell3x3Candidate[0][2].getCells()
        var obj3x3Cells10 : [[SudokuCell]] = cell3x3Candidate[1][0].getCells()
        var obj3x3Cells11 : [[SudokuCell]] = cell3x3Candidate[1][1].getCells()
        var obj3x3Cells12 : [[SudokuCell]] = cell3x3Candidate[1][2].getCells()
        var obj3x3Cells20 : [[SudokuCell]] = cell3x3Candidate[2][0].getCells()
        var obj3x3Cells21 : [[SudokuCell]] = cell3x3Candidate[2][1].getCells()
        var obj3x3Cells22 : [[SudokuCell]] = cell3x3Candidate[2][2].getCells()
        return [
            [
                obj3x3Cells00[0][0], obj3x3Cells00[0][1], obj3x3Cells00[0][2],
                obj3x3Cells01[0][0], obj3x3Cells01[0][1], obj3x3Cells01[0][2],
                obj3x3Cells02[0][0], obj3x3Cells02[0][1], obj3x3Cells02[0][2]
            ],
            [
                obj3x3Cells00[1][0], obj3x3Cells00[1][1], obj3x3Cells00[1][2],
                obj3x3Cells01[1][0], obj3x3Cells01[1][1], obj3x3Cells01[1][2],
                obj3x3Cells02[1][0], obj3x3Cells02[1][1], obj3x3Cells02[1][2]
            ],
            [
                obj3x3Cells00[2][0], obj3x3Cells00[2][1], obj3x3Cells00[2][2],
                obj3x3Cells01[2][0], obj3x3Cells01[2][1], obj3x3Cells01[2][2],
                obj3x3Cells02[2][0], obj3x3Cells02[2][1], obj3x3Cells02[2][2]
            ],
            [
                obj3x3Cells10[0][0], obj3x3Cells10[0][1], obj3x3Cells10[0][2],
                obj3x3Cells11[0][0], obj3x3Cells11[0][1], obj3x3Cells11[0][2],
                obj3x3Cells12[0][0], obj3x3Cells12[0][1], obj3x3Cells12[0][2]
            ],
            [
                obj3x3Cells10[1][0], obj3x3Cells10[1][1], obj3x3Cells10[1][2],
                obj3x3Cells11[1][0], obj3x3Cells11[1][1], obj3x3Cells11[1][2],
                obj3x3Cells12[1][0], obj3x3Cells12[1][1], obj3x3Cells12[1][2]
            ],
            [
                obj3x3Cells10[2][0], obj3x3Cells10[2][1], obj3x3Cells10[2][2],
                obj3x3Cells11[2][0], obj3x3Cells11[2][1], obj3x3Cells11[2][2],
                obj3x3Cells12[2][0], obj3x3Cells12[2][1], obj3x3Cells12[2][2]
            ],
            [
                obj3x3Cells20[0][0], obj3x3Cells20[0][1], obj3x3Cells20[0][2],
                obj3x3Cells21[0][0], obj3x3Cells21[0][1], obj3x3Cells21[0][2],
                obj3x3Cells22[0][0], obj3x3Cells22[0][1], obj3x3Cells22[0][2]
            ],
            [
                obj3x3Cells20[1][0], obj3x3Cells20[1][1], obj3x3Cells20[1][2],
                obj3x3Cells21[1][0], obj3x3Cells21[1][1], obj3x3Cells21[1][2],
                obj3x3Cells22[1][0], obj3x3Cells22[1][1], obj3x3Cells22[1][2]
            ],
            [
                obj3x3Cells20[2][0], obj3x3Cells20[2][1], obj3x3Cells20[2][2],
                obj3x3Cells21[2][0], obj3x3Cells21[2][1], obj3x3Cells21[2][2],
                obj3x3Cells22[2][0], obj3x3Cells22[2][1], obj3x3Cells22[2][2]
            ]
        ]
    }
    func resultCells() -> [[String]] {

        var strV11 : [[String]] = cell3x3Candidate[0][0].resultCells()
        var strV12 : [[String]] = cell3x3Candidate[0][1].resultCells()
        var strV13 : [[String]] = cell3x3Candidate[0][2].resultCells()
        var strV21 : [[String]] = cell3x3Candidate[1][0].resultCells()
        var strV22 : [[String]] = cell3x3Candidate[1][1].resultCells()
        var strV23 : [[String]] = cell3x3Candidate[1][2].resultCells()
        var strV31 : [[String]] = cell3x3Candidate[2][0].resultCells()
        var strV32 : [[String]] = cell3x3Candidate[2][1].resultCells()
        var strV33 : [[String]] = cell3x3Candidate[2][2].resultCells()

        return
            [
                [
                    strV11[0][0], strV11[0][1], strV11[0][2],
                    strV12[0][0], strV12[0][1], strV12[0][2],
                    strV13[0][0], strV13[0][1], strV13[0][2]
                ], [
                    strV11[1][0], strV11[1][1], strV11[1][2],
                    strV12[1][0], strV12[1][1], strV12[1][2],
                    strV13[1][0], strV13[1][1], strV13[1][2]
                ], [
                    strV11[2][0], strV11[2][1], strV11[2][2],
                    strV12[2][0], strV12[2][1], strV12[2][2],
                    strV13[2][0], strV13[2][1], strV13[2][2]
                ], [
                    strV21[0][0], strV21[0][1], strV21[0][2],
                    strV22[0][0], strV22[0][1], strV22[0][2],
                    strV23[0][0], strV23[0][1], strV23[0][2]
                ], [
                    strV21[1][0], strV21[1][1], strV21[1][2],
                    strV22[1][0], strV22[1][1], strV22[1][2],
                    strV23[1][0], strV23[1][1], strV23[1][2]
                ], [
                    strV21[2][0], strV21[2][1], strV21[2][2],
                    strV22[2][0], strV22[2][1], strV22[2][2],
                    strV23[2][0], strV23[2][1], strV23[2][2]
                ], [
                    strV31[0][0], strV31[0][1], strV31[0][2],
                    strV32[0][0], strV32[0][1], strV32[0][2],
                    strV33[0][0], strV33[0][1], strV33[0][2]
                ], [
                    strV31[1][0], strV31[1][1], strV31[1][2],
                    strV32[1][0], strV32[1][1], strV32[1][2],
                    strV33[1][0], strV33[1][1], strV33[1][2]
                ], [
                    strV31[2][0], strV31[2][1], strV31[2][2],
                    strV32[2][0], strV32[2][1], strV32[2][2],
                    strV33[2][0], strV33[2][1], strV33[2][2]
                ]
        ]
    }

    func isSolved() -> Bool {
        var bl : Bool = true
        for (var i = 0; i < 3 ; i++) {
            for (var j = 0; j < 3 ; j++) {
                if (!cell3x3Candidate [i][j].isSolved()) {
                    bl = false
                    break
                }
            }
        }
        return bl
    }
}
