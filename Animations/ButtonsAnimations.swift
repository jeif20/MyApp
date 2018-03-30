//
//  ButtonsAnimations.swift
//  MyApp
//
//  Created by Juan Andonaire on 3/29/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    func shake(){
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x-5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x+5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)

    }
    
    
    
}
