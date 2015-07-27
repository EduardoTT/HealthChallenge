//
//  MyTabBarController.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/26/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class MyTabBarController : UITabBarController, UITabBarControllerDelegate{
    
    var lastIndex = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let diary = FoodDiaryController();
        let newFood = FoodCompositionVC();
        let report = FoodReportVC();
        setViewControllers([diary,newFood,report], animated: true);
    
        diary.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(named: "user")!, tag: 1);
        newFood.tabBarItem = UITabBarItem(title: "NewFood", image: UIImage(named: "camera")!, tag: 2);
        report.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "clipboard"), tag: 3);
        
        self.delegate = self;
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if(selectedIndex != 1){
            lastIndex = selectedIndex;
        }
        else{
            (viewController as! FoodCompositionVC).takePhoto();
        }
    }
    
}
