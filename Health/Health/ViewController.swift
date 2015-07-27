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
    
    var alimentosEscolhidos:[String:Alimento] = [String:Alimento]()
    var quantidades:[String:Int] = [String:Int]()
    var caloriasLabels:[String:UILabel] = [String:UILabel]()
    var botoes:[String:UIButton] = [String:UIButton]()
    var nomeLabels:[String:UILabel] = [String:UILabel]()
    var deleteButtons:[String:UIButton] = [String:UIButton]()
    var caloriasGrandezaLabels:[String:UILabel] = [String:UILabel]()
    private var xPosition = CGFloat(90)
    private var yPosition = CGFloat(150)
    
    @IBOutlet weak var qtdPicker: UIPickerView!
    @IBOutlet weak var closeQtdPicker: UIButton!
    
    private var kcalTotalLabel:UILabel?
    
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
        
        for a in DAO.sharedInstance.alimentosEscolhidos {
            alimentosEscolhidos[a.0] = a.1
        }
        
        for q in DAO.sharedInstance.quantidades {
            quantidades[q.0] = q.1
        }
        
        var total:Double = 0.0
        //cria o registro de cada alimento
        for alimento in alimentosEscolhidos.values {
            criarRegistroDeAlimento(alimento)
            total += alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!)
        }
        //exibe o total de calorias
        var totalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        totalLabel.center = CGPointMake(xPosition, 450)
        totalLabel.text = "Total"
        self.view.addSubview(totalLabel)
        kcalTotalLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        kcalTotalLabel!.center = CGPointMake(xPosition+200, 450)
        kcalTotalLabel!.text = "\(total) Kcal"
        self.view.addSubview(kcalTotalLabel!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! TableViewController
//        vc.alimentosExistentes = [String:Alimento]()
        DAO.sharedInstance.alimentosEscolhidos = [String:Alimento]()
        for alimento in alimentosEscolhidos.values {
//            vc.alimentosExistentes[alimento.id] = alimento
//            vc.quantidades[alimento.id] = self.quantidades[alimento.id]
            DAO.sharedInstance.alimentosEscolhidos[alimento.id] = alimento
            DAO.sharedInstance.quantidades[alimento.id] = self.quantidades[alimento.id]
        }
    }
    
    func criarRegistroDeAlimento (alimento: Alimento) {
        let deleteButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        deleteButton.frame=CGRectMake(0, 0, 20, 20)
        deleteButton.center = CGPointMake(xPosition-70, yPosition)
        deleteButton.setBackgroundImage(UIImage(named: "delete-button.png"), forState: UIControlState.Normal)
        deleteButton.tintColor = UIColor.blackColor()
        deleteButton.addTarget(self, action: "deletarRegistro:", forControlEvents: .TouchUpInside)
        deleteButtons[alimento.id] = deleteButton
        self.view.addSubview(deleteButton)
        
        var nomeLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        nomeLabel.center = CGPointMake(xPosition, yPosition)
        nomeLabel.text = alimento.valorNutricional.descricao
        self.view.addSubview(nomeLabel)
        nomeLabels[alimento.id] = nomeLabel
        
        var qtdButton = UIButton(frame: CGRectMake(0, 0, 100, 20))
        qtdButton.center = CGPointMake(xPosition+100, yPosition)
        qtdButton.setTitle("\(quantidades[alimento.id]!)g", forState: .Normal)
        qtdButton.setTitleColor(UIColor(red:0.0, green:0.478431, blue:1.0, alpha:1.0), forState: .Normal)
        qtdButton.setTitleColor(UIColor(red:0.0, green:0.478431, blue:1.0, alpha:0.2), forState: .Highlighted)
        qtdButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        botoes[alimento.id] = qtdButton
        self.view.addSubview(qtdButton)
        
        var kcalValLabel = UILabel(frame: CGRectMake(0, 0, 50, 20))
        kcalValLabel.center = CGPointMake(xPosition+190, yPosition)
        kcalValLabel.text = "\(alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!))"
        self.view.addSubview(kcalValLabel)
        caloriasLabels[alimento.id] = kcalValLabel
        
        var kcalGrandLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        kcalGrandLabel.center = CGPointMake(xPosition+280, yPosition)
        kcalGrandLabel.text = "Kcal"
        self.view.addSubview(kcalGrandLabel)
        caloriasGrandezaLabels[alimento.id] = kcalGrandLabel
        
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
        var id:String = ""
        for button in botoes {
            if (button.1 == buttonChoosed) {
                id = button.0
            }
        }
        quantidades[id] = pickerValueSelected
        var kcal = DAO.sharedInstance.alimentosPorId[id]!.valorNutricional.energia!/100 * Double(quantidades[id]!)
        caloriasLabels[id]!.text = "\(kcal)"
        
        var total:Double = 0.0
        for alimento in alimentosEscolhidos.values {
            total += alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!)
        }
        kcalTotalLabel!.text = "\(total) Kcal"
    }
    
    func deletarRegistro(sender:UIButton!) {
        var id:String = ""
        for button in deleteButtons {
            if (button.1 == sender) {
                id = button.0
            }
        }
        
        sender.removeFromSuperview()
        deleteButtons.removeValueForKey(id)
        botoes[id]?.removeFromSuperview()
        botoes.removeValueForKey(id)
        nomeLabels[id]?.removeFromSuperview()
        nomeLabels.removeValueForKey(id)
        caloriasLabels[id]?.removeFromSuperview()
        caloriasLabels.removeValueForKey(id)
        caloriasGrandezaLabels[id]?.removeFromSuperview()
        caloriasGrandezaLabels.removeValueForKey(id)
        
        alimentosEscolhidos.removeValueForKey(id)
        quantidades.removeValueForKey(id)
        
        var total:Double = 0.0
        for alimento in alimentosEscolhidos.values {
            total += alimento.valorNutricional.energia!/100 * Double(quantidades[alimento.id]!)
        }
        kcalTotalLabel!.text = "\(total) Kcal"
    }
    
    @IBAction func limpar(sender: AnyObject) {
        DAO.sharedInstance.alimentosEscolhidos = [String:Alimento]()
        DAO.sharedInstance.quantidades = [String:Int]()
        
        for b in deleteButtons.values {
            deletarRegistro(b)
        }
    }
    
    
    @IBAction func save(sender: AnyObject) {
        var prato = Prato(alimentos: alimentosEscolhidos, quantidades: quantidades, data: NSDate(), foto: "teste")
        DAO.sharedInstance.salvarPrato(prato)
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "salvo com sucesso"
        alert.addButtonWithTitle("Ok")
        alert.show()
        limpar("")
    }
}