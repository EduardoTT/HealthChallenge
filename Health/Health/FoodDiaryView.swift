//
//  FoodDiaryView.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/26/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import UIKit

class FoodDiaryView : UIView{
    
    var collectionView : UICollectionView!;
    //var upperView: UpperView!;
    var userPhoto : UIImageView!;
    
    var user2Photo : UIImageView!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        let collectionHeight:CGFloat = 0.767*view.frame.height;
        
        //var img:UIImageView = UIImageView(frame: view.frame);
        //img.image = UIImage(named: "noteBookSide");
        //view.addSubview(img);
        
        let spacing = 0.02*self.frame.width;
        
        let backImg = UIImageView(frame: view.frame);
        backImg.image = UIImage(named: "backTexture");
        view.addSubview(backImg);
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: view.frame.origin.y,
            left: view.frame.origin.x,
            bottom: 10,
            right: view.frame.origin.x);
        layout.itemSize = CGSizeMake(0.319*self.frame.width, 0.319*self.frame.width);
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        collectionView = UICollectionView(frame: CGRectMake(spacing, 0.26*view.frame.height, view.frame.width-spacing*2, 0.727*view.frame.height), collectionViewLayout: layout);
        collectionView.registerClass(FoodDiaryCell.self, forCellWithReuseIdentifier: "cellIdentifier");
        collectionView.backgroundColor = UIColor.clearColor();
        
        let plate = UIImage(named: "plate")!;
        
        userPhoto = UIImageView(frame: CGRect(x: 0, y: 0.03*view.frame.height, width: 0.2*view.frame.height, height: 0.2*view.frame.height));
        userPhoto.image = plate;
        
        let forkImg = UIImage(named: "Fork")!;
        let forkImgView = UIImageView(frame: CGRect(x: userPhoto.frame.maxX, y: userPhoto.frame.origin.y, width: forkImg.size.width * userPhoto.frame.height/forkImg.size.height, height: userPhoto.frame.height));
        forkImgView.image = forkImg;
        
        let knifeImg = UIImage(named: "Spoon")!;
        let kWidth = knifeImg.size.width * userPhoto.frame.height/knifeImg.size.height;
        let knifeImgView = UIImageView(frame: CGRect(x: collectionView.frame.maxX-kWidth, y: userPhoto.frame.origin.y, width: kWidth, height: userPhoto.frame.height));
        knifeImgView.image = knifeImg;
        
        let photoSize = 207.0*userPhoto.frame.width/plate.size.width;
        let origin = (userPhoto.frame.size.width-photoSize)*0.5;
        
        user2Photo = UIImageView(frame: CGRect(x: origin, y: origin, width: photoSize, height: photoSize));
        user2Photo.image = UIImage(named: "userMe");
        userPhoto.addSubview(user2Photo);
        user2Photo.clipsToBounds = true;
        user2Photo.layer.cornerRadius = user2Photo.frame.size.height/2;
        user2Photo.layer.masksToBounds = true;
        
//        userPhoto.layer.borderColor = UIColor.blackColor().CGColor;
//        userPhoto.layer.borderWidth = 3;
        
        //207
        
        view.addSubview(userPhoto);
        view.addSubview(forkImgView);
        view.addSubview(knifeImgView);
        
        //upperView = UpperView(view: view);
        
        //let lineHeight:CGFloat = 10;
        //var lineView : UIView = UIView (frame: CGRectMake(0, (upperView.frame.origin.y+upperView.frame.height+collectionView.frame.origin.y)*0.5-lineHeight, view.frame.width, lineHeight));
        //lineView.backgroundColor = UIColor.blackColor();
        
        view.addSubview(collectionView);
        //view.addSubview(upperView);
        //view.addSubview(lineView);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}