//
//  Alimento.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 24/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation

class Alimento {
    
    var id:String!
    var valorNutricional:ValorNutricional!
    
    init(id:String,valNut:ValorNutricional) {
        self.id = id
        self.valorNutricional = valNut
    }
}