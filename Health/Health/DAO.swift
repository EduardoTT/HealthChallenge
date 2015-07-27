//
//  DAO.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 23/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation
import UIKit

//Alimentos.plist description
//0 - descrição
//1 - Energia - Kcal
//2- Proteína - g
//3 - Lipídeos - g
//4 - Colesterol - mg
//5 - Carboidrato - g
//6 - fibra - g
//7 - Cinzas - g
//8 - Cálcio - mg
//9 - Magnésio - mg
//10 - Manganês - mg
//11 - Fósforo - mg
//12 - Ferro - mg
//13 - Sódio - mg
//14 - Potássio - mg

//Alimentos.plist special values
//-1 NA : Nao aplicavel
//-2 Tr : Traço, insignificante quantidade
//-3 : Não há informação

//Alimentos.plist
//valores por 100 gramas de partes comestíveis
//http://www.unicamp.br/nepa/taco/tabela.php?ativo=tabela

class DAO {
    
    static let sharedInstance = DAO()
    
    let alimentosPorId:[String:Alimento]!
    let alimentosPorDescricao:[String:Alimento]!
    private let nAlimentos = 597
    
    var alimentosEscolhidos:[String:Alimento] = [String:Alimento]()
    var quantidades:[String:Int] = [String:Int]()
    
    private init() {
        self.alimentosPorId = [String:Alimento]()
        self.alimentosPorDescricao = [String:Alimento]()
        if let path = NSBundle.mainBundle().pathForResource("Alimentos", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                for i in 1...nAlimentos {
                    var valNut:ValorNutricional
                    var tempAlimento: [String] = dict["\(i)"] as! [String]
                    valNut = ValorNutricional(desc: tempAlimento[0])
                    valNut.energia = (tempAlimento[1] as NSString).doubleValue
                    valNut.proteina = (tempAlimento[2] as NSString).doubleValue
                    valNut.lipideos = (tempAlimento[3] as NSString).doubleValue
                    valNut.colesterol = (tempAlimento[4] as NSString).doubleValue
                    valNut.carboidrato = (tempAlimento[5] as NSString).doubleValue
                    valNut.fibra = (tempAlimento[6] as NSString).doubleValue
                    valNut.cinzas = (tempAlimento[7] as NSString).doubleValue
                    valNut.calcio = (tempAlimento[8] as NSString).doubleValue
                    valNut.magnesio = (tempAlimento[9] as NSString).doubleValue
                    valNut.manganes = (tempAlimento[10] as NSString).doubleValue
                    valNut.fosforo = (tempAlimento[11] as NSString).doubleValue
                    valNut.ferro = (tempAlimento[12] as NSString).doubleValue
                    valNut.sodio = (tempAlimento[13] as NSString).doubleValue
                    valNut.potassio = (tempAlimento[14] as NSString).doubleValue
                    var alimentoTemp = Alimento(id: "\(i)", valNut: valNut)
                    self.alimentosPorId["\(i)"] = alimentoTemp
                    self.alimentosPorDescricao[alimentoTemp.valorNutricional.descricao] = alimentoTemp
                }
            }
        }
    }
    
    func salvarPrato(prato:Prato) {
        var alimentosDict = NSMutableDictionary()
        var pratoDict = NSMutableDictionary()
        for alimento in prato.alimentos {
            var valorNutricionalDict = NSMutableDictionary()
            var alimentoDict = NSMutableDictionary()
            
            valorNutricionalDict.setValue(alimento.1.valorNutricional.descricao, forKey: "descricao")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.energia, forKey: "energia")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.proteina, forKey: "proteina")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.lipideos, forKey: "lipideos")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.colesterol, forKey: "colesterol")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.carboidrato, forKey: "carboidrato")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.fibra, forKey: "fibra")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.cinzas, forKey: "cinzas")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.calcio, forKey: "calcio")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.magnesio, forKey: "magnesio")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.manganes, forKey: "manganes")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.fosforo, forKey: "fosforo")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.ferro, forKey: "ferro")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.sodio, forKey: "sodio")
            valorNutricionalDict.setValue(alimento.1.valorNutricional.potassio, forKey: "potassio")
            
            alimentoDict.setValue(valorNutricionalDict, forKey: "valorNutricional")
            alimentoDict.setValue(prato.quantidades[alimento.0], forKey: "quantidade")
            alimentosDict.setValue(alimentoDict, forKey: alimento.0)
        }
        pratoDict.setValue(alimentosDict, forKey: "alimentos")
        pratoDict.setValue(prato.data, forKey: "data")
        pratoDict.setValue(prato.foto, forKey: "foto")
        
        if let path = NSBundle.mainBundle().pathForResource("Pratos", ofType: "plist"), array = NSMutableArray(contentsOfFile : path) {
            array.addObject(pratoDict)
            array.writeToFile(path, atomically: true)
        }
    }
    
    func getAllPratos() -> [Prato] {
        var pratos = [Prato]()
        
        var alimentosDict:NSMutableDictionary
        var data:NSDate
        var foto:String
        var pratoDict:NSMutableDictionary
        var valorNutricionalDict:NSMutableDictionary
        var id:String
        var descricao:String
        var energia:Double
        var proteina:Double
        var lipideos:Double
        var colesterol:Double
        var carboidrato:Double
        var fibra:Double
        var cinzas:Double
        var calcio:Double
        var magnesio:Double
        var manganes:Double
        var fosforo:Double
        var ferro:Double
        var sodio:Double
        var potassio:Double
        
        if let path = NSBundle.mainBundle().pathForResource("Pratos", ofType: "plist"), array = NSMutableArray(contentsOfFile : path) {
            var prato:NSMutableDictionary
            for prato in array {
                alimentosDict = prato.objectForKey("alimentos") as! NSMutableDictionary
                data = prato.objectForKey("data") as! NSDate
                foto = prato.objectForKey("foto") as! String
                for x in alimentosDict {
                    var pratoToReturn = Prato(alimentos: [String : Alimento](), quantidades: [String : Int](), data: data, foto: foto)
                    valorNutricionalDict = x.value.objectForKey("valorNutricional") as! NSMutableDictionary
                    id = x.key as! String
                    descricao = valorNutricionalDict.objectForKey("descricao") as! String
                    energia = valorNutricionalDict.objectForKey("energia") as! Double
                    proteina = valorNutricionalDict.objectForKey("proteina") as! Double
                    lipideos = valorNutricionalDict.objectForKey("lipideos") as! Double
                    colesterol = valorNutricionalDict.objectForKey("colesterol") as! Double
                    carboidrato = valorNutricionalDict.objectForKey("carboidrato") as! Double
                    fibra = valorNutricionalDict.objectForKey("fibra") as! Double
                    cinzas = valorNutricionalDict.objectForKey("cinzas") as! Double
                    calcio = valorNutricionalDict.objectForKey("calcio") as! Double
                    magnesio = valorNutricionalDict.objectForKey("magnesio") as! Double
                    manganes = valorNutricionalDict.objectForKey("manganes") as! Double
                    fosforo = valorNutricionalDict.objectForKey("fosforo") as! Double
                    ferro = valorNutricionalDict.objectForKey("ferro") as! Double
                    sodio = valorNutricionalDict.objectForKey("sodio") as! Double
                    potassio = valorNutricionalDict.objectForKey("potassio") as! Double
                    
                    var valNut = ValorNutricional(descricao: descricao, energia: energia, proteina: proteina, lipideos: lipideos, colesterol: colesterol, carboidrato: carboidrato, fibra: fibra, cinzas: cinzas, calcio: calcio, magnesio: magnesio, manganes: manganes, fosforo: fosforo, ferro: ferro, sodio: sodio, potassio: potassio)
                    var alimento = Alimento(id: id, valNut: valNut)
                    pratoToReturn.alimentos[id] = alimento
                    pratoToReturn.quantidades[id] = x.value.objectForKey("quantidade") as? Int
                    
                    pratos.append(pratoToReturn)
                }
            }
            for p in pratos {
                for a in p.alimentos {
                    println(a.1.valorNutricional.descricao)
                    println(a.1.valorNutricional.energia!)
                }
            }
            return pratos
        }
        
        return pratos
    }
}