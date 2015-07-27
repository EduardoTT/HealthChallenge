////
//  FoodCompositionView.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/22/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import  SpriteKit

class FoodCompositionView : UIView{

    //var imgView : UIImageView!;
    var imgView : SKSpriteNode!;
    
    init(view: UIView) {
        super.init(frame: view.frame);
        
        let mySize = getBestSquare(view.frame);
        
        imgView = SKSpriteNode(imageNamed: "meal");
        imgView.position = CGPoint(x: view.frame.width-0.5*mySize, y: view.frame.height-0.5*mySize);
        imgView.size = CGSize(width: mySize, height: mySize);
        
//        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: mySize, height: mySize));
//        imgView.image = UIImage(named: "meal");
//        imgView.layer.zPosition = -5;
        
        //view.addSubview(imgView);
        
        let testView = UIButton(frame: CGRect(x: 0, y: 0.8*view.frame.height, width: 0.5*view.frame.width, height: 0.2*view.frame.height));
        testView.backgroundColor = UIColor.redColor();
        testView.addTarget(self, action: "rekt:", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(testView);
        
    }
    
    func rekt(button : UIButton){
        println("Touched");
    }
    
    private func getBestSquare(inFrame : CGRect) -> CGFloat{
        return (inFrame.width > inFrame.height) ? inFrame.height : inFrame.width;
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}