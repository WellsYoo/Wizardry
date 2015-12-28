//
//  PhotoGridViewController.swift
//  Wizardry
//
//  Created by YWH on 15/12/26.
//  Copyright © 2015年 YWH. All rights reserved.
//

import UIKit
import Photos

class PhotoGridViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var galleryTitleLabel: UILabel!
    
    var galleryTitle: String?
     let scale = UIScreen.mainScreen().scale
    var collection:PHAssetCollection?
    var fetchResult:PHFetchResult?

 
    
    let gridWidth = (UIScreen.mainScreen().bounds.size.width - 3)/4

    lazy var imageManager:PHCachingImageManager = {
        
        return PHCachingImageManager()
    }()

//     init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//  
//    required init?(coder aDecoder: NSCoder) {
//        print("init PhotoGridViewController")
//        super.init(coder: aDecoder)
//    }
//    
//    deinit {
//        print("deinit PhotoGridViewController")
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryTitleLabel.text = galleryTitle
//        fetchResult = PHAsset.fetchAssetsInAssetCollection(collection!, options: nil)
        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PhotoGridViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (fetchResult?.count)!
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let photoCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCollectionCell", forIndexPath: indexPath) as! PhotoCollectionCell
         let asset = fetchResult![indexPath.row]
        
        imageManager .requestImageForAsset(asset as! PHAsset, targetSize: CGSize(width: gridWidth*scale, height: gridWidth*scale), contentMode: .AspectFill, options: nil, resultHandler: { (image, info) -> Void in
            photoCollectionCell.photoThum.image = image
        })

        return photoCollectionCell
    }

      func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(gridWidth, gridWidth*1.02)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
       return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
 //    collection

}