//
//  FoodCompositionVC.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/22/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import SpriteKit

class FoodCompositionVC : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //var myView:FoodCompositionView!;
    var myScene : DrawingScene!;
    
    override func viewDidLoad() {
        //myView = FoodCompositionView(view: view, parent: self);
        
        let skView = SKView(frame: view.frame)
        //skView.backgroundColor = UIColor.redColor();
        skView.backgroundColor = UIColor.redColor();
        skView.layer.zPosition = 2;
        myScene = DrawingScene();
        myScene.size = skView.frame.size;
        skView.presentScene(myScene)
        view.addSubview(skView);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        //takePhoto();
    }
    
    func takePhoto(){
        var vc:UIImagePickerController = UIImagePickerController();//ImagePickVC();
        vc.delegate = self;
        vc.allowsEditing = true;
        vc.sourceType = UIImagePickerControllerSourceType.Camera;
        presentViewController(vc, animated: true, completion: nil);
    }
    
    func selectPhoto(){
        var vc:UIImagePickerController = UIImagePickerController();//ImagePickVC();
        vc.delegate = self;
        vc.allowsEditing = true;
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        presentViewController(vc, animated: true, completion: nil);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        println("yoh");
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage;
        myScene.myView.imgView.texture = SKTexture(image: img);
        picker.dismissViewControllerAnimated(true, completion: nil);
        /*
        profImg = info[UIImagePickerControllerOriginalImage] as! UIImage;
        addView.cameraButton.selected = true;
        addView.cameraButton.setImage(profImg, forState: UIControlState.Selected);
        addView.cameraButton.setImage(profImg, forState: UIControlState.Normal);
        picker.dismissViewControllerAnimated(true, completion: nil);
        */
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        /*
        profImg = nil;
        addView.cameraButton.selected = false;
        addView.cameraButton.setImage(addView.cameraImage, forState: UIControlState.Normal);
        */
        tabBarController?.selectedIndex = (tabBarController as! MyTabBarController).lastIndex;
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
}