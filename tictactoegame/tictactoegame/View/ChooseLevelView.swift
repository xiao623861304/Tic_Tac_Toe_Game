//
//  ChooseLevelView.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/8.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

protocol chooseLevelDelegate{
    func chooseLevel(hardLevel:HardLevel)
}
class ChooseLevelView: UIView {
     var viewArr = [UILabel]()
     var delegate: chooseLevelDelegate?
     init(frame:CGRect , arr:[String]) {
        for i in 0..<arr.count{
            let view = UILabel(frame: CGRect(x: 0, y: i*41+1, width: Int(SCREEN_WIDTH-30), height: 40))
            view.text = arr[i]
            view.textColor = .black
            view.textAlignment = .center
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 2
            view.layer.cornerRadius = 20
            view.isHidden = true
            viewArr.append(view)
        }
        super.init(frame: frame)
        
        for j in 0..<arr.count {
            let label:UILabel = viewArr[j]
            let tap = UITapGestureRecognizer(target: self, action: #selector(toTap(_:)))
            label.tag = 1000+j
            label.addGestureRecognizer(tap)
            label.isUserInteractionEnabled = true
            self.addSubview(label)
        }
        self.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   @objc func toTap(_ sender:UITapGestureRecognizer){
    if sender.view!.tag == 1000 {
            delegate?.chooseLevel(hardLevel: HardLevel.easy)
        }else{
            delegate?.chooseLevel(hardLevel: HardLevel.impossibleWin)

        }
    }
   
}
