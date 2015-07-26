//
//  ViewController.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 24/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation
import UIKit

class ViewController:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var alimentosEscolhidos:[Alimento] = [Alimento]()
    var quantidades:[String:Int] = [String:Int]()
    var caloriasLabels:[String:UILabel] = [String:UILabel]()
    var botoes:[UIButton:String] = [UIButton:String]()
    private var xPosition = CGFloat(90)
    private var yPosition = CGFloat(150)
    
    @IBOutlet weak var qtdPicker: UIPickerView!
    @IBOutlet weak var closeQtdPicker: UIButton!
    
    private var kcalLabel:UILabel?
    
    var pickerLabels = [String]()
    var pickerValueSelected: Int = 100
    
    var buttonChoosed:UIButton?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        qtdPicker.delegate = self
        qtdPicker.dataSource = self
        qtdPicker.hidden = true
        closeQtdPicker.hidden = true
        closeQtdPicker.addTarget(self, action: "closePicker", forControlEvents: .TouchUpInside)
        for val in 1...100 {
            pickerLabels.append("\(val*10) gramas")
        }
        qtdPicker.selectRow(9, inComponent: 0, animated: true)
        
        var total:Double = 0.0
        //cria o registro de cada alimento
        for alimento in alimentosEscolhidos {
            criarRegistroDeAlimento(alimento)
            total += alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!)
        }
        //exibe o total de calorias
        var totalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        totalLabel.center = CGPointMake(xPosition, 450)
        totalLabel.text = "Total"
        self.view.addSubview(totalLabel)
        kcalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        kcalLabel!.center = CGPointMake(xPosition+200, 450)
        kcalLabel!.text = "\(total) Kcal"
        self.view.addSubview(kcalLabel!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        qtdButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        botoes[qtdButton] = alimento.id
        self.view.addSubview(qtdButton)
        
        var kcalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        kcalLabel.center = CGPointMake(xPosition+200, yPosition)
        kcalLabel.text = "\(alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!))  Kcal"
        self.view.addSubview(kcalLabel)
        caloriasLabels[alimento.id] = kcalLabel
        
        yPosition += 30
    }
    
    func pressed(sender: UIButton!) {
//        var alertView = UIAlertView()
//        alertView.addButtonWithTitle("Ok")
//        alertView.title = "title";
//        alertView.message = DAO.sharedInstance.alimentosPorId[botoes[sender]!]!.valorNutricional.descricao
//        alertView.show()
        qtdPicker.hidden = false
        closeQtdPicker.hidden = false
        buttonChoosed = sender
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerLabels[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerValueSelected = (pickerLabels[row] as NSString).integerValue
    }
    
    func closePicker() {
        qtdPicker.hidden = true
        closeQtdPicker.hidden = true
        buttonChoosed?.setTitle("\(pickerValueSelected)g", forState: .Normal)
        var id = botoes[buttonChoosed!]!
        quantidades[id] = pickerValueSelected
        var kcal = DAO.sharedInstance.alimentosPorId[id]!.valorNutricional.energia!/100 * Double(quantidades[id]!)
        caloriasLabels[id]!.text = "\(kcal) Kcal"
        
        var total:Double = 0.0
        for alimento in alimentosEscolhidos {
            total += alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!)
        }
        kcalLabel!.text = "\(total) Kcal"
    }
}