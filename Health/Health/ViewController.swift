//
//  ViewController.swift
//  Health
//
//  Created by Eduardo Tolmasquim on 20/07/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var arrozStepper: UIStepper!
    @IBOutlet weak var arrozLabel: UILabel!
    @IBOutlet weak var paoStepper: UIStepper!
    @IBOutlet weak var paoLabel: UILabel!
    @IBOutlet weak var resultadoLabel: UILabel!
    
    var arrozQtd:Double = 0.0
    var paoQtd:Double = 0.0
    var resultado:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func arrozStepperChanged(sender: AnyObject) {
        arrozQtd = arrozStepper.value
        arrozLabel.text = "\(arrozQtd) Gramas"
        calculaResultado()
    }

    @IBAction func paoStepperChanged(sender: AnyObject) {
        paoQtd = paoStepper.value
        paoLabel.text = "\(paoQtd) Gramas"
        calculaResultado()
    }
    
    func calculaResultado() {
        var arrozKcal:Double = 0.0
        var paoKcal:Double = 0.0
        if let path = NSBundle.mainBundle().pathForResource("Alimentos", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                arrozKcal = dict["Arroz"] as! Double
                arrozKcal = arrozKcal/100
                paoKcal = dict["Pao"] as! Double
                paoKcal = paoKcal/100
            }
        }
        resultado = arrozQtd*arrozKcal + paoQtd*paoKcal
        resultadoLabel.text = "\(resultado) Kcal"
    }

}