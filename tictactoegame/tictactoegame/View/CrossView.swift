//
//  CrossView.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

class CrossView: UIView {

    init(frame:CGRect , length : CGFloat) {
        let line1 = UIView(frame: CGRect(x: length/2-5, y: 0, width: 10, height: 0))
        line1.backgroundColor = .red
        let line2 = UIView(frame: CGRect(x: 0, y: length/2-5, width: 0, height: 10))
        line2.backgroundColor = .red
        super.init(frame: frame)
        self.addSubview(line1)
        self.addSubview(line2)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        UIView.animate(withDuration: 0.2, animations: {
            line1.frame.size = CGSize(width: 10, height: length)
        }) { (complete) in
            UIView.animate(withDuration: 0.2, animations: {
                line2.frame.size = CGSize(width: length, height: 10 )
            })
        }
       
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
