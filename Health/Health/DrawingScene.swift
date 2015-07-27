//
//  DrawingScene.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/24/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

//
//  CreateDrawingScene.swift
//  BeArtCreate
//
//  Created by Pietro Ribeiro Pepe on 6/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class DrawingScene : SKScene{
    
    var myView : FoodCompositionView!;
    var drawingView : SKView!;
    var hasMoved = false;
    var pathClosed = false;
    var withinBox = true;
    var startLocation : CGPoint!;
    
    var tracos = [SKShapeNode]();
    
    let doneColor = UIColor.greenColor();
    let doingColor = UIColor.blackColor();
    
    var actualTrace : SKShapeNode!;
    var actualPath : CGMutablePathRef!;
    var initialPath : CGMutablePathRef!;
    //var actualPath : UIBezierPath!;
    
    var selectedColor : UIColor!;
    
    var points : [CGPoint]!;
    var pointsQuant : Int!;
    
    var pointsVector : [CGPoint]!;
    //var pointsMatrix :
    
    let endBoxSize = CGSizeMake(20, 20);
    var initBox : CGRect!;
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor();
        myView = FoodCompositionView(view: self.view!);
        addChild(myView.imgView);
        
        //drawingView = SKView(frame: myView.imgView.frame);
        //drawingView.layer.zPosition = 5;
        //self.view!.addSubview(drawingView);
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch;
        let location = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(location);
        if(touchedNode == myView.imgView){
            //AREA OF DRAWING
            startDrawingPathOnLocation(location);
            points = [CGPoint]();
            points.append(location);
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch;
        let location = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(location);
        if(touchedNode == myView.imgView){
            
            if(withinBox){
                //CONTAINS
                if(!CGRectContainsPoint(initBox, location)){
                    withinBox = false;
                }
            }
            else{
                if(!pathClosed && CGRectContainsPoint(initBox, location)){
                    pathClosed = true;
                }
            }
            
            points.append(location);
            
            let quant = points.count;
            println(quant)
            
            if(quant>=5){
                //let cp1 = points[quant-3], cp2 = points[quant-2];
                let cp1 = points[quant-4], cp2 = points[quant-3];
                let final = CGPointMake(0.5*(cp2.x+location.x), 0.5*(cp2.y+location.y));
                points[quant-2] = final;
                CGPathAddCurveToPoint(actualPath, nil, cp1.x, cp1.y, cp2.x, cp2.y, final.x, final.y);
                actualTrace.path = actualPath;
                points.removeAtIndex(0);
                points.removeAtIndex(0);
                points.removeAtIndex(0);
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if(hasMoved){
            actualTrace.strokeColor = doneColor;
            tracos.append(actualTrace);
            hasMoved = false;
        }
    }
    
    func getScreenImage() -> UIImage {
        // Setup our context
        let bounds = CGRect(origin: CGPoint.zeroPoint, size: self.view!.frame.size)
        let opaque = false
        let scale: CGFloat = 0
        println(self.view!.frame.size)
        //UIGraphicsBeginImageContext(self.view!.frame.size);
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, scale)
        //let context = UIGraphicsGetCurrentContext()
        // Drawing complete, retrieve the finished image and cleanup
        view?.drawViewHierarchyInRect(bounds, afterScreenUpdates: true);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        //UIGraphics
        UIGraphicsEndImageContext()
        return image
    }
    
    func startDrawingPathOnLocation(point : CGPoint){
        
        actualPath = CGPathCreateMutable();
        CGPathMoveToPoint(actualPath, nil, point.x, point.y);
        actualTrace = SKShapeNode(path: actualPath);
        actualTrace.strokeColor = doingColor;
        actualTrace.lineWidth = 4;
        
        addChild(actualTrace);
        //tracos.append(traco);
        
        initBox = CGRectMake(point.x-endBoxSize.width*0.5, point.y-endBoxSize.height*0.5, endBoxSize.width, endBoxSize.height);
        pathClosed = false;
        withinBox = true;
        startLocation = point;
    }
    
    func cancelAction(but : UIButton){
        
        for(var i=0; i<tracos.count; i++){
            let t = tracos.removeAtIndex(i--)
            t.removeFromParent();
        }
        
    }
    
    func eraseLast(but : UIButton){
        if(tracos.count > 0){
            let index = tracos.count-1;
            let lastTraco = tracos.removeAtIndex(index);
            lastTraco.removeFromParent();
        }
    }
    
}