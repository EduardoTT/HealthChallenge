//
//  PageVC.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/27/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class PageVC : UIPageViewController{
    
    override func viewDidLoad() {
        setViewControllers([FoodReportVC(),FoodDiaryController(),FoodCompositionVC()], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil);
        
    }
    
}
