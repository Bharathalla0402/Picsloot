//
//  OrderViewController.swift
//  Picsloot
//
//  Created by think360 on 14/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class OrdersCell: UITableViewCell
{
    @IBOutlet weak var DateSentLab: UILabel!
    @IBOutlet weak var DatesentImg: UIImageView!
    @IBOutlet fileprivate weak var imagelistCollectionView: UICollectionView!
    @IBOutlet weak var DateReceivedLab: UILabel!
    @IBOutlet weak var DateReceivedImage: UIImageView!
    @IBOutlet weak var DateAddressLab: UILabel!
    @IBOutlet weak var DateAddressImg: UIImageView!
    @IBOutlet weak var DateCompleteLab: UILabel!
    @IBOutlet weak var DateCompleteImg: UIImageView!
    
     
    
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        imagelistCollectionView.tag = row
        imagelistCollectionView.setContentOffset(imagelistCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        imagelistCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { imagelistCollectionView.contentOffset.x = newValue }
        get { return imagelistCollectionView.contentOffset.x }
    }

}

class picsCell: UICollectionViewCell
{
    @IBOutlet weak var picsImageView: UIImageView!
}


class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
     var storedOffsets = [Int: CGFloat]()
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var ordersTabl: UITableView!
    
    var Cell: OrdersCell!
    var Cell2 : picsCell!
    
    
    let tblAry = ["0","1","2","3"]
    let nameArry = [["1img","2img","3img","4img","5img"],
                    ["1img","2img","3img","4img","5img"],
                    ["1img","2img","3img","4img","5img"],
                    ["1img","2img","3img","4img","5img"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButt.isHidden = true
        
        ordersTabl.rowHeight = UITableViewAutomaticDimension
        ordersTabl.estimatedRowHeight = 274
        ordersTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    //MARK: TableView Delegates and Datasource:
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
             return 1
        }
        else if section == 1
        {
           return tblAry.count
        }
        return tblAry.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            return "LATEST ORDER"
        }
        else
        {
            return "ORDER HISTORY"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "OrdersCell"
        Cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? OrdersCell
        
        if Cell == nil
        {
            tableView.register(UINib(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: identifier)
            Cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? OrdersCell
        }
        
        Cell.selectionStyle = UITableViewCellSelectionStyle.none
        ordersTabl.separatorStyle = .none
        ordersTabl.separatorColor = UIColor.clear
        
        
        
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
        Cell.DateSentLab.attributedText = mutableAttributedString
        
        let mutableAttributedString2 = NSMutableAttributedString()
        let regularAttributedString2 = NSAttributedString(string: "Date 24/09/2017, 10.00 AM, ", attributes: regularAttribute)
        let boldAttributedString2 = NSAttributedString(string: "PicsLOOT Images Received", attributes: boldAttribute)
        mutableAttributedString2.append(regularAttributedString2)
        mutableAttributedString2.append(boldAttributedString2)
        Cell.DateReceivedLab.attributedText = mutableAttributedString2
        
        let mutableAttributedString3 = NSMutableAttributedString()
        let regularAttributedString3 = NSAttributedString(string: "Date 27/09/2017, 4.00 PM, ", attributes: regularAttribute)
        let boldAttributedString3 = NSAttributedString(string: "PicsLOOT Images Printout send your mentioned Address", attributes: boldAttribute)
        mutableAttributedString3.append(regularAttributedString3)
        mutableAttributedString3.append(boldAttributedString3)
        Cell.DateAddressLab.attributedText = mutableAttributedString3
        
        let mutableAttributedString4 = NSMutableAttributedString()
        let regularAttributedString4 = NSAttributedString(string: "Date 29/09/2017, 4.00 PM, ", attributes: regularAttribute)
        let boldAttributedString4 = NSAttributedString(string: "Order Complete", attributes: boldAttribute)
        mutableAttributedString4.append(regularAttributedString4)
        mutableAttributedString4.append(boldAttributedString4)
        Cell.DateCompleteLab.attributedText = mutableAttributedString4
        
       
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard Cell == cell as? OrdersCell else { return }
        
        Cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        Cell.collectionViewOffset = storedOffsets[indexPath.section] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard cell == cell as? OrdersCell else { return }
        
        storedOffsets[indexPath.section] = Cell.collectionViewOffset
    }

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
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

//MARK: CollectionView Delegates:
extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (nameArry[collectionView.tag]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        Cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "picsCell", for: indexPath) as! picsCell
        
        
        Cell2.picsImageView.image = UIImage(named: "\((nameArry[collectionView.tag])[indexPath.item])")
        
        
        return Cell2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath.row)")
    }
}
