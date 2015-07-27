//
//  ValorNutricional.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 24/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation

class ValorNutricional {
    
    var descricao:String!
    var energia:Double?
    var proteina:Double?
    var lipideos:Double?
    var colesterol:Double?
    var carboidrato:Double?
    var fibra:Double?
    var cinzas:Double?
    var calcio:Double?
    var magnesio:Double?
    var manganes:Double?
    var fosforo:Double?
    var ferro:Double?
    var sodio:Double?
    var potassio:Double?
    
    init(desc:String) {
        self.descricao = desc
    }
    
    init(descricao:String, energia:Double, proteina:Double, lipideos:Double, colesterol:Double, carboidrato:Double, fibra:Double, cinzas:Double, calcio:Double, magnesio:Double, manganes:Double, fosforo:Double, ferro:Double, sodio:Double, potassio:Double) {
        self.descricao = descricao
        self.energia = energia
        self.lipideos = lipideos
        self.colesterol = colesterol
        self.carboidrato = carboidrato
        self.fibra = fibra
        self.cinzas = cinzas
        self.calcio = calcio
        self.magnesio = magnesio
        self.manganes = manganes
        self.fosforo = fosforo
        self.ferro = ferro
        self.sodio = sodio
        self.potassio = potassio
    }
}