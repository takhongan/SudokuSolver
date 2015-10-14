//
//  Sudoku3x3Cells.swift
//  SudokuSolver
//
//  Created by Takayoshi Hongan on 5/17/15.
//  Copyright (c) 2015 Takayoshi Hongan. All rights reserved.
//

import Cocoa

class Sudoku3x3Cells {
    var cellCandidate = [[SudokuCell]]()
    init (strV : [[String]] ) {
        cellCandidate = [
            [SudokuCell() , SudokuCell() ,SudokuCell() ],
            [SudokuCell() , SudokuCell() ,SudokuCell() ],
            [SudokuCell() , SudokuCell() ,SudokuCell() ]]
        for (var i = 0  ; i < 3 ; i++) {
            for (var j = 0  ; j < 3 ; j++) {
                if (strV[i][j] as String).characters.count > 0 {
                    cellCandidate[i][j] = SudokuCell(strV : strV[i][j] as String) as SudokuCell
                }
            }
        }
    }
    init (objCell : [[SudokuCell]] ) {
        cellCandidate = [
            [objCell[0][0] , objCell[0][1] ,objCell[0][2] ],
            [objCell[1][0] , objCell[1][1] ,objCell[1][2] ],
            [objCell[2][0] , objCell[2][1] ,objCell[2][2] ]]
    }

    func setInitValue(intCol : Int, intRow : Int, strValue: String) {
        cellCandidate [intCol][intRow].setSolvedValue (strValue)
    }
    func removeColCandidate(intL : Int, strValue: String) {
        //var bl : Bool
         cellCandidate [intL][0].removeCandidate (strValue)
         cellCandidate [intL][1].removeCandidate (strValue)
         cellCandidate [intL][2].removeCandidate (strValue)
    }
    func removeRowCandidate(intL : Int, strValue: String) {
        //var bl : Bool
         cellCandidate [0][intL].removeCandidate (strValue)
         cellCandidate [1][intL].removeCandidate (strValue)
         cellCandidate [2][intL].removeCandidate (strValue)
    }
    func getColCells(intL : Int) -> [SudokuCell]{
        return [cellCandidate [0][intL], cellCandidate [1][intL], cellCandidate [2][intL]]
    }
    func getRowCells(intL : Int) -> [SudokuCell]{
        return [cellCandidate [intL][0], cellCandidate [intL][1], cellCandidate [intL][2]]
    }
    func getCells() -> [[SudokuCell]]{
        return cellCandidate
    }
    func getCell(intR : Int, intC : Int) -> SudokuCell{
        return cellCandidate [intR][intC]
    }

    func removeOverlappingCandidate () {
        for (var i = 0 ; i < 3; i++) {
            for (var j = 0 ; j < 3; j++) {
                if cellCandidate[i][j].isSolved() {
                    cellCandidate[0][0].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[0][1].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[0][2].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[1][0].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[1][1].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[1][2].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[2][0].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[2][1].removeCandidate(cellCandidate[i][j].resultValue(false))
                    cellCandidate[2][2].removeCandidate(cellCandidate[i][j].resultValue(false))
                }
            }
        }
    }
    
    func resultCells() -> [[String]] {
        return [
            [cellCandidate[0][0].resultValue(), cellCandidate[0][1].resultValue(), cellCandidate[0][2].resultValue()],
            [cellCandidate[1][0].resultValue(), cellCandidate[1][1].resultValue(), cellCandidate[1][2].resultValue()],
            [cellCandidate[2][0].resultValue(), cellCandidate[2][1].resultValue(), cellCandidate[2][2].resultValue()]
        ]
    }
    func isSolved() -> Bool {
        var bl : Bool = true
        for (var i = 0; i < 3 ; i++) {
            for (var j = 0; j < 3 ; j++) {
                if (!cellCandidate [i][j].isSolved()) {
                    bl = false
                    break
                }
            }
        }
        return bl
    }
}
