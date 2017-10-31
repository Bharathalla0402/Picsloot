//
//  ConfirmOrderViewController.swift
//  Picsloot
//
//  Created by think360 on 16/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class ConfirmOrderViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    
    @IBOutlet weak var Addresslab: UILabel!
    
    var straddress = String()
    
    @IBOutlet weak var picsCollectionView: UICollectionView!
    var cell: picsCell!
    var arrimages = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults: UserDefaults? = UserDefaults.standard
        let data = defaults?.object(forKey: "Images") as? Data
        arrimages = NSKeyedUnarchiver.unarchiveObject(with: data!) as! NSMutableArray
        
        Addresslab.text = straddress
    }
    
    
    
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    //MARK: Edit Butt clicked:
    
    @IBAction func EditButtClicked(_ sender: Any)
    {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrimages.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picsCell", for: indexPath) as! picsCell
        
       // let image:String = (arrimages[indexPath.row] as? String)!
       // cell.picsImageView.image = UIImage(named: image)
        cell.picsImageView.image = arrimages[indexPath.row] as? UIImage
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }

    
    
    
     //MARK: Confirm Order Butt clicked:
    
    @IBAction func ConfirmOrderClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController") as? UploadViewController
        myVC?.hidesBottomBarWhenPushed=true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    // MARK: - Back Butt Clicked
    
    @IBAction func BackButtClicked(_ sender: Any)
    {
        _ = self.navigationController?.popViewController(animated: true)
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
