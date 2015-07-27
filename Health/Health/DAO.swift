//
//  DAO.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 23/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation

//plist description
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

//plist special values
//-1 NA : Nao aplicavel
//-2 Tr : Traço, insignificante quantidade
//-3 : Não há informação

//plist
//valores por 100 gramas de partes comestíveis
//http://www.unicamp.br/nepa/taco/tabela.php?ativo=tabela

class DAO {
    
    static let sharedInstance = DAO()
    
    let alimentosPorId:[String:Alimento]!
    let alimentosPorDescricao:[String:Alimento]!
    private let nAlimentos = 597
    
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
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("Pratos.plist")
        var fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path)))
        {
            var bundle : NSString! = NSBundle.mainBundle().pathForResource("Pratos", ofType: "plist")
            //fileManager.copyItemAtPath(bundle, toPath: path, error:nil)
        }
        var data : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        data.setObject(10, forKey: "1")
        data.writeToFile(path, atomically: false)
    }
}