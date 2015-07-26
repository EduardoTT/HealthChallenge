//
//  ViewController.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 24/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation
import UIKit

class ViewController:UIViewController {
    
    var alimentosEscolhidos:[Alimento] = [Alimento]()
    var quantidades:[String:Double] = [String:Double]()
    private var xPosition = CGFloat(90)
    private var yPosition = CGFloat(150)
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var total:Double = 0.0
        //cria o registro de cada alimento
        for alimento in alimentosEscolhidos {
            criarRegistroDeAlimento(alimento)
            total += alimento.valorNutricional.energia!/100 * quantidades[alimento.id]!
        }
        //exibe o total de calorias
        var totalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        totalLabel.center = CGPointMake(xPosition, 450)
        totalLabel.text = "Total"
        self.view.addSubview(totalLabel)
        var kcalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        kcalLabel.center = CGPointMake(xPosition+200, 450)
        kcalLabel.text = "\(total) Kcal"
        self.view.addSubview(kcalLabel)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! TableViewController
        vc.alimentosExistentes = [Alimento]()
        for alimento in alimentosEscolhidos {
            vc.alimentosExistentes.append(alimento)
            vc.quantidades[alimento.id] = self.quantidades[alimento.id]
        }
    }
    
    func criarRegistroDeAlimento (alimento: Alimento) {
        var nomeLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        nomeLabel.center = CGPointMake(xPosition, yPosition)
        nomeLabel.text = alimento.valorNutricional.descricao
        self.view.addSubview(nomeLabel)
        
        var qtdButton = UIButton(frame: CGRectMake(0, 0, 100, 20))
        qtdButton.center = CGPointMake(xPosition+100, yPosition)
        qtdButton.setTitle("\(quantidades[alimento.id]!)g", forState: .Normal)
        qtdButton.setTitleColor(UIColor(red:0.0, green:0.478431, blue:1.0, alpha:1.0), forState: .Normal)
        qtdButton.setTitleColor(UIColor(red:0.0, green:0.478431, blue:1.0, alpha:0.2), forState: .Highlighted)
        self.view.addSubview(qtdButton)
        
        var kcalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        kcalLabel.center = CGPointMake(xPosition+200, yPosition)
        kcalLabel.text = "\(alimento.valorNutricional.energia!) Kcal"
        self.view.addSubview(kcalLabel)
        
        yPosition += 30
    }
}