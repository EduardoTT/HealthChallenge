//
//  Prato.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 24/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation
import UIKit

class Prato {
    
    var alimentos:[String:Alimento]!
    var quantidades:[String:Int]!
    var data:NSDate!
    var foto:String!
    
    init(alimentos:[String:Alimento],quantidades:[String:Int],data:NSDate,foto:String) {
        self.alimentos = alimentos
        self.quantidades = quantidades
        self.data = data
        self.foto = foto
    }
}