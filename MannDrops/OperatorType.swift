//
//  OperatorType.swift
//  MannDrops
//
//  Created by hackeru on 10/13/16.
//  Copyright © 2016 hackeru. All rights reserved.
//

import UIKit
    
    enum OperatorType : String{
        case Plus = "+"
        case Minus = "-"
        case Multiply = "*"
        case Divide = ":"
        
        func answer(n1 : Int, n2 : Int) -> String{
            switch self {
            case .Plus:
                return (n1 + n2).description
            default:
                return ""
            }
        }
    }
