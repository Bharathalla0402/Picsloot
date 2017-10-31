//
//  ConfirmPicsViewController.swift
//  Picsloot
//
//  Created by think360 on 16/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit


class ConfirmPicsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,CreolePhotoSelectionDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var PicsCollectionView: UICollectionView!
    @IBOutlet weak var imageCount: UILabel!
    
    var cell: picsCell!
    var arrimages = NSMutableArray()
    var arrImage = NSMutableArray()
    var arrimglist = NSMutableArray()
    var chosenImages = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        backButt.isHidden = true
        
        let defaults: UserDefaults? = UserDefaults.standard
        let data = defaults?.object(forKey: "Images") as? Data
        arrimages = NSKeyedUnarchiver.unarchiveObject(with: data!) as! NSMutableArray
        
        //arrimages = (UserDefaults.standard.object(forKey: "Images") as! NSArray)
        
        print(arrimages)
        

        // Do any additional setup after loading the view.
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    

    
    
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrimages.count
    }
    
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picsCell", for: indexPath) as! picsCell
        
        
        cell.picsImageView.image = arrimages[indexPath.row] as? UIImage
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let objPhotoViewController = CreolePhotoSelection(nibName: "CreolePhotoSelection", bundle: nil)
        let navController = UINavigationController(rootViewController: objPhotoViewController as? UIViewController ?? UIViewController())
        objPhotoViewController.strTitle = "Choose Photos"
        objPhotoViewController.delegate = self
        objPhotoViewController.arySelectedPhoto = arrimages
        objPhotoViewController.maxCount = 6
        navigationController?.present(navController, animated: true) { _ in }
    }
    

    func getSelectedPhoto(_ aryPhoto: [Any])
    {
//        arrImage = [arrImage .removeAllObjects()]
//        arrImage = [Any]()
//        arrImage = aryPhoto
//        //mainImage, Asset,     selected
//        arrimglist = nil
//        arrimglist = [Any]()
//        let numberOfImages: Int = arrImage.count
//        for i in 0..<numberOfImages {
//            var image: UIImage?
//            image = arrImage[i].value(forKey: "mainImage") as? UIImage
//            var arr = [Any]()
//            arr.append(image)
//            arrimglist = arrimglist + arr
//            //mainImage, Asset, selected
//            print("\(arrimglist)")
//        }
    }
    

    @IBAction func UploadImagesButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryAddressViewController") as? DeliveryAddressViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
