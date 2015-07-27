//
//  MealModel.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/26/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import Foundation

class MealModel{
    
    var photoString : String!;
    var date : NSDate!;
    
    init(photoString : String, date : NSDate){
        self.photoString = photoString;
        self.date = date;
    }
    
    init(){
        
    }
}