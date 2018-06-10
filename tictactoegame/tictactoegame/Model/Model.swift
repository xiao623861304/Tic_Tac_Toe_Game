//
//  LogicModel.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

class Model: NSObject {
    var circleArray = [Int]()
    var crossArray = [Int]()
    var positionHasViewDic = [Int:Bool]()
    var allPiecesDic = [Int:String]()
    var whoWins = String()
    func initializeDic(count:Int){
        for i in 0..<count {
            positionHasViewDic[i] = false
        }
        for i in 0..<count{
            allPiecesDic[i] = "empty"
        }
    }
    
    func gameStatus(n:Int)->Bool{
//        print(allPiecesDic)
        for i in 0..<n{
            var lineCount:Int = 0
            var columnCount:Int = 0
            for j in 0..<n {
                let line:String = allPiecesDic[i*n]!
                if allPiecesDic[i*n+j]==line && (allPiecesDic[n*i+j] != "empty"){
                    lineCount += 1
                }
                let column:String = allPiecesDic[i]!
                if allPiecesDic[i+j*n]==column && (allPiecesDic[i+j*n] != "empty"){
                    columnCount += 1
                }
            }
            if lineCount == n || columnCount == n{
                whoWins = (lineCount==n ? allPiecesDic[i*n]! : allPiecesDic[i]!)
                return true
            }
//            if allPiecesDic[i*3]==allPiecesDic[3*i+1] && (allPiecesDic[3*i+1]==allPiecesDic[3*i+2]) && (allPiecesDic[3*i+2] != "empty"){
//                whoWins = allPiecesDic[i*3]!
////                print(1)
//                return true
//            }else if allPiecesDic[i]==allPiecesDic[i+3] && (allPiecesDic[i+3]==allPiecesDic[i+6]) && (allPiecesDic[i+6] != "empty"){
//                whoWins = allPiecesDic[i]!
////                print(2)
//                return true
//            }
        }
        var diagonal1:Int = 0
        var diagonal2:Int = 0
        let diagonalValue1:String = allPiecesDic[0]!
        let diagonalValue2:String = allPiecesDic[n-1]!
        for m in stride(from: 0, to: (n*n), by: (n+1)) {
            if allPiecesDic[m] == diagonalValue1 && (diagonalValue1 != "empty"){
                diagonal1 += 1
            }
        }
        for k in stride(from: (n-1), through: (n*(n-1)), by: (n-1)){
            if allPiecesDic[k] == diagonalValue2 && (diagonalValue2 != "empty"){
                diagonal2 += 1
            }
        }
        if diagonal1 == n || diagonal2 == n {
            whoWins = (diagonal1 == n ? diagonalValue1 : diagonalValue2)
            return true
        }
//        if ((allPiecesDic[0]==allPiecesDic[4] && (allPiecesDic[4]==allPiecesDic[8]))
//            || (allPiecesDic[2]==allPiecesDic[4] && (allPiecesDic[4]==allPiecesDic[6]))) && (allPiecesDic[4] != "empty"){
//            whoWins = allPiecesDic[4]!
////            print(3)
//            return true
//        }
        var piecesCount:Int = 0
        for value in positionHasViewDic.values {
            if value {
                piecesCount += 1
            }
        }
//        print(positionHasViewDic)
        if piecesCount == (n*n){
            whoWins = "Draw  !"
            return true;
        }
        return false
    }
    func possibilityWinArray(position:Int) -> [[Int]]{
        switch position {
        case 0:
            return [[1,2],[3,6],[4,8]]
        case 1:
            return [[0,2],[4,7]]
        case 2:
            return [[0,1],[5,8],[4,6]]
        case 3:
            return [[0,6],[4,5]]
        case 4:
            return [[0,8],[1,7],[2,6],[3,5]]
        case 5:
            return [[2,8],[3,4]]
        case 6:
            return [[0,3],[7,8],[2,4]]
        case 7:
            return [[1,4],[6,8]]
        case 8:
            return [[2,5],[6,7],[0,4]]
        default:
            return []
        }
    }
    
    
}
