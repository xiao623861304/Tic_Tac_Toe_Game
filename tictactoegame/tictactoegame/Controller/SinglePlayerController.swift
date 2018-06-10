//
//  singlePlayerController.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

class SinglePlayerController: UIViewController,chooseLevelDelegate {
    var gameViewframe:CGRect!
    var logicModel:Model!
    var gameOver:Bool!
    var isImpossibleWin:Bool!
    var chooseLevelView:ChooseLevelView!
    var isShowLevelView:Bool!
    let cornerArr:[Int]! = [0,2,6,8]
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "singlePlayer Type"
        view.backgroundColor = .white
        isShowLevelView = false
        gameOver = false
        isImpossibleWin = false
        setUpGameView()
        initializeModel()
        
    }
    func setUpGameView(){
        gameViewframe = CGRect(x: 10, y: SCREEN_HEIGHT/2-(SCREEN_WIDTH-20)/2, width: SCREEN_WIDTH-20, height: SCREEN_WIDTH-20)
        for i in 1...2{
            let verticalView = GameView(screenFrame: gameViewframe, lineType: LineType.vertical , lineCount: 3 , lineNumber:i )
            let horizontalView = GameView(screenFrame:gameViewframe, lineType: LineType.horizontal , lineCount: 3 , lineNumber:i )
            view.addSubview(verticalView)
            view.addSubview(horizontalView)
        }
        view.addSubview(showLevelBtn)
        showLevelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(HeightNavBar+10)
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH-30)
            make.height.equalTo(40)
        }
        chooseLevelView = ChooseLevelView(frame: CGRect(x: 15, y: HeightNavBar+50, width: SCREEN_WIDTH-30, height: 0),arr: ["EASY","IMPOSSIBLEWIN"])
        chooseLevelView.delegate = self
        view.addSubview(chooseLevelView)
    }
    func initializeModel(){
        logicModel = Model()
        logicModel.initializeDic(count: 9)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location:CGPoint!
        for touch in touches {
            location = touch.location(in: view)
        }
        if !isShowLevelView {
            let position = currentPoint(location: location)
            if position == -1 || gameOver {return}
            addPersonEvent(position: position)
            if !gameOver{
                if isImpossibleWin{
                    addHardRobotEvent()
                }else{
                    addRobotEvent()
                }
            }
        }
        
    }
    func currentPoint(location:CGPoint)->Int{
        let x:Int = Int((location.x-10)/((SCREEN_WIDTH-20)/3))
        let y:Int = Int((location.y-(SCREEN_HEIGHT/2-(SCREEN_WIDTH-20)/2))/((SCREEN_WIDTH-20)/3))
        let isInnerPointOfGameView :Bool! = (location.x>=gameViewframe.minX && location.x<=gameViewframe.maxX && location.y >= gameViewframe.minY && location.y <= gameViewframe.maxY) ? true : false
        return (x+3*y >= 0 && x+3*y <= 8 ) && isInnerPointOfGameView && !logicModel.positionHasViewDic[x+3*y]! ? (x+3*y) : -1
    }
    func addPersonEvent(position:Int){
        addCrossView(position: position)
        logicModel.crossArray.append(position)
        logicModel.positionHasViewDic[position] = true
        logicModel.allPiecesDic[position] = "cross"
        gameOver=logicModel.gameStatus(n: 3)
        if gameOver {
            showWinerView(whoWin: logicModel.whoWins)
        }
    }
    func addRobotEvent(){
        var randomPos = Int()
        while true {
            randomPos = Int(arc4random()%9)
            if !logicModel.positionHasViewDic[randomPos]!{
               addRobotCircleView(position: randomPos)
                break
            }
        }
        gameOver=logicModel.gameStatus(n: 3)
        if gameOver {
            showWinerView(whoWin: logicModel.whoWins)
        }
    }
    func addHardRobotEvent(){
        let croArr:[Int] = logicModel.crossArray
        let endpos:Int = croArr.last!
        let cirArr:[Int] = logicModel.circleArray
        if croArr.count==1 && endpos == 4{
            addRobotCircleView(position: 0)
        }else if croArr.count == 1 && endpos != 4 {
            addRobotCircleView(position: 4)
        }else{
            var nextPosition : Int = -1
            for i in cirArr {
                let robwinarr:[[Int]] = logicModel.possibilityWinArray(position: i)
                for rarr in robwinarr {
                    for j in 0..<rarr.count {
                        if cirArr.contains(rarr[j]) && (!logicModel.positionHasViewDic[rarr[rarr.count-1-j]]!){
                            nextPosition = rarr[rarr.count-1-j]
                            addRobotCircleView(position: nextPosition)
                            gameOver=logicModel.gameStatus(n: 3)
                            if gameOver {
                                showWinerView(whoWin: logicModel.whoWins)
                            }
                            return
                        }
                    }
                }
            }
            for k in croArr {
                let poswinarr:[[Int]] = logicModel.possibilityWinArray(position: k)
                for  parr in poswinarr {
                    for m in 0..<parr.count{
                        if croArr.contains(parr[m]) && (!cirArr.contains(parr[parr.count-1-m])){
                            nextPosition = parr[parr.count-1-m]
                        }
                    }
                }
            }
            print(nextPosition)
            if nextPosition == -1 {
                if croArr.first != 0 && croArr.count==2 && (!cornerArr.contains(croArr.first!)){
                    addRobotCircleView(position: croArr.first!-1)
                }else if croArr.first == 0 && croArr.count == 2 {
                    if (croArr.last!-1) != 4{
                        addRobotCircleView(position: croArr.last!-1)
                    }else{
                        addRobotCircleView(position: 2)
                    }
                }else if croArr.first != 0 && croArr.count == 2 && cornerArr.contains(croArr.first!){
                    
                }else{
                    addRobotEvent()
                }
            }else{
                addRobotCircleView(position: nextPosition)
            }
        }
        gameOver=logicModel.gameStatus(n:3)
        if gameOver {
            showWinerView(whoWin: logicModel.whoWins)
        }
    }
    func addRobotCircleView(position:Int){
        addCircleView(position: position)
        logicModel.circleArray.append(position)
        logicModel.positionHasViewDic[position] = true
        logicModel.allPiecesDic[position] = "circle"
    }
    func showWinerView(whoWin:String){
        var showWinMessage = String()
        if whoWin == "cross" {
            showWinMessage = "YOU WIN !"
        }else if whoWin == "circle"{
            showWinMessage = "ROBOT WIN !"
        }else{
            showWinMessage = whoWin
        }
        let finishAlert = UIAlertController(title: "Message", message: showWinMessage, preferredStyle: UIAlertControllerStyle.alert)
        finishAlert.addAction(UIAlertAction(title: "Reset Game", style: UIAlertActionStyle.destructive, handler: { (action) in
            self.resetGame();
        }))
//        finishAlert.addAction(UIAlertAction(title: "See Checkerboard", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(finishAlert, animated: true, completion: nil)
    }
    func resetGame(){
        for view in view.subviews {
            if view.tag == 9 {
                view.removeFromSuperview()
            }
        }
        initializeModel()
        gameOver = false
    }
    func addCrossView(position:Int){
        let x = CGFloat(position%3)*(gameViewframe.width/3)+gameViewframe.minX
        let y = CGFloat(position/3)*(gameViewframe.height/3)+gameViewframe.minY
        let length = gameViewframe.width/3-10
        let crossView = CrossView(frame: CGRect(x: x, y: y, width: length, height: length), length: length)
        crossView.tag = 9
        view.addSubview(crossView)
    }
    func addCircleView(position:Int){
        let x = CGFloat(position%3)*(gameViewframe.width/3)+gameViewframe.minX
        let y = CGFloat(position/3)*(gameViewframe.height/3)+gameViewframe.minY
        let length = gameViewframe.width/3-10
        let circleView = CircleView(frame: CGRect(x: x, y: y, width: length, height: length), length: length)
        circleView.tag = 9
        view.addSubview(circleView)
    }
    @objc func toPopView() {
        var beginned:Bool! = false
        for values in logicModel.positionHasViewDic.values {
            if values {
                beginned = values
                break
            }
        }
        if beginned {
            chooseLevelView.removeFromSuperview()
            chooseLevelView = ChooseLevelView(frame: CGRect(x: 15, y: HeightNavBar+50, width: SCREEN_WIDTH-30, height: 0),arr: ["EASY","IMPOSSIBLEWIN"])
            chooseLevelView.delegate = self
            view.addSubview(chooseLevelView)
        }
        UIView.animate(withDuration: 0.5, animations: {
            
            for label in self.chooseLevelView.viewArr {
                label.isHidden = false
            }
        }) { (complete) in
            self.chooseLevelView.frame = CGRect(x: 15, y: HeightNavBar+50, width: SCREEN_WIDTH-30, height: 80)
        }
        isShowLevelView = true
    }
    lazy var showLevelBtn:UIButton={
        let showLevelBtn  = UIButton()
        showLevelBtn.setTitle("EASY", for: .normal)
        showLevelBtn.setTitleColor(.black, for: .normal)
        showLevelBtn.layer.borderWidth = 2
        showLevelBtn.layer.borderColor = UIColor.black.cgColor
        showLevelBtn.layer.cornerRadius = 20
        showLevelBtn.addTarget(self, action: #selector(toPopView), for: .touchUpInside)
        return showLevelBtn
    }()
    func chooseLevel(hardLevel: HardLevel) {
        if hardLevel == HardLevel.easy {
            showLevelBtn.setTitle("EASY", for: .normal)
            isImpossibleWin = false
        }else{
            showLevelBtn.setTitle("IMPOSSIBLEWIN", for: .normal)
            isImpossibleWin = true
        }
        UIView.animate(withDuration: 0.5, animations: {
            
            for label in self.chooseLevelView.viewArr {
                label.isHidden = true
            }
        }) { (complete) in
            self.chooseLevelView.frame = CGRect(x: 15, y: HeightNavBar+50, width: SCREEN_WIDTH-30, height: 0)
        }
        isShowLevelView = false
        resetGame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
