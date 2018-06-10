//
//  CircleView.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

class CircleView: UIView {

    init(frame:CGRect , length : CGFloat)  {
        let line = UIView(frame: CGRect(x: 5+length/2, y: 5+length/2, width: 0, height: 0))
        line.layer.borderColor = UIColor.black.cgColor
        line.layer.borderWidth = 10
        super.init(frame: frame)
        self.addSubview(line)
        UIView.animate(withDuration: 0.2, animations: {
            line.frame = CGRect(x: 5, y: 5 ,width:  length,height: length)
            line.layer.cornerRadius = length/2
        }) { (complete) in
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
