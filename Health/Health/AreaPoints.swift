//
//  AreaPoints.swift
//  Health
//
//  Created by Pietro Ribeiro Pepe on 7/25/15.
//  Copyright (c) 2015 Eduardo Tolmasquim. All rights reserved.
//

import SpriteKit

class AreaPoints : NSMutableDictionary{
    
    //var points = [[CGPoint]]();
    //var shapes =
    
    func insertNewArea(points : [CGPoint], shape : CGMutablePathRef, id : String){
        if(self[id] == nil){
            var pointsMatrix = Array<Array<CGPoint>>();
            pointsMatrix.append(points);
            var shapesArray = Array<CGMutablePathRef>();
            shapesArray.append(shape);
            self[id] = NSMutableDictionary(objects: [pointsMatrix as! AnyObject,shapesArray as AnyObject], forKeys: ["points","shapes"]);
        }
        else{
            var shapes = ((self[id] as! NSMutableDictionary)["shapes"] as! Array<CGMutablePathRef>)
            shapes.append(shape);
            var pointsMatrix = ((self[id] as! NSMutableDictionary)["points"] as! Array<Array<CGPoint>>);
            pointsMatrix.append(points);
        }
    }
    
    func calculateAreas()->NSMutableDictionary{
        var areaDict = NSMutableDictionary();
        for (id,dict) in self{
            var totalArea : CGFloat = 0;
            let pointsMatrix = (dict as! NSMutableDictionary)["points"] as! Array<Array<CGPoint>>;
            let shapes = (dict as! NSMutableDictionary)["shapes"] as! Array<CGMutablePathRef>;
            for (var i:Int=0; i<pointsMatrix.count; i++){
                totalArea += calculateArea(shapes[i], points: pointsMatrix[i]);
            }
            areaDict.setObject(totalArea, forKey: id as! String);
        }
        return areaDict;
    }
    
    private func calculateArea(path : CGMutablePathRef, points : [CGPoint]) -> CGFloat{
        let areaRect = CGPathGetBoundingBox(path);
        let origin = CGPoint(x: ceil(areaRect.origin.x), y: ceil(areaRect.origin.y))
        let end = CGPoint(x: floor(areaRect.maxX),y: floor(areaRect.maxY));
        let areaBox = CGRect(origin: origin, size: CGSize(width: end.x-origin.x, height: end.y-origin.y));
        
        var pointsMatrix = Array<Array<Bool>>();
        var i:CGFloat = 0; var j:CGFloat = 0;
        for(i=0;i < areaBox.width; i++){
            for(j=0;j < areaBox.height; j++){
                pointsMatrix[Int(i)][Int(j)] = false;
            }
        }
        for point in points{
            pointsMatrix[Int(point.x-origin.x)][Int(point.y-origin.y)] = true;
        }
        
        var area : CGFloat;
        var totalArea : CGFloat = 0;
        var onArea : Bool;
        var value : Bool;
        var lastValue = false;
        for(j=0; j < areaBox.height; j++){
            onArea = false;
            area=0;
            for(i=0; i < areaBox.width; i++){
                value = pointsMatrix[Int(i)][Int(j)];
                if(onArea){ //Inside area of image
                    if(!value){
                        area++;
                    }
                    else{
                        if(!lastValue){
                            onArea = false;
                            totalArea += area;
                            area = 0;
                        }
                        else{
                            //Continuidade de barreira
                        }
                    }
                }
                else{ //outside area of image
                    if(value){
                        onArea=true;
                    }
                }
                lastValue = value;
            }
        }
        return totalArea;
    }
    
    
}
