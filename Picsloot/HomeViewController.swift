//
//  HomeViewController.swift
//  Picsloot
//
//  Created by think360 on 14/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!

    @IBOutlet weak var latestorderLab: UILabel!
    @IBOutlet weak var orderView: UIView!
    
    @IBOutlet weak var DateSentlab: UILabel!
    @IBOutlet weak var DateReceivedLab: UILabel!
    @IBOutlet weak var DateaddressLab: UILabel!
    @IBOutlet weak var DateCompleteLab: UILabel!
    
    @IBOutlet weak var picsCollectionView: UICollectionView!
     var cell: picsCell!
     var arrimages : NSMutableArray = ["1img","2img","3img","4img","5img"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         backButt.isHidden = true

       
        
        let boldAttribute = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName: UIColor.black
            ] as [String : Any]
        
        let regularAttribute = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName: UIColor.lightGray
            ] as [String : Any]
        
        let mutableAttributedString = NSMutableAttributedString()
        let regularAttributedString = NSAttributedString(string: "Date 22/09/2017, 6.00 PM, ", attributes: regularAttribute)
        let boldAttributedString = NSAttributedString(string: "5 images sent", attributes: boldAttribute)
        mutableAttributedString.append(regularAttributedString)
        mutableAttributedString.append(boldAttributedString)
        DateSentlab.attributedText = mutableAttributedString
        
        let mutableAttributedString2 = NSMutableAttributedString()
        let regularAttributedString2 = NSAttributedString(string: "Date 24/09/2017, 10.00 AM, ", attributes: regularAttribute)
        let boldAttributedString2 = NSAttributedString(string: "PicsLOOT Images Received", attributes: boldAttribute)
        mutableAttributedString2.append(regularAttributedString2)
        mutableAttributedString2.append(boldAttributedString2)
        DateReceivedLab.attributedText = mutableAttributedString2
        
        let mutableAttributedString3 = NSMutableAttributedString()
        let regularAttributedString3 = NSAttributedString(string: "Date 27/09/2017, 4.00 PM, ", attributes: regularAttribute)
        let boldAttributedString3 = NSAttributedString(string: "PicsLOOT Images Printout send your mentioned Address", attributes: boldAttribute)
        mutableAttributedString3.append(regularAttributedString3)
        mutableAttributedString3.append(boldAttributedString3)
        DateaddressLab.attributedText = mutableAttributedString3
        
        let mutableAttributedString4 = NSMutableAttributedString()
        let regularAttributedString4 = NSAttributedString(string: "Date 29/09/2017, 4.00 PM, ", attributes: regularAttribute)
        let boldAttributedString4 = NSAttributedString(string: "Order Complete", attributes: boldAttribute)
        mutableAttributedString4.append(regularAttributedString4)
        mutableAttributedString4.append(boldAttributedString4)
        DateCompleteLab.attributedText = mutableAttributedString4
        
        
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    @IBAction func ComposeOrderClicked(_ sender: Any)
    {
        
    }
    
    
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrimages.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picsCell", for: indexPath) as! picsCell
        
        let image:String = (arrimages[indexPath.row] as? String)!
        cell.picsImageView.image = UIImage(named: image)
     
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       
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
