//
//  FoodReportView.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/27/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class FoodReportView : UIView{
    
    var picker : UIPickerView!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        let backImg = UIImageView(frame: view.frame);
        backImg.image = UIImage(named: "backTexture");
        view.addSubview(backImg);
        
        picker = UIPickerView(frame: CGRect(x: 0.3*view.frame.width, y: 0.05*view.frame.height, width: 0.4*view.frame.width, height: 0.01*view.frame.height));
        
        view.addSubview(picker);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
