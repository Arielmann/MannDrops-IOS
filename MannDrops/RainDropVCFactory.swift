//
//  RainDropVCFactory.swift
//  MannDrops
//
//  Created by hackeru on 11/14/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit

class RainDropVCFactory: NSObject {
    
    let screenSize: CGRect = UIScreen.main.bounds
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0
    
    private func deterScreenSizes(){
        let screenSize: CGRect = UIScreen.main.bounds
        var screenWidth : CGFloat = 0.0
        var screenHeight : CGFloat = 0.0
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        print("Screen Width: \(screenWidth)")
        print("Screen Height: \(screenHeight)")
    }
    
    static func generateRainDropVC(rainDrop : RainDrop) -> RainDropViewController{
        let rainDropVC = RainDropViewController(rainDrop: rainDrop)
        return rainDropVC
    }

}
