//
//  Header.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_BOUNDS = UIScreen.main.bounds

let ISIPHONEX:Bool = (SCREEN_HEIGHT == 812.0) ? true : false

let HeightNavBar:CGFloat = ISIPHONEX ? 88.0 : 64.0 

enum HardLevel:Int{
    case easy = 0
    case impossibleWin = 1
}
extension UIDevice {
    public class func isIphoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
}

import SnapKit


