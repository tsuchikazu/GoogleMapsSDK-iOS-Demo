//
//  ViewController.swift
//  MapDemo
//
//  Created by 土屋 和良 on 2014/09/09.
//  Copyright (c) 2014年 Kazuyoshi Tsuchiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        self.googleMapView.camera = camera
        self.googleMapView.settings.myLocationButton = true
        self.googleMapView.myLocationEnabled = true
        self.googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: overlayHeight, right: 0)
        self.googleMapView.addSubview(detailCollectionView)
        
        // Creates a marker in the center of the map.
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
        marker.title = "Sydney";
        marker.snippet = "Australia";
        marker.map = self.googleMapView
        
        
        // STCustomCollectionView.xibを指定して（.xibは省略）、UINibオブジェクトを生成
        var nib: UINib = UINib(nibName: "DetailCollectionViewCell", bundle: nil)
        // UICollectionViewに項目表示に使うセルとして登録
        self.detailCollectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        self.detailCollectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.detailCollectionView.dataSource = self;
        self.detailCollectionView.delegate = self;

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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for cell in self.detailCollectionView.visibleCells() {
            var cell = cell as UICollectionViewCell
            var offset = self.detailCollectionView.contentOffset
            
            var centerX = self.view.frame.size.width / 2
            var nowCellX = cell.frame.origin.x - offset.x
            var nowCellLeftX = nowCellX + cell.frame.width
            if nowCellX < centerX && centerX < nowCellLeftX {
                var index = self.detailCollectionView.indexPathForCell(cell as UICollectionViewCell)
                println(index)
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // セルの大きさ
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 70)
    }
    // 周りの間
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // セルの間
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    // よくわからん
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 100
//    }
    
}

