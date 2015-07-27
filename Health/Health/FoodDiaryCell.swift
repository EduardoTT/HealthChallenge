//
//  FoodDiaryCell.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/26/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class FoodDiaryCell : UICollectionViewCell{
    
    var topView: UIView!;
    var numberLabel: UILabel!;
    
    var checkBox: UIImageView!;
    var starIcon: UIImageView!;
    var imageView: UIImageView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    func setUpCell() {
        
        self.layer.borderWidth = 3;
        self.layer.borderColor = UIColor.blackColor().CGColor;
        
        topView = UIView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height*0.15));
        topView.backgroundColor = UIColor.whiteColor();
        
        numberLabel = UILabel(frame: CGRectMake(10, 0, 0.8*topView.frame.width-10, topView.frame.height));
        numberLabel.font = UIFont(name: "Marker Felt", size: 28);
        numberLabel.textColor = UIColor.blueColor();
        topView.addSubview(numberLabel);
        
        checkBox = UIImageView(frame: CGRectMake(0.85*topView.frame.width-5, 0, 0.15*topView.frame.width, 0.15*topView.frame.width));
        checkBox.alpha = 0.6;
        topView.addSubview(checkBox);
        
        starIcon = UIImageView(frame: CGRectMake(checkBox.frame.origin.x-checkBox.frame.width-5, checkBox.frame.origin.y, checkBox.frame.width, checkBox.frame.height));
        starIcon.tintColor = UIColor.yellowColor();
        //starIcon.image = UIImage(named: "star-2")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        starIcon.alpha = 0.65;
        topView.addSubview(starIcon);
        
        imageView = UIImageView(frame: CGRectMake(0,topView.frame.height, self.frame.width, self.frame.height-topView.frame.height));
        imageView.backgroundColor = UIColor.clearColor();
        //imageView.image = UIImage(named: "q139");
        imageView.contentMode = UIViewContentMode.ScaleToFill;
        imageView.clipsToBounds = true;
        imageView.layer.masksToBounds = true;
        imageView.layer.borderWidth = 0;
        
        contentView.addSubview(topView);
        contentView.addSubview(checkBox);
        contentView.addSubview(imageView);
        
        contentView.layer.borderColor = UIColor.redColor().CGColor;
        contentView.layer.borderWidth = 3;
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}