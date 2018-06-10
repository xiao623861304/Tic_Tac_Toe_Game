//
//  GameView.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

enum LineType:Int{
    case vertical = 0
//    case vertical = 1
    case horizontal = 1
//    case horizontal2 = 3
}

class GameView: UIView {
    init(screenFrame: CGRect , lineType:LineType , lineCount:Int , lineNumber:Int) {
        var lineFrame:CGRect!
        let gameSpaceWidth = screenFrame.width
        let gameSpaceHeight = gameSpaceWidth
        
        if lineType==LineType.vertical {
            lineFrame = CGRect(x:screenFrame.minX+CGFloat(lineNumber*Int(gameSpaceWidth)/lineCount), y: screenFrame.minY, width: 2, height: gameSpaceHeight)
        }else{
            lineFrame = CGRect(x: screenFrame.minX, y:screenFrame.minY+CGFloat(lineNumber*Int(gameSpaceHeight)/lineCount), width: gameSpaceWidth, height: 2)
        }
//        lineFrame
//        switch lineType {
//        case LineType.vertical1:
//            lineFrame =
//        case LineType.vertical2:
//            lineFrame = CGRect(x:screenFrame.minX+gameSpaceWidth/3*2, y: screenFrame.minY, width: 2, height: gameSpaceHeight)
//        case LineType.horizontal1:
//            lineFrame = CGRect(x: screenFrame.minX, y:screenFrame.minY+gameSpaceHeight/3, width: gameSpaceWidth, height: 2)
//        case LineType.horizontal2:
//            lineFrame = CGRect(x: screenFrame.minX, y:screenFrame.minY+gameSpaceHeight/3*2, width: gameSpaceWidth, height: 2)
//        }
        super.init(frame: lineFrame)
        self.backgroundColor = .black
    }
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
}
