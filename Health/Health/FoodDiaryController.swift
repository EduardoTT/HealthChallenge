//
//  FoodDiaryController.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/26/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class FoodDiaryController : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var myView : FoodDiaryView!;
    var meals = Array<MealModel>();
    var meals2 = Array<MealModel>();
    
    override func viewDidLoad() {
        
        for(var i=0; i<20; i++){
            meals.append(MealModel(photoString: "meal", date: NSDate()));
            meals2.append(MealModel(photoString: "meal", date: NSDate()));
        }
        
        println(meals.count);
        
        myView = FoodDiaryView(view: view, parent: self);
        myView.collectionView.delegate = self;
        myView.collectionView.dataSource = self;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 0.1*view.frame.height);
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count;
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if(kind == UICollectionElementKindSectionHeader){
            var header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "cellHeader", forIndexPath: indexPath) as! FoodCollectionHeaderView;
            //var header : FoodCollectionHeaderView =  collectionView.dequeueReusableCellWithReuseIdentifier("cellHeader", forIndexPath: indexPath) as! FoodCollectionHeaderView;
            let str = "Alimentos" + String(indexPath.section);
            header.title.text = str;
            return header;
        }
        let reu : UICollectionReusableView = UICollectionReusableView();
        return reu;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : FoodDiaryCell =  collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier", forIndexPath: indexPath) as! FoodDiaryCell;
        cell.setUpCell();
        cell.imageView.image = UIImage(named: meals[indexPath.row].photoString);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("OH YEAH");
    }
    
}
