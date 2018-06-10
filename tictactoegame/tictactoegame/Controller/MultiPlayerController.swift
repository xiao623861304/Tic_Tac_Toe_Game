//
//  multiPlayerController.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit

class MultiPlayerController: UIViewController,chooseCheckerboardDelegate {
    var gameViewframe:CGRect!
    var model:Model!
    var gameOver:Bool!
    var isCross:Bool!
    var chessboardSpecification:Int!
    var chooseCheckerboard:ChooseCheckerboard!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "MultiPlayer Type"
        view.backgroundColor = .white
        chessboardSpecification = 3
        setUpGameView()
        setTitleView()
        initializeModel()
        gameOver = false
        isCross = true
        
    }
    func setUpGameView(){
        gameViewframe = CGRect(x: 10, y: SCREEN_HEIGHT/2-(SCREEN_WIDTH-20)/2, width: SCREEN_WIDTH-20, height: SCREEN_WIDTH-20)
//        let lineCount:Int = chessboardSpecification-1
        for i in 1..<chessboardSpecification{
            let verticalView = GameView(screenFrame: gameViewframe, lineType: LineType.vertical , lineCount: chessboardSpecification , lineNumber:i )
            verticalView.tag  = 3000
            let horizontalView = GameView(screenFrame:gameViewframe, lineType: LineType.horizontal , lineCount: chessboardSpecification , lineNumber:i )
            horizontalView.tag = 3000
            view.addSubview(verticalView)
            view.addSubview(horizontalView)
        }
    }
    func setTitleView() {
        chooseCheckerboard = ChooseCheckerboard(frame: CGRect(x: 7.5, y: HeightNavBar+12.5, width: SCREEN_WIDTH-15, height: 45),
                                                arr: [" 3 X 3 "," 4 X 4 "," 5 X 5 "] )
        chooseCheckerboard.delegate = self
        view.addSubview(chooseCheckerboard)
        let titleLabel = UILabel(frame: CGRect(x: SCREEN_WIDTH/2-120, y: HeightNavBar+7.5, width: 240, height: 15))
        titleLabel.textAlignment = .center
        titleLabel.text = "CHOOSE Checkerboard TYPE"
        titleLabel.layer.backgroundColor = UIColor.white.cgColor
        view.addSubview(titleLabel)
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
        model.initializeDic(count: (chessboardSpecification*chessboardSpecification))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location:CGPoint!
        for touch in touches {
            location = touch.location(in: view)
        }
        let position = currentPoint(location: location)
        if position == -1 || gameOver {return}
        if !gameOver {
           addPiece(position: position, iscross: isCross)
        }
    }
    func currentPoint(location:CGPoint)->Int{
        let x:Int = Int((location.x-10)/((SCREEN_WIDTH-20)/CGFloat(chessboardSpecification)))
        let y:Int = Int((location.y-(SCREEN_HEIGHT/2-(SCREEN_WIDTH-20)/2))/((SCREEN_WIDTH-20)/CGFloat(chessboardSpecification)))
        let isInnerPointOfGameView :Bool! = (location.x>=gameViewframe.minX && location.x<=gameViewframe.maxX && location.y >= gameViewframe.minY && location.y <= gameViewframe.maxY) ? true : false
        return (x+chessboardSpecification*y >= 0 && x+chessboardSpecification*y < (chessboardSpecification*chessboardSpecification) ) && isInnerPointOfGameView && !model.positionHasViewDic[x+chessboardSpecification*y]! ? (x+chessboardSpecification*y) : -1
    }
    func addPiece(position: Int , iscross:Bool){
        if !model.positionHasViewDic[position]!{
        if isCross {
            addCrossView(position: position)
            model.positionHasViewDic[position] = true
            model.allPiecesDic[position] = "cross"
            isCross = false
        }else{
            addCircleView(position: position)
            model.positionHasViewDic[position] = true
            model.allPiecesDic[position] = "circle"
            isCross = true
        }
            gameOver=model.gameStatus(n: chessboardSpecification)
        if gameOver {
            showWinerView(whoWin: model.whoWins)
        }
        }
    }
    func showWinerView(whoWin:String){
        var showWinMessage = String()
        if whoWin == "cross" {
            showWinMessage = "CROSS WIN !"
        }else if whoWin == "circle"{
            showWinMessage = "CRICLE WIN !"
        }else{
            showWinMessage = whoWin
        }
        let finishAlert = UIAlertController(title: "Message", message: showWinMessage, preferredStyle: UIAlertControllerStyle.alert)
        finishAlert.addAction(UIAlertAction(title: "Reset Game", style: UIAlertActionStyle.destructive, handler: { (action) in
            self.resetGame();
        }))
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
        isCross = true
    }
    func addCrossView(position:Int){
        let x = CGFloat(position%chessboardSpecification)*(gameViewframe.width/CGFloat(chessboardSpecification))+gameViewframe.minX
        let y = CGFloat(position/chessboardSpecification)*(gameViewframe.height/CGFloat(chessboardSpecification))+gameViewframe.minY
        let length = gameViewframe.width/CGFloat(chessboardSpecification)-10
        let crossView = CrossView(frame: CGRect(x: x, y: y, width: length, height: length), length: length)
        crossView.tag = 9
        view.addSubview(crossView)
    }
    func addCircleView(position:Int){
        let x = CGFloat(position%chessboardSpecification)*(gameViewframe.width/CGFloat(chessboardSpecification))+gameViewframe.minX
        let y = CGFloat(position/chessboardSpecification)*(gameViewframe.height/CGFloat(chessboardSpecification))+gameViewframe.minY
        let length = gameViewframe.width/CGFloat(chessboardSpecification)-10
        let circleView = CircleView(frame: CGRect(x: x, y: y, width: length, height: length), length: length)
        circleView.tag = 9
        view.addSubview(circleView)
    }
    
    func chooseCheckerboardType(type:Int) {
        chessboardSpecification = type
        for view in view.subviews {
            if view.tag == 3000 {
                view.removeFromSuperview()
            }
        }
        setUpGameView()
        resetGame()
    }
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
    @objc func toReStartBtn(){
        resetGame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
