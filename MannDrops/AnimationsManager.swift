//
//  AnimationsManager.swift
//  MannDrops
//
//  Created by hackeru on 11/16/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class AnimationsManager: NSObject {
    
    static let shared = AnimationsManager()
    
    //private let internalQueue: DispatchQueue = DispatchQueue(label:"LockingQueue")
    private var popImages = [#imageLiteral(resourceName: "FirstPopAnimationImage"), #imageLiteral(resourceName: "SecondPopAnimationImage"), #imageLiteral(resourceName: "ThirdPopAnimationImage")]
    
    public func animateRainDrop(gameController : GameViewController, rainDrop: RainDrop, rainDropVC: RainDropViewController){
        gameController.view.addSubview(rainDropVC.view)
        UIView.animate(withDuration: rainDrop.droppingTime, delay: 0, options: .curveLinear, animations: { //Drop the vc down the screen
            rainDropVC.view.frame.origin.y += gameController.fallingLine.frame.origin.y - 40
            }, completion: { finished in
                if(rainDropVC.view.isDescendant(of: gameController.view)){
                    gameController.handleFallenRainDrop(rainDrop: rainDrop, controller: rainDropVC)
                }
        })
        
    }
    
    func popAndRemoveAnimation(rainDropVC : RainDropViewController){
        var interval = 0.0
        var timeInfo = [String : Any]()
        timeInfo["rainDropVC"] = rainDropVC
        rainDropVC.exerciseLabel.text = " "
        for (index, _) in self.popImages.enumerated(){
            timeInfo["image"] = self.popImages[index]
            Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(self.changeImage(timer:)), userInfo: timeInfo, repeats: false)
            interval += 0.02
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) { //wait for pop animation to complete after 0.05 seconds
            rainDropVC.view.removeFromSuperview()
            //SoundManager.shared.playPopSound()
        }
    }
    
    
    public func changeLabelTextAsync(label: UILabel, index : Int){
        var innerIndex = index
        var labelText = "Loading"
        var strings : [String] =  ["Loading", "Loading.", "Loading..", "Loading..."]
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                guard(label.alpha == 1)else{
                    return
                }
                labelText = strings[index]
                DispatchQueue.main.async {
                    label.text = labelText
                    innerIndex = innerIndex == 3 ? 0 : innerIndex + 1
                    self.changeLabelTextAsync(label: label, index: innerIndex)
                }
            }
        }
    }
    
    
    @objc private func changeImage(timer : Timer){
        let timerInfo = timer.userInfo as! [String : Any]
        let controller : RainDropViewController = timerInfo["rainDropVC"] as! RainDropViewController
        let image : UIImage = timerInfo["image"] as! UIImage
        controller.imageView.image = image
    }
    
    public func fadeViewAnimation(controller : UIViewController, view: UIView, duration : Double, targetAlphaLevel : CGFloat){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            view.alpha = targetAlphaLevel
            }, completion: nil)
    }
    
    public func fadeViewAnimationAndAddToParent(controller : UIViewController, view: UIView, duration : Double, targetAlphaLevel : CGFloat){
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            view.alpha = targetAlphaLevel
            }, completion: { finished in
                controller.view.addSubview(view)
        })
    }
}
