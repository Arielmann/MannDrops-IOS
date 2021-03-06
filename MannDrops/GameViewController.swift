//
//  GameViewController.swift
//  MannDrops
//
//  Created by hackeru hackeru on 05/10/2016.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GameViewController: UIViewController {
    
    @IBOutlet var allMenuViews: [UIView]!
    @IBOutlet var allMenuButtons: [UIButton]!
    @IBOutlet var allGameButtons: [UIButton]!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel! //user's score
    @IBOutlet weak var resultLabel: UILabel! //user input view
    @IBOutlet weak var fallingLine: UIView! // raindrop fall until it reaches this border.
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var highScoresButton: UIButton!
    
    private var screenWidth : CGFloat = 0.0
    private var screenHeight : CGFloat = 0.0
    private var rainDropVcDict: [String : RainDropViewController] = [:]
    private var goldenRainDropVcDict: [String : RainDropViewController] = [:]
    private let easyModel : ExercisesDataModel.Easy = ExercisesDataModel.Easy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deterScreenSizes()
        adjustMenuViews(buttons: allMenuButtons, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.black.cgColor, maskToBounds: true)
        
        for button in allGameButtons{
            AnimationsManager.shared.fadeViewAnimation(controller : self, view: button, duration: 0, targetAlphaLevel: 0)
            button.isEnabled = false
        }
    }
    
    private func adjustMenuViews(buttons : [UIButton], cornerRadius : Int, borderWidth : Int, borderColor : CGColor, maskToBounds : Bool){
        nameLabel.text = AppManager.shared.userName ?? "You"
        nameLabel.textAlignment = .center
        for button in buttons{
            button.layer.cornerRadius = CGFloat(cornerRadius)
            button.layer.borderWidth = CGFloat(borderWidth)
            button.layer.borderColor = borderColor
            button.layer.masksToBounds = maskToBounds
        }
    }
    @IBAction func saveName(_ sender: AnyObject) {
        SingleGameData.NAME = nameLabel.text!
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        
        startGameButton.isEnabled = false
        self.nameLabel.isEnabled = false
        self.fallingLine.frame.origin.y = screenHeight * 70 / 100
        SingleGameData.LIVES = 3
        
        for view in allMenuViews{
            AnimationsManager.shared.fadeViewAnimation(controller : self, view: view, duration: 1, targetAlphaLevel: 0)
        }
        
        for button in allGameButtons{
            button.isEnabled = true
            print(button.description)
            AnimationsManager.shared.fadeViewAnimation(controller : self, view: button, duration: 1.5, targetAlphaLevel: 1)
        }
        
        TimersManager.shared.initTimers(controller: self) //Define the exercise Timers dropping time
        saveChosenName()
    }
    
    private func saveChosenName(){
        guard nameLabel.text != "" && nameLabel.text != nil else{
            return
        }
        SingleGameData.NAME = nameLabel.text!
        AppManager.shared.userName = SingleGameData.NAME
    }
    
    @objc public func willAnimateRainDrop(timer: Timer){ //prepare for animation
        let model = timer.userInfo as! ExercisesDataModel
        let rainDrop = RainDropFactory.generateRainDrop(exerciseDataModel: model) //First create a rainDrop
        //Then create a vc based on this rainDrop
        let controllerId = UUID.init().uuidString //unique id
        rainDropVcDict[controllerId] = RainDropVCFactory.generateRainDropVC(rainDrop: rainDrop) //add controller for answers check dict
        rainDropVcDict[controllerId]?.view.frame.origin.x = CGFloat(RandomFactory.generateNumberBetweenTwoValues(maxValue: Int(screenWidth) - 90, minValue: 90))
        rainDropVcDict[controllerId]?.view.frame.origin.y = self.scoreLabel.frame.origin.y + 10
        AnimationsManager.shared.animateRainDrop(gameController: self, rainDrop: rainDrop, rainDropVC: rainDropVcDict[controllerId]!)
    }
    
    @objc public func willAnimateGoldenRainDrop(timer: Timer){ //same as willAnimateRainDrop but with an image change
        let model = timer.userInfo as! ExercisesDataModel
        let goldenRainDrop = RainDropFactory.generateRainDrop(exerciseDataModel: model) //Golden rainDrop
        
        //Then create a vc based on that rainDrop
        let controllerId = UUID.init().uuidString //unique id
        goldenRainDropVcDict[controllerId] = RainDropVCFactory.generateRainDropVC(rainDrop: goldenRainDrop)
        goldenRainDropVcDict[controllerId]?.imageView.image = UIImage(named: "SmallGoldenRainDropImage") //Golden
        goldenRainDropVcDict[controllerId]?.view.frame.origin.x = CGFloat(RandomFactory.generateNumberBetweenTwoValues(maxValue: Int(screenWidth) - 90, minValue: 90))
        goldenRainDropVcDict[controllerId]?.view.frame.origin.y = self.scoreLabel.frame.origin.y + 10
        AnimationsManager.shared.animateRainDrop(gameController: self, rainDrop: goldenRainDrop, rainDropVC: goldenRainDropVcDict[controllerId]!)
    }
    
    let internalQueue: DispatchQueue = DispatchQueue(label:"LockingQueue")
    
    public func handleFallenRainDrop(rainDrop : RainDrop, controller : RainDropViewController){
        cleanAllRainDropsFromScreen()
        SingleGameData.LIVES -= 1
        print("Rain dropped. Xcord: " + controller.view.frame.origin.x.description)
        print("Lives remaining: " + (SingleGameData.LIVES.description))
        guard SingleGameData.LIVES != 0 else{
            gameEnded()
            return
        }
        createFadingPenaltyLabel(penaltyText: String(SingleGameData.LIVES) + " lives remain", fontSize : 30)
    }
    
    private func gameEnded(){
        TimersManager.shared.InvalidateAllTimers()
        cleanAllRainDropsFromScreen() //Make sure there are no drops left
        let currentScoreDict : [String:Any] = Scores.saveScore(name: SingleGameData.NAME, score: SingleGameData.SCORE, exercisesSolved: Int(SingleGameData.EXERCISES_SOLVED), errors: Int(SingleGameData.ERRORS))
        saveToFirebaseHighScore(scoreData: currentScoreDict, targetUser: AppManager.shared.uid!)
        showGameEndedAlert()
    }
    
    private func saveToFirebaseHighScore(scoreData: [String:Any], targetUser : String){
        if(Int16(SingleGameData.SCORE) > Scores.allScores[0].score){ //if game score is higher than highest score
            FirebaseDBManager.shared.saveHighScore(score: scoreData, targetUser: targetUser) //save it to Firebase
            print("Highscore: " + scoreLabel.text!, " was saved to Firebase")
        }
    }
    
    @IBAction func addNumberToResultLabel(_ sender: UIButton) {
        resultLabel.text = resultLabel.text! + (sender.titleLabel?.text!)!
    }
    
    @IBAction func deleteNumberFromResultLabel(_ sender: UIButton) {
        if(resultLabel.text != " "){
            resultLabel.text!.remove(at:  (resultLabel.text?.index(before: (resultLabel.text?.endIndex)!))!)
        }
    }
    
    @IBAction func handleUserAnswer(_ sender: UIButton) {
        let userAnswerWithSpace = resultLabel.text!
        let finalUserAnswer = userAnswerWithSpace.trimmingCharacters(in: .whitespaces)
        let totalAnswerCount = rainDropVcDict.count + goldenRainDropVcDict.count
        compareWithGoldenRainDrops(finalUserAnswer: finalUserAnswer)
        if(rainDropVcDict.count + goldenRainDropVcDict.count != totalAnswerCount){ //Was the user correct?
            resultLabel.text = " "
            return
        }
        compareWithRainDrops(finalUserAnswer: finalUserAnswer)
        if(rainDropVcDict.count + goldenRainDropVcDict.count == totalAnswerCount && resultLabel.text != " "){ //Was the user completly Wrong?
            handleWrongAnswer()
        }
        resultLabel.text = " "
    }
    
    private func compareWithGoldenRainDrops(finalUserAnswer : String){
        for (key, goldenRainDropVC) in goldenRainDropVcDict {
            let  rainDropAnswer = goldenRainDropVC.rainDrop.answer
            if(finalUserAnswer == rainDropAnswer){
                SingleGameData.EXERCISES_SOLVED += 1
                AnimationsManager.shared.popAndRemoveAnimation(rainDropVC: ((goldenRainDropVcDict[key])!)) //pop current golden drop
                goldenRainDropVcDict.removeValue(forKey: key)
                cleanAllRainDropsFromScreen() // remove all other rainDrops
                SingleGameData.SCORE += Int(finalUserAnswer)! + 10
                scoreLabel.text = String(SingleGameData.SCORE)
                resultLabel.text = " "
                Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(GameViewController.willAnimateRainDrop), userInfo: easyModel, repeats: false) //create new exercise
                print("User has answered \(finalUserAnswer.description) and was correct. Answer:\( rainDropAnswer)")
            }
        }
    }
    
    private func compareWithRainDrops(finalUserAnswer : String){
        for (key, rainDropVC) in rainDropVcDict {
            let answer = rainDropVC.rainDrop.answer
            if(finalUserAnswer == answer!){
                SingleGameData.EXERCISES_SOLVED += 1
                AnimationsManager.shared.popAndRemoveAnimation(rainDropVC: rainDropVcDict[key]!)
                rainDropVcDict.removeValue(forKey: key)
                SingleGameData.SCORE += Int(answer!)! + 10
                scoreLabel.text = String(SingleGameData.SCORE)
                resultLabel.text = " "
                if(rainDropVcDict.isEmpty){ //prevent empty screen by adding another exercise
                    Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(GameViewController.willAnimateRainDrop), userInfo: easyModel, repeats: false)
                }
                print(" User has answered \(finalUserAnswer.description) and was correct. Answer:\(answer)")
            }else{
                print("Current index answer: \(answer) doesn't match user's answer \(finalUserAnswer.description)")
            }
        }
    }
    
    private func handleWrongAnswer(){
        let scorePanelty = String(Int(SingleGameData.SCORE) * 5/100) // decrease 5% from score
        SingleGameData.SCORE -= Int(scorePanelty)!
        scoreLabel.text = String(SingleGameData.SCORE)
        createFadingPenaltyLabel(penaltyText: "-" + scorePanelty, fontSize : 65)
        SingleGameData.ERRORS += 1
        print("Wrong answer. score panelty: " + scorePanelty)
    }
    
    private func cleanAllRainDropsFromScreen(){
        for (key, _) in rainDropVcDict {
            AnimationsManager.shared.popAndRemoveAnimation(rainDropVC: rainDropVcDict[key]!)
        }
        for (key, _) in goldenRainDropVcDict {
            AnimationsManager.shared.popAndRemoveAnimation(rainDropVC: goldenRainDropVcDict[key]!)
        }
        resultLabel.text = " "
        rainDropVcDict.removeAll()
        goldenRainDropVcDict.removeAll()
    }
    
    private func deterScreenSizes(){
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        print("Screen Width: \(screenWidth)")
        print("Screen Height: \(screenHeight)")
    }
    
    private func createFadingPenaltyLabel(penaltyText: String, fontSize : Int){
        let xCoor = RandomFactory.generateNumberBetweenTwoValues(maxValue: (Int(screenWidth) - 90), minValue: 90)
        let yCoor = RandomFactory.generateNumberBetweenTwoValues(maxValue: (Int(screenHeight) - 90), minValue: 90)
        let paneltyLabel = UILabel(frame: CGRect(x: xCoor, y: yCoor, width: 500, height: 60))
        paneltyLabel.center = CGPoint(x: xCoor, y: yCoor)
        paneltyLabel.textAlignment = .center
        paneltyLabel.textColor = UIColor.red
        paneltyLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        paneltyLabel.text = penaltyText
        self.view.addSubview(paneltyLabel)
        AnimationsManager.shared.fadeViewAnimation(controller : self, view: paneltyLabel, duration : 1.5, targetAlphaLevel : 0)
    }
    
    private func showGameEndedAlert() {
        // create the alert
        let alert = UIAlertController(title: "Good Job!", message: "Score: " + String(SingleGameData.SCORE), preferredStyle: UIAlertControllerStyle.alert)
        addTryAgainAlertAction(alert: alert)
        addMainMenuAlertAction(alert: alert)
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addTryAgainAlertAction(alert : UIAlertController){
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: {
            action in
            self.nullifyInGameData()
            TimersManager.shared.initTimers(controller: self)
        }))
    }
    
    private func addMainMenuAlertAction(alert : UIAlertController){
        alert.addAction(UIAlertAction(title: "Main Menu", style: UIAlertActionStyle.cancel, handler: {
            action in //Recreate menu and make game buttons disappear. nullify scores
            self.nullifyInGameData()
            for button in self.allGameButtons{
                AnimationsManager.shared.fadeViewAnimation(controller : self, view: button, duration: 1.5, targetAlphaLevel: 0)
                button.isEnabled = false
            }
            
            for view in self.allMenuViews{
                AnimationsManager.shared.fadeViewAnimationAndAddToParent(controller : self, view: view, duration: 1, targetAlphaLevel: 1)
            }
            self.nameLabel.text = SingleGameData.NAME
            self.startGameButton.isEnabled = true
            self.nameLabel.isEnabled = true
        }))
    }
    
    private func nullifyInGameData(){
        SingleGameData.nullifyGameData()
        self.resultLabel.text = " "
        self.scoreLabel.text = "0"
        
    }
}


