//
//  RodoSampleAppStyleSettings.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import Foundation
import UIKit

struct UIStyleSettings {
    var homeBackgroundColor = UIColor( red:25/255.0, green:42/255.0, blue:47/255.0, alpha:1.0)
    var fontStyle = "Avenir-Black"
    
    var normalfontSize = 14.0
    var foregroundColor = UIColor( red:6/255.0, green:197/255.0, blue:91/255.0, alpha:1.0)
   
    var vehicleTitleTextColor = UIColor.white
    var vehicleTitleTextSize = 14.0
    var maxNavBarHeight = 0
}
let rodoSampleAppUIStyleSettings:UIStyleSettings = UIStyleSettings()




func makeStandardAppButton()->UIButton{
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 25.0
    button.backgroundColor = UIColor.clear
    button.titleLabel?.font = UIFont(name: rodoSampleAppUIStyleSettings.fontStyle, size: rodoSampleAppUIStyleSettings.normalfontSize )
    button.setTitleColor( rodoSampleAppUIStyleSettings.foregroundColor, for: .normal )
    button.layer.borderColor = rodoSampleAppUIStyleSettings.foregroundColor.cgColor
    button.layer.borderWidth = 2
    return button
}





