//
//  UIColorExtension.swift
//  Moviender
//
//  Created by Enzo Maruffa Moreira on 02/05/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

extension UIColor {
    
    func borderByBackground() -> UIColor {
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return UIColor.white }
        
        if r1 >= 0.99 && g1 >= 0.99 && b1 >= 0.99 {
            return UIColor.black
        }
        return UIColor.white
    }

}
