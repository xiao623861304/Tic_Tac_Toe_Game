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
    var model:Model!
    var gameOver:Bool!
    var isImpossibleWin:Bool!
    var chooseLevelView:ChooseLevelView!
    var isShowLevelView:Bool!
    let cornerArr:[Int]! = [0,2,6,8]
    let edgeArr:[Int]! = [1,3,5,7]
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
        view.addSubview(reStartBtn)
        reStartBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH-30)
            make.height.equalTo(40)
        }
    }
    func initializeModel(){
        model = Model()
        model.initializeDic(count: 9)
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
        return (x+3*y >= 0 && x+3*y <= 8 ) && isInnerPointOfGameView && !model.positionHasViewDic[x+3*y]! ? (x+3*y) : -1
    }
    func addPersonEvent(position:Int){
        addCrossView(position: position)
        model.crossArray.append(position)
        model.positionHasViewDic[position] = true
        model.allPiecesDic[position] = "cross"
        gameOver=model.gameStatus(n: 3)
        if gameOver {
            showWinerView(whoWin: model.whoWins)
        }
    }
    func addRobotEvent(){
        var randomPos = Int()
        while true {
            randomPos = Int(arc4random()%9)
            if !model.positionHasViewDic[randomPos]!{
               addRobotCircleView(position: randomPos)
                break
            }
        }
        gameOver=model.gameStatus(n: 3)
        if gameOver {
            showWinerView(whoWin: model.whoWins)
        }
    }
    func addHardRobotEvent(){
        let croArr:[Int] = model.crossArray
        let endpos:Int = croArr.last!
        let cirArr:[Int] = model.circleArray
        if croArr.count==1 && endpos == 4{
            addRobotCircleView(position: 0)
        }else if croArr.count == 1 && endpos != 4 {
            addRobotCircleView(position: 4)
        }else{
            var nextPosition : Int = -1
            for i in cirArr {
                let robwinarr:[[Int]] = model.possibilityWinArray(position: i)
                for rarr in robwinarr {
                    for j in 0..<rarr.count {
                        if cirArr.contains(rarr[j]) && (!model.positionHasViewDic[rarr[rarr.count-1-j]]!){
                            nextPosition = rarr[rarr.count-1-j]
                            addRobotCircleView(position: nextPosition)
                            gameOver=model.gameStatus(n: 3)
                            if gameOver {
                                showWinerView(whoWin: model.whoWins)
                            }
                            return
                        }
                    }
                }
            }
            for k in croArr {
                let poswinarr:[[Int]] = model.possibilityWinArray(position: k)
                for  parr in poswinarr {
                    for m in 0..<parr.count{
                        if croArr.contains(parr[m]) && (!cirArr.contains(parr[parr.count-1-m])){
                            nextPosition = parr[parr.count-1-m]
                        }
                    }
                }
            }
//            print(nextPosition)
            if nextPosition == -1 {
                if croArr.count == 2{
                  if cornerArr.contains(croArr.first!) && cornerArr.contains(croArr.last!){
                        let randomPos = Int(arc4random()%UInt32(cornerArr.count))
                        while true {
                            if !model.positionHasViewDic[edgeArr[randomPos]]!{
                                addRobotCircleView(position: edgeArr[randomPos])
                                break
                            }
                        }
                    }else{
                        nextPosition = hasPossibleWin(firstArr: model.possibilityWinArray(position: croArr.first!), secondArr: model.possibilityWinArray(position: croArr.last!))
                        addRobotCircleView(position: nextPosition)
                    }
                }
                else{
                    addRobotEvent()
                }
            }else{
                addRobotCircleView(position: nextPosition)
            }
        }
        gameOver=model.gameStatus(n:3)
        if gameOver {
            showWinerView(whoWin: model.whoWins)
        }
    }
    func hasPossibleWin(firstArr:[[Int]] , secondArr:[[Int]])->Int{
        var set1:Set<Int> = includeSamePoint(array: firstArr)
        let set2:Set<Int> = includeSamePoint(array: secondArr)
        set1 = set1.intersection(set2)
        var nextpositon:Int = -1
//        print(set1)
        for index in set1 {
            if !model.positionHasViewDic[index]! && (!edgeArr.contains(index)){
                nextpositon = index
                break
            }
        }
        if nextpositon == -1 {
            let randomPos = Int(arc4random()%UInt32(cornerArr.count))
            while true {
                if !model.positionHasViewDic[cornerArr[randomPos]]!{
                    nextpositon = cornerArr[randomPos]
                    break
                }
            }
        }
        return nextpositon
    }
    func includeSamePoint(array:[[Int]]) -> Set<Int> {
        var set : Set<Int> = []
        for arr in array{
            for element in arr {
                set.insert(element)
            }
        }
        return set
    }
    func addRobotCircleView(position:Int){
        addCircleView(position: position)
        model.circleArray.append(position)
        model.positionHasViewDic[position] = true
        model.allPiecesDic[position] = "circle"
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
        for values in model.positionHasViewDic.values {
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
        reStartBtn.isEnabled = false
    }
    @objc func toReStartBtn(){
        resetGame()
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
    lazy var reStartBtn:UIButton = {
        let reStartBtn = UIButton()
        reStartBtn.setTitle("RESTART", for: .normal)
        reStartBtn.setTitleColor(.black, for: .normal)
        reStartBtn.layer.cornerRadius = 20
        reStartBtn.layer.borderColor = UIColor.black.cgColor
        reStartBtn.layer.borderWidth = 2
        reStartBtn.addTarget(self, action: #selector(toReStartBtn), for: .touchUpInside)
        return reStartBtn
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
        reStartBtn.isEnabled = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
