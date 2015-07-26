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
    
    var alimentos:[Alimento]!
    var data:NSDate!
    var foto:UIImage!
    
    init(alimentos:[Alimento],data:NSDate,foto:UIImage) {
        self.alimentos = alimentos
        self.data = data
        self.foto = foto
    }
}