//
//  UIFont+Extension.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 24.04.2024.
//

import UIKit

extension UIFont {
    public static func light(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Light", size: CGFloat(size))!
    }
    
    public static func black(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Black", size: CGFloat(size))!
    }
    
    public static func bold(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Bold", size: CGFloat(size))!
    }
    
    public static func regular(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Regular", size: CGFloat(size))!
    }
    
    public static func thin(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Thin", size: CGFloat(size))!
    }
}
