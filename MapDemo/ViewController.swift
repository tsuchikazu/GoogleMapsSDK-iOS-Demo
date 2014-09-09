//
//  ViewController.swift
//  MapDemo
//
//  Created by 土屋 和良 on 2014/09/09.
//  Copyright (c) 2014年 Kazuyoshi Tsuchiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let overlayHeight: CGFloat = 140
    var mapView: GMSMapView?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        var camera: GMSCameraPosition =
            GMSCameraPosition.cameraWithLatitude(-33.86, longitude:151.20, zoom:6);
        self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        self.mapView!.settings.myLocationButton = true;
        self.mapView!.myLocationEnabled = true;
        self.mapView!.padding = UIEdgeInsets(top: 0, left: 0, bottom: overlayHeight, right: 0)
        self.view = self.mapView!;
        
        // Creates a marker in the center of the map.
        var marker = GMSMarker()

        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
        marker.title = "Sydney";
        marker.snippet = "Australia";
        marker.map = self.mapView;
        
        
        var overlayFrame: CGRect = CGRect(x: 0, y: -overlayHeight, width: 0, height: overlayHeight)
        var overlay = UIView(frame: overlayFrame)
        overlay.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth;
        
        overlay.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 0.5)
        self.view.addSubview(overlay)
        
        
        var topLevelObjects: NSArray = NSBundle.mainBundle().loadNibNamed("SmallWindow", owner: self, options: nil)
        var smallWindowView = topLevelObjects[0] as UIView
        self.view.addSubview(smallWindowView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

