//
//  AddMoreTestViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 18/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import SDWebImage

class AddTestCell: UITableViewCell
{
    @IBOutlet weak var testName: UILabel!
    @IBOutlet weak var addedImage: UIImageView!
}


class AddMoreTestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var addedTestCount: UILabel!
    @IBOutlet weak var nameTestlab: UILabel!

    @IBOutlet weak var testTabl: UITableView!
    
     var cell:AddTestCell!
    var Fbcell: UITableViewCell?
    
     var ItemlistArray : NSMutableArray = ["Urine Routine Examination","KFT (kidney Function Test)","CBC (Complete Blood Counts)","LFT(Liver Function Test)","HbA1c(Glycated Hemoglobin)","CFC(Complete Function Counts)"]
    
    var popview = UIView()
    var footerView = UIView()
    var popview2 = UIView()
    var footerView2 = UIView()
    var arryDatalistids = NSMutableArray()
    var arrChildCategory : NSMutableArray = ["Urine Routine Examination","KFT (kidney Function Test)","CBC (Complete Blood Counts)","LFT(Liver Function Test)","HbA1c(Glycated Hemoglobin)","CFC(Complete Function Counts)"]
    var searchResults = NSMutableArray()
    
    @IBOutlet var MoretestTblView: UITableView!
    var theSearchBar: UISearchBar?
    
    
    var imagePicker = UIImagePickerController()
    var currentSelectedImage = UIImage()
    @IBOutlet weak var cameraButton: UIButton!
    
    var scroolMain = UIScrollView()
    var imageCollection = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTabl.tableFooterView = UIView()
        
        addedTestCount.text = String(arryDatalistids.count)
        
        imagePicker.delegate = self
       

        // Do any additional setup after loading the view.
    }

    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    @IBAction func AddMoreButtClicked(_ sender: Any)
    {
         self.addmoretestClicked()
    }
    
    
    func addmoretestClicked ()
    {
        popview.isHidden=false
        footerView.isHidden=false
        
       // arryDatalistids.removeAllObjects()
        
        popview.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview)
        
        footerView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        footerView.backgroundColor = UIColor.white
        popview.addSubview(footerView)
        
        let bglab = UILabel()
        bglab.frame = CGRect(x:0, y:0, width:footerView.frame.size.width, height:64)
        bglab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        footerView.addSubview(bglab)
        
        let forgotlab = UILabel()
        forgotlab.frame = CGRect(x:0, y:13, width:footerView.frame.size.width, height:51)
        forgotlab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        forgotlab.text="Add Test"
        forgotlab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        forgotlab.textColor=#colorLiteral(red: 0.1454493999, green: 0.2132318318, blue: 0.9278818965, alpha: 1)
        forgotlab.textAlignment = .center
        footerView.addSubview(forgotlab)
        
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:8, y:27, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "Back"), for: .normal)
        crossbutt.addTarget(self, action: #selector(AddMoreTestViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:footerView.frame.size.width-50, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(AddMoreTestViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView.addSubview(crossbutt2)
        
        
        MoretestTblView = UITableView()
        MoretestTblView.frame = CGRect(x: 0, y: 64, width: footerView.frame.size.width, height: footerView.frame.size.height-114)
        MoretestTblView.delegate = self
        MoretestTblView.dataSource = self
        MoretestTblView.tag = 1
        MoretestTblView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        MoretestTblView.backgroundColor = UIColor.clear
        MoretestTblView.tableFooterView = UIView()
        MoretestTblView.separatorStyle = .none
        MoretestTblView.separatorColor = UIColor.clear
        footerView.addSubview(MoretestTblView)
        
        
        
        theSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        theSearchBar?.delegate = self
        theSearchBar?.placeholder = "Search Test"
        theSearchBar?.showsCancelButton = false
        MoretestTblView.tableHeaderView = theSearchBar
        theSearchBar?.isUserInteractionEnabled = true
        
        
        let submitlab = UILabel()
        submitlab.frame = CGRect(x:0, y:footerView.frame.size.height-50, width:footerView.frame.size.width, height:50)
        submitlab.text="Submit"
        submitlab.backgroundColor=#colorLiteral(red: 0.143925637, green: 0.1810115576, blue: 0.9281523824, alpha: 1)
        submitlab.font =  UIFont(name:"Helvetica", size: 17)
        submitlab.textColor=UIColor.white
        submitlab.textAlignment = .center
        footerView.addSubview(submitlab)
        
        let submitbutt = UIButton()
        submitbutt.frame = CGRect(x:0, y:footerView2.frame.size.height-50, width:footerView2.frame.size.width, height:50)
        submitbutt.addTarget(self, action: #selector(AddMoreTestViewController.SubmitButtonAction2(_:)), for: UIControlEvents.touchUpInside)
        footerView.addSubview(submitbutt)
    }
    
    func CloseButtonAction(_ sender: UIButton!)
    {
        popview.isHidden=true
        footerView.isHidden=true
        
      //  self.arrChildCategory.removeAllObjects()
      //  self.searchResults.removeAllObjects()
        MoretestTblView.removeFromSuperview()
    }
    
    
    func SubmitButtonAction2(_ sender: UIButton!)
    {
        popview.isHidden=true
        footerView.isHidden=true
        
        //  self.arrChildCategory.removeAllObjects()
        //  self.searchResults.removeAllObjects()
        MoretestTblView.removeFromSuperview()
        
        
        testTabl.reloadData()
        
        addedTestCount.text = String(arryDatalistids.count)
    }
    
    
    
    
    //  MARK: searchbar Delegates and Datasource:
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchResults.count != 0 {
            self.searchResults.removeAllObjects()
            MoretestTblView.tag = 1
        }
        for i in 0..<arrChildCategory.count {
            // [searchResults removeAllObjects];
//            let string: String = (self.arrChildCategory.object(at: i) as! NSDictionary).value(forKey: "first_name") as! String
            let string: String = (arrChildCategory[i] as? String)!
            let rangeValue: NSRange = (string as NSString).range(of: searchText, options: .caseInsensitive)
            if rangeValue.length > 0
            {
                MoretestTblView.tag = 2
                searchResults.add(arrChildCategory[i])
            }
            else
            {
                
            }
        }
        MoretestTblView.reloadData()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
    {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        theSearchBar?.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    

    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.tag == 2
        {
            return searchResults.count
        }
        else if tableView.tag == 1
        {
            return arrChildCategory.count
        }
        else
        {
         return ItemlistArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView.tag == 2
        {
            let cellIdetifier: String = "Cell"
            Fbcell = UITableViewCell(style: .default, reuseIdentifier: cellIdetifier)
            
            
            let userName = UILabel()
            userName.frame = CGRect(x:10, y:7, width:(self.view.frame.size.width-50), height:36)
            userName.text=(searchResults[indexPath.row] as? String)!
            userName.font =  UIFont(name:"Helvetica", size: 15)
            userName.textColor=UIColor.black
            userName.textAlignment = .left
            userName.numberOfLines = 0
            Fbcell?.addSubview(userName)
            
            
            let checkImage = UIImageView()
            checkImage.frame = CGRect(x:self.view.frame.size.width-40, y:10, width:30, height:30)
            let VolunteerID: String = (searchResults[indexPath.row] as? String)!
            if arryDatalistids.contains(VolunteerID)
            {
                checkImage.image = UIImage(named: "Added")
            }
            else
            {
                checkImage.image = UIImage(named: "AddPlus")
            }
            Fbcell?.addSubview(checkImage)
            
             return Fbcell!
        }
        else if tableView.tag == 1
        {
            let cellIdetifier: String = "Cell"
            Fbcell = UITableViewCell(style: .default, reuseIdentifier: cellIdetifier)
            
            
            let userName = UILabel()
            userName.frame = CGRect(x:10, y:7, width:(self.view.frame.size.width-50), height:36)
            userName.text=(arrChildCategory[indexPath.row] as? String)!
            userName.font =  UIFont(name:"Helvetica", size: 15)
            userName.textColor=UIColor.black
            userName.textAlignment = .left
            userName.numberOfLines = 0
            Fbcell?.addSubview(userName)
            
            
            let checkImage = UIImageView()
            checkImage.frame = CGRect(x:self.view.frame.size.width-40, y:10, width:30, height:30)
            let VolunteerID: String = (arrChildCategory[indexPath.row] as? String)!
            if arryDatalistids.contains(VolunteerID)
            {
                checkImage.image = UIImage(named: "Added")
            }
            else
            {
                checkImage.image = UIImage(named: "AddPlus")
            }
            Fbcell?.addSubview(checkImage)
            
            return Fbcell!

        }
        else
        {
            let identifier = "AddTestCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddTestCell
            
            if cell == nil
            {
                tableView.register(UINib(nibName: "AddTestCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddTestCell
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            testTabl.separatorStyle = .none
            testTabl.separatorColor = UIColor.clear
            
            cell.testName.text = ItemlistArray[indexPath.row] as? String
            
            let VolunteerID: String = (ItemlistArray[indexPath.row] as? String)!
            if arryDatalistids.contains(VolunteerID)
            {
                cell.addedImage.image = UIImage(named: "Added")
            }
            else
            {
                cell.addedImage.image = UIImage(named: "AddPlus")
            }

            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.tag == 2
        {
            let VolunteerID:String = (searchResults[indexPath.row] as? String)!
            
            if arryDatalistids.contains(VolunteerID)
            {
                arryDatalistids.remove(VolunteerID)
            }
            else
            {
                arryDatalistids.add(VolunteerID)
            }
            MoretestTblView.reloadData()
        }
        else if tableView.tag == 1
        {
            let VolunteerID:String = (arrChildCategory[indexPath.row] as? String)!
            
            if arryDatalistids.contains(VolunteerID)
            {
                arryDatalistids.remove(VolunteerID)
            }
            else
            {
                arryDatalistids.add(VolunteerID)
            }
            MoretestTblView.reloadData()
        }
        else
        {
            let VolunteerID:String = (ItemlistArray[indexPath.row] as? String)!
            
            if arryDatalistids.contains(VolunteerID)
            {
                arryDatalistids.remove(VolunteerID)
            }
            else
            {
                arryDatalistids.add(VolunteerID)
            }
            testTabl.reloadData()
            
             addedTestCount.text = String(arryDatalistids.count)
        }
        
      //  MoretestTblView.reloadData()
      //  testTabl.reloadData()
        
    }

    
    
    
    
    @IBAction func TestSelectedButtClicked(_ sender: Any)
    {
//        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AdviceTestViewController") as? AdviceTestViewController
//        myVC?.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(myVC!, animated: true)
        
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddPrescriptionButtClicked(_ sender: Any)
    {
        
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is PatientDetailViewController {
                _ = self.navigationController?.popToViewController(vc as! PatientDetailViewController, animated: true)
            }
        }
        
 
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
