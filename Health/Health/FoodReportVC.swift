//
//  FoodReportController.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/27/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class FoodReportVC : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var myView : FoodReportView!;
    var data : [String] = ["Calories", "Lipidium", "Protein"];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        myView = FoodReportView(view: view, parent: self);
        myView.picker.delegate = self;
        myView.picker.dataSource = self;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data[row];
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count;
    }
    
}
