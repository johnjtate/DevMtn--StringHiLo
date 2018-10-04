//
//  StickFigure.swift
//  DevMtn-StripHiLo
//
//  Created by John Tate on 10/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class StickFigure {
    
    let number: Int
    let imageName: String
    
    init(number: Int, imageName: String) {
        self.number = number
        self.imageName = imageName
    }
    
    let stickFigures: [StickFigure] = [stickfigure1, stickfigure2, stickfigure3, stickfigure4, stickfigure5]
}

let stickfigure1 = StickFigure.init(number: 1, imageName: "image001")
let stickfigure2 = StickFigure.init(number: 2, imageName: "image002")
let stickfigure3 = StickFigure.init(number: 3, imageName: "image003")
let stickfigure4 = StickFigure.init(number: 4, imageName: "image004")
let stickfigure5 = StickFigure.init(number: 5, imageName: "image005")

