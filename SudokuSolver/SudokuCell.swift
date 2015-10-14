//
//  SudokuCell.swift
//  SudokuSolver
//
//  Created by Takayoshi Hongan on 5/17/15.
//  Copyright (c) 2015 Takayoshi Hongan. All rights reserved.
//
//  The MIT License (MIT)
//  https://opensource.org/licenses/MIT
//

import Cocoa

class SudokuCell {
    var strCandidate = [String]()
    init () {
        strCandidate = ["1","2","3","4","5","6","7","8","9"]
    }
    init (strV: String) {
        strCandidate = [strV]
    }
    func setSolvedValue (strValue: String) {
        strCandidate = [strValue]
    }
    func removeCandidate (strValue: String) -> Bool {
        var bl = false
        for ( var i : Int = 0; i < strCandidate.count; i++) {
            if (strCandidate[i] == strValue && strCandidate.count > 1) {
                strCandidate.removeAtIndex( i )
                bl = true
                break
            }
        }
//        println(strCandidate)
        return bl;
    }
    func getNumberOfCandidatesIfIncluded(strV : String) -> Int {
        var rt : Int = -1
        if isExist(strV) {
            rt = strCandidate.count
        }
        return rt
    }
    func getCandidatesValue() -> String {
        let str : String = strCandidate [0]
        if !isSolved() {
            removeCandidate (str)
        }
        return str
    }
    func resultValue(blDebug : Bool) -> String{
        if blDebug {
            print(strCandidate)
        }
        if strCandidate.count == 1 {
            return strCandidate [0]
        } else {
            return ""
        }
    }
    func resultValue() -> String{
        return resultValue(false)
    }
    /**
    存在するか
    @param strValue 確認値
    @return Bool 存在すればtrue
    */
    func isExist ( strValue : String) -> Bool {
        var bl = false
        for strCurrent in strCandidate {
            if (strCurrent == strValue) { // contain
                bl = true
                break
            }
        }
        return bl;
    }
    /**
    解決したか
    @return Bool 解決すればtrue
    */
    func isSolved() -> Bool {
        if strCandidate.count == 1 {
            return true
        } else {
            return false
        }
    }
}
