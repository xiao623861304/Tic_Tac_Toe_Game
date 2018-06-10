//
//  ChooseCheckerboard.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/8.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

protocol chooseCheckerboardDelegate:NSObjectProtocol {
    func chooseCheckerboardType(type:Int)
}
class ChooseCheckerboard: UIView {
    var labelArr = [UILabel]()
    weak var delegate:chooseCheckerboardDelegate?
    init(frame: CGRect , arr: [String]) {
        let space:CGFloat = (frame.width-80*3)/6
        for i in 0..<arr.count {
            let view = UILabel(frame: CGRect(x: space+(80+space*2)*CGFloat(i), y: frame.minX+7.5, width: 80, height: 20))
            view.textAlignment = .center
            view.text = arr[i]
            view.layer.borderWidth = 2
            if i == 0{
                view.layer.backgroundColor = UIColor.red.cgColor
                view.layer.borderColor = UIColor.red.cgColor
                view.textColor = .white
            }else{
                view.layer.backgroundColor = UIColor.white.cgColor
                view.layer.borderColor = UIColor.black.cgColor
                view.textColor = .black
            }
            view.layer.cornerRadius = 10
            labelArr.append(view)
        }
        super.init(frame: frame)
        for j in 0..<arr.count {
            let lable:UILabel = labelArr[j]
            lable.tag = 2000+j
            lable.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(toTap(_:)))
            lable.addGestureRecognizer(tap)
            self.addSubview(lable)
        }
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func toTap(_ sender : UITapGestureRecognizer){
        let type : Int = (sender.view?.tag)!-2000
        let label:UILabel = labelArr[type]
        for view in labelArr {
            if  view == label{
                view.layer.borderColor = UIColor.red.cgColor
                view.layer.backgroundColor = UIColor.red.cgColor
                view.textColor = .white
            }else{
                view.layer.borderColor = UIColor.black.cgColor
                view.layer.backgroundColor = UIColor.white.cgColor
                view.textColor = .black
            }
        }
        delegate?.chooseCheckerboardType(type: type+3)
    }
}
