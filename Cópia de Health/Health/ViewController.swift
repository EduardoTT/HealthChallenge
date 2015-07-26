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
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        var xPosition = CGFloat(130)
        var yPosition = CGFloat(150)
        var total:Double = 0.0
        for alimento in alimentosEscolhidos {
            var label = UILabel(frame: CGRectMake(0, 0, 200, 20))
            label.center = CGPointMake(xPosition, yPosition)
            label.text = alimento.valorNutricional.descricao
            self.view.addSubview(label)
            var kcalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
            kcalLabel.center = CGPointMake(xPosition+200, yPosition)
            kcalLabel.text = "\(alimento.valorNutricional.energia!) Kcal"
            self.view.addSubview(kcalLabel)
            yPosition += 30
            total += alimento.valorNutricional.energia!
        }
        var label = UILabel(frame: CGRectMake(0, 0, 200, 20))
        label.center = CGPointMake(xPosition, 450)
        label.text = "Total"
        self.view.addSubview(label)
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
        }
    }
}