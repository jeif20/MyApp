//
//  Post.swift
//  MyApp
//
//  Created by Juan Andonaire on 4/3/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import Foundation
class Post{
    
    var humidity: String
    var temp: String
    
    init(tempValue: String, humidityValue: String){
        temp = tempValue
        humidity = humidityValue
    }
}
