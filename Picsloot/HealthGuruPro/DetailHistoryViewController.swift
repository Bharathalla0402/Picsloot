//
//  DetailHistoryViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 15/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class detailHistoryCell: UITableViewCell
{
    @IBOutlet weak var testName: UILabel!
    @IBOutlet weak var ViewButt: UIButton!
    
}

class DetailHistoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
     var cell2: detailHistoryCell!
     var cell: PrescriptionCell!
    
     @IBOutlet weak var NotificationCount: UILabel!
    
    @IBOutlet weak var TestTabl: UITableView!
    @IBOutlet weak var testTablHeight: NSLayoutConstraint!
    
    //  var ItemlistArray = NSMutableArray()
    var ItemlistArray : NSMutableArray = ["Urine Routine Examination","Lipid Profile"]

    var popview2 = UIView()
    var footerView2 = UIView()
    
    @IBOutlet weak var prescriptionLab: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var PrescriptionCollectionView: UICollectionView!
    
    var scroolMain = UIScrollView()
    var imageCollection = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTablHeight.constant = 100
         TestTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ItemlistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "detailHistoryCell"
        cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? detailHistoryCell
        
        if cell2 == nil
        {
            tableView.register(UINib(nibName: "detailHistoryCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? detailHistoryCell
        }
        
        cell2.selectionStyle = UITableViewCellSelectionStyle.none
        TestTabl.separatorStyle = .none
        TestTabl.separatorColor = UIColor.clear
        
        cell2.testName.text = ItemlistArray[indexPath.row] as? String
       
        
        
        return cell2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        imagePopUp()
    }

    
    
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrescriptionCell", for: indexPath) as! PrescriptionCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        imagePopUp() 
    }
    
    func imagePopUp() -> Void
    {
        popview2.isHidden=false
        footerView2.isHidden=false
        
        // arryDatalistids.removeAllObjects()
        
        popview2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview2.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview2)
        
        footerView2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        footerView2.backgroundColor = UIColor.white
        popview2.addSubview(footerView2)
        
        let bglab = UILabel()
        bglab.frame = CGRect(x:0, y:0, width:footerView2.frame.size.width, height:64)
        bglab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        footerView2.addSubview(bglab)
        
        let forgotlab = UILabel()
        forgotlab.frame = CGRect(x:0, y:13, width:footerView2.frame.size.width, height:51)
        forgotlab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        forgotlab.text="Urine Routine Examination"
        forgotlab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        forgotlab.textColor=#colorLiteral(red: 0.143925637, green: 0.1810115576, blue: 0.9281523824, alpha: 1)
        forgotlab.textAlignment = .center
        footerView2.addSubview(forgotlab)
        
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:8, y:27, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "Cross"), for: .normal)
        crossbutt.addTarget(self, action: #selector(DetailHistoryViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:0, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(DetailHistoryViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt2)
        
       
        scroolMain.frame = CGRect(x:0, y:64, width:footerView2.frame.size.width, height:footerView2.frame.size.height-64)
        footerView2.addSubview(scroolMain)
        
        scroolMain.minimumZoomScale = 1.0
        scroolMain.maximumZoomScale = 6.0
        scroolMain.contentSize = CGSize(width: 1280, height: 960)
        scroolMain.delegate = self
        
       
        imageCollection.frame = CGRect(x:0, y:0, width:scroolMain.frame.size.width, height:scroolMain.frame.size.height)
        imageCollection.image = UIImage(named:"SampleDoc")
        imageCollection.contentMode = .scaleAspectFit
        scroolMain.addSubview(imageCollection)
    }
    
    
    func CloseButtonAction(_ sender: UIButton!)
    {
        popview2.isHidden=true
        footerView2.isHidden=true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return imageCollection
    }
    


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
