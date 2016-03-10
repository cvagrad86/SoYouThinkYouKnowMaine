//
//  Theme.swift
//  SoYouThinkYouKnow
//
//  Created by Eric Chamberlin on 3/8/16.
//  Copyright © 2016 Eric Chamberlin. All rights reserved.
//

import Foundation
import UIKit

struct Theme {

enum Colors {
case TintColor
case BackgroundColor
case DarkBackgroundColor
case SectionHeader
case Foreground
case LightTextColor

var color: UIColor {
switch self {
case .TintColor: return UIColor(red:0.97, green:0.9, blue:0, alpha:1)
case .BackgroundColor: return UIColor(hue: 0.3361, saturation: 1, brightness: 0.58, alpha: 1.0)
case .DarkBackgroundColor: return UIColor(red:0.11, green:0.1, blue:0.22, alpha:1)
case .SectionHeader: return UIColor(hue:0.67, saturation:0.4, brightness:0.25, alpha:1)
case .Foreground: return UIColor(red:0.26, green:0.25, blue:0.37, alpha:1)
case .LightTextColor: return UIColor(red:0.64, green:0.65, blue:0.8, alpha:1)
}
}
}

enum Fonts {
case TitleFont
case BoldTitleFont

var font: UIFont {
switch self {
case .BoldTitleFont: return UIFont(name: "Copperplate-Bold", size: 17)!
case .TitleFont: return UIFont(name: "Copperplate", size: 16)!
}
}
}

}
    
/*
Maine Green

UIColor(hue: 0.3361, saturation: 1, brightness: 0.58, alpha: 1.0) /* #009302 */
UIColor(hue: 121/360, saturation: 100/100, brightness: 58/100, alpha: 1.0) /* #009302 */

UIColor(red: 0, green: 0.5765, blue: 0.0078, alpha: 1.0) /* #009302 */
UIColor(red: 0/255, green: 147/255, blue: 2/255, alpha: 1.0) /* #009302 */

*/