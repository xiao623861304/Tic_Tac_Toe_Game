//
//  setUpGameController.swift
//  tic tac toe game
//
//  Created by yan feng on 2018/6/3.
//  Copyright © 2018年 Yan feng. All rights reserved.
//

import UIKit
class SetUpGameController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Game Type"
        let item = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        view.backgroundColor = .white
        view.addSubview(singlePlayer)
        view.addSubview(multiPlayer)
        setUpUI()
    }
    func setUpUI(){
        singlePlayer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-35)
            make.width.equalTo(SCREEN_WIDTH-30)
            make.height.equalTo(40)
        }
        multiPlayer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(35)
            make.width.height.equalTo(singlePlayer)
        }
    }
   @objc func singlePlayerButton() {
        let vc = SinglePlayerController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
   @objc func multiPlayerButton() {
        let vc = MultiPlayerController()
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var singlePlayer:UIButton={
        let singlePlayer = UIButton()
        singlePlayer.setTitle("singlePlayer", for: .normal)
        singlePlayer.setTitleColor(.black, for: .normal)
        singlePlayer.backgroundColor = .white
        singlePlayer.addTarget(self, action: #selector(singlePlayerButton), for: .touchUpInside)
        singlePlayer.layer.cornerRadius = 20
        singlePlayer.layer.borderColor = UIColor.black.cgColor
        singlePlayer.layer.borderWidth = 2
        return singlePlayer
    }()
    lazy var multiPlayer:UIButton={
        let multiPlayer = UIButton()
        multiPlayer.setTitle("multiPlayer", for: .normal)
        multiPlayer.setTitleColor(.black, for: .normal)
        multiPlayer.backgroundColor = .white
        multiPlayer.addTarget(self, action: #selector(multiPlayerButton), for: .touchUpInside)
        multiPlayer.layer.cornerRadius = 20
        multiPlayer.layer.borderColor = UIColor.black.cgColor
        multiPlayer.layer.borderWidth = 2
        return multiPlayer
    }()
    
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
