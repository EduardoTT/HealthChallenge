//
//  FoodCollectionHeaderView.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/27/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class FoodCollectionHeaderView : UICollectionReusableView{
    
    var title : UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        title = UILabel(frame: CGRect(origin: CGPointZero, size: frame.size));
        title.backgroundColor = UIColor.redColor();
        addSubview(title);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
