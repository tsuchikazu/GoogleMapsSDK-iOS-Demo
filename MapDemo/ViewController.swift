//
//  ViewController.swift
//  MapDemo
//
//  Created by 土屋 和良 on 2014/09/09.
//  Copyright (c) 2014年 Kazuyoshi Tsuchiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    let overlayHeight: CGFloat = 140

                            
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        var camera: GMSCameraPosition =
            GMSCameraPosition.cameraWithLatitude(-33.86, longitude:151.20, zoom:6);
//        var mapView: GMSMapView = GMSMapView.mapWithFrame(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), camera: camera)
        self.googleMapView.settings.myLocationButton = true
        self.googleMapView.myLocationEnabled = true
        self.googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: overlayHeight, right: 0)
        self.googleMapView.addSubview(detailCollectionView)
//        self.googleMapView = mapView
        
        // Creates a marker in the center of the map.
        var marker = GMSMarker()

        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
        marker.title = "Sydney";
        marker.snippet = "Australia";
//        marker.map = mapView;
        
        
//        var overlayFrame: CGRect = CGRect(x: 0, y: self.view.frame.size.height - 100, width: self.view.frame.size.width, height: 100)
//        var overlay = UIView(frame: overlayFrame)
//        overlay.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth;
//        
//        overlay.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)
//        self.view.addSubview(overlay)
        
        self.detailCollectionView.dataSource = self;
        self.detailCollectionView.delegate = self;
        // STCustomCollectionView.xibを指定して（.xibは省略）、UINibオブジェクトを生成
        var nib: UINib = UINib(nibName: "DetailCollectionViewCell", bundle: nil)
        // UICollectionViewに項目表示に使うセルとして登録
        self.detailCollectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
//        self.detailCollectionView.setCollectionViewLayout(DetailCollectionViewLayout(), animated: true)
        
//        
//        var topLevelObjects: NSArray = NSBundle.mainBundle().loadNibNamed("SmallWindow", owner: self, options: nil)
//        var smallWindowView = topLevelObjects[0] as UIView
//        self.view.addSubview(smallWindowView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // セルオブジェクトを得る
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as DetailCollectionViewCell
        
        //let record = self.items[indexPath.row] as CKRecord
        //cell.textLabel!.text = record.objectForKey("title") as? String
        cell.labelTrackName.text = "artist name"
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            
            
            let url               = "http://a5.mzstatic.com/us/r30/Music/v4/90/3f/c8/903fc88b-1552-48a3-f7d8-8f690e4bb94f/2400fixEDMitunes.600x600-75.jpg"
            let imageURL: NSURL   = NSURL.URLWithString(url)
            let imageData: NSData = NSData(contentsOfURL: imageURL)
            let image = UIImage(data: imageData)
            
            let url2 = "https://pbs.twimg.com/profile_images/3464405875/49d6b6ba83491fb6addfa61b607e5bde_bigger.png"
            let imageURL2 = NSURL.URLWithString(url2)
            let imageData2: NSData = NSData(contentsOfURL: imageURL2)
            let image2 = UIImage(data: imageData2)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.imageViewForArtwork.image = image
                cell.imageViewForIcon.image = image2
            })
        }

        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

