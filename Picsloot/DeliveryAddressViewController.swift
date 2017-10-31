//
//  DeliveryAddressViewController.swift
//  Picsloot
//
//  Created by think360 on 16/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class DeliveryAddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var txtAddress: ACFloatingTextfield!
    @IBOutlet weak var txtState: ACFloatingTextfield!
    @IBOutlet weak var txtCity: ACFloatingTextfield!
    @IBOutlet weak var txtPincode: ACFloatingTextfield!
    @IBOutlet weak var txtComment: ACFloatingTextfield!
    
    var popview2 = UIView()
    var footerView2 = UIView()
    
    var popview3 = UIView()
    var footerView3 = UIView()
    
      var stateIDstr = NSString()
    
    @IBOutlet var volunterFbTblView: UITableView!
    var Fbcell: UITableViewCell?
    var arrChildCategory = NSMutableArray()
    var searchResults = NSMutableArray()
    var arrChildCategory2 = NSMutableArray()
    var searchResults2 = NSMutableArray()
    var theSearchBar: UISearchBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        
     

        // Do any additional setup after loading the view.
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    // MARK: - Complete Order Clicked

    @IBAction func CompleteOrderClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmOrderViewController") as? ConfirmOrderViewController
        myVC?.straddress =  txtAddress.text! + "\n" + txtState.text! + "\n" + txtCity.text! + "\n" + txtPincode.text!
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    @IBAction func StatebuttClicked(_ sender: Any)
    {
        let baseURL  = String(format: "%@getState","http://think360.in/sosimpli/api/index.php/12345/")
            
            let params = "country_id=101&state_id=\("")"
            
            AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
            
            AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
                
                DispatchQueue.main.async {
                    
                    AFWrapperClass.svprogressHudDismiss(view: self)
                    
                    let responceDic:NSDictionary = jsonDic as NSDictionary
                    
                    print(responceDic)
                    
                    if (responceDic.object(forKey: "status") as! Bool) == true
                    {
                        let responceDic2:NSDictionary = (responceDic.object(forKey: "data") as? NSDictionary)!
                        self.arrChildCategory = (responceDic2.object(forKey: "state") as? NSArray)! as! NSMutableArray
                        self.foodbanklistView()
                    }
                    else
                    {
                        AFWrapperClass.alert(Constants.applicationName, message: responceDic.object(forKey: "message") as! String, view: self)
                    }
                }
                
            })
            { (error) in
                
                AFWrapperClass.svprogressHudDismiss(view: self)
                
                AFWrapperClass.alert(Constants.applicationName, message: error.localizedDescription, view: self)
            }
    }
    
    
    
    
    func foodbanklistView ()
    {
        self.tabBarController?.tabBar.isHidden = true
        
        popview2.isHidden=false
        footerView2.isHidden=false
        
        popview2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview2.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview2)
        
        footerView2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        footerView2.backgroundColor = UIColor.white
        popview2.addSubview(footerView2)
        
        let bglab = UILabel()
        bglab.frame = CGRect(x:0, y:0, width:footerView2.frame.size.width, height:70)
        bglab.backgroundColor=#colorLiteral(red: 0.7728603482, green: 0.1228929684, blue: 0.2116835117, alpha: 1)
        footerView2.addSubview(bglab)
        
        let forgotlab = UILabel()
        forgotlab.frame = CGRect(x:0, y:10, width:footerView2.frame.size.width, height:60)
        forgotlab.backgroundColor=#colorLiteral(red: 0.7728603482, green: 0.1228929684, blue: 0.2116835117, alpha: 1)
        forgotlab.text="Select State"
        forgotlab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        forgotlab.textColor=UIColor.white
        forgotlab.textAlignment = .center
        footerView2.addSubview(forgotlab)
        
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:footerView2.frame.size.width-35, y:30, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "cancel-music.png"), for: .normal)
        crossbutt.addTarget(self, action: #selector(DeliveryAddressViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:footerView2.frame.size.width-50, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(DeliveryAddressViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt2)
        
        
        volunterFbTblView = UITableView()
        volunterFbTblView.frame = CGRect(x: 0, y: bglab.frame.origin.y+bglab.frame.size.height, width: footerView2.frame.size.width, height: footerView2.frame.size.height-70)
        volunterFbTblView.delegate = self
        volunterFbTblView.dataSource = self
        volunterFbTblView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        volunterFbTblView.backgroundColor = UIColor.clear
        volunterFbTblView.tableFooterView = UIView()
        volunterFbTblView.tag = 1
        footerView2.addSubview(volunterFbTblView)
        
        
        theSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        theSearchBar?.delegate = self
        theSearchBar?.placeholder = "Search State"
        theSearchBar?.showsCancelButton = false
        theSearchBar?.tag = 1
        volunterFbTblView.tableHeaderView = theSearchBar
        theSearchBar?.isUserInteractionEnabled = true
        
    }
    

    
    func CloseButtonAction(_ sender: UIButton!)
    {
        popview2.isHidden=true
        footerView2.isHidden=true
        
        self.arrChildCategory.removeAllObjects()
        self.searchResults.removeAllObjects()
        volunterFbTblView.removeFromSuperview()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.tag == 1
        {
            if searchResults.count != 0 {
                self.searchResults.removeAllObjects()
                volunterFbTblView.tag = 1
            }
            for i in 0..<arrChildCategory.count {
                // [searchResults removeAllObjects];
                let string: String = (self.arrChildCategory.object(at: i) as! NSDictionary).value(forKey: "name") as! String
                let rangeValue: NSRange = (string as NSString).range(of: searchText, options: .caseInsensitive)
                if rangeValue.length > 0
                {
                    volunterFbTblView.tag = 2
                    searchResults.add(arrChildCategory[i])
                }
                else
                {
                    
                }
            }
            volunterFbTblView.reloadData()
        }
        else
        {
            if searchResults2.count != 0 {
                self.searchResults2.removeAllObjects()
                volunterFbTblView.tag = 3
            }
            for i in 0..<arrChildCategory2.count {
                // [searchResults removeAllObjects];
                let string: String = (self.arrChildCategory2.object(at: i) as! NSDictionary).value(forKey: "name") as! String
                let rangeValue: NSRange = (string as NSString).range(of: searchText, options: .caseInsensitive)
                if rangeValue.length > 0
                {
                    volunterFbTblView.tag = 4
                    searchResults2.add(arrChildCategory2[i])
                }
                else
                {
                    
                }
            }
            volunterFbTblView.reloadData()
        }
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
    
    
    
    
    //  MARK: TableView Delegates and Datasource:
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if volunterFbTblView.tag == 4
        {
            return searchResults2.count
        }
        else if volunterFbTblView.tag == 3
        {
            return arrChildCategory2.count
        }
        else if volunterFbTblView.tag == 2
        {
            return searchResults.count
        }
        else {
            return arrChildCategory.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdetifier: String = "Cell"
        Fbcell = UITableViewCell(style: .default, reuseIdentifier: cellIdetifier)
        
        if volunterFbTblView.tag == 4
        {
            let titlelab = UILabel()
            titlelab.frame = CGRect(x:15, y:5, width:((Fbcell?.frame.size.width)!-30), height:40)
            titlelab.text=(self.searchResults2.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            titlelab.font =  UIFont(name:"Helvetica", size: 15)
            titlelab.textColor=UIColor.black
            titlelab.textAlignment = .left
            Fbcell?.addSubview(titlelab)
        }
       else if volunterFbTblView.tag == 3
        {
            let titlelab = UILabel()
            titlelab.frame = CGRect(x:15, y:5, width:((Fbcell?.frame.size.width)!-30), height:40)
            titlelab.text=(self.arrChildCategory2.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            titlelab.font =  UIFont(name:"Helvetica", size: 15)
            titlelab.textColor=UIColor.black
            titlelab.textAlignment = .left
            Fbcell?.addSubview(titlelab)
        }
        else if volunterFbTblView.tag == 2
        {
            let titlelab = UILabel()
            titlelab.frame = CGRect(x:15, y:5, width:((Fbcell?.frame.size.width)!-30), height:40)
            titlelab.text=(self.searchResults.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            titlelab.font =  UIFont(name:"Helvetica", size: 15)
            titlelab.textColor=UIColor.black
            titlelab.textAlignment = .left
            Fbcell?.addSubview(titlelab)
        }
        else
        {
            let titlelab = UILabel()
            titlelab.frame = CGRect(x:15, y:5, width:((Fbcell?.frame.size.width)!-30), height:40)
            titlelab.text=(self.arrChildCategory.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            titlelab.font =  UIFont(name:"Helvetica", size: 15)
            titlelab.textColor=UIColor.black
            titlelab.textAlignment = .left
            Fbcell?.addSubview(titlelab)
        }
        return Fbcell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if volunterFbTblView.tag == 4
        {
            txtCity.text = (self.searchResults2.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            
            
            popview3.isHidden=true
            footerView3.isHidden=true
            
            self.arrChildCategory2.removeAllObjects()
            self.searchResults2.removeAllObjects()
            volunterFbTblView.removeFromSuperview()
        }
        else if volunterFbTblView.tag == 3
        {
            txtCity.text = (self.arrChildCategory2.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            
            
            popview3.isHidden=true
            footerView3.isHidden=true
            
            self.arrChildCategory2.removeAllObjects()
            self.searchResults2.removeAllObjects()
            volunterFbTblView.removeFromSuperview()
        }
        else if volunterFbTblView.tag == 2
        {
            txtState.text = (self.searchResults.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            txtCity.text = ""
            stateIDstr = (self.searchResults.object(at: indexPath.row) as! NSDictionary).value(forKey: "id") as! NSString
            
            popview2.isHidden=true
            footerView2.isHidden=true
            
            self.arrChildCategory.removeAllObjects()
            self.searchResults.removeAllObjects()
            volunterFbTblView.removeFromSuperview()
        }
        else
        {
            txtState.text = (self.arrChildCategory.object(at: indexPath.row) as! NSDictionary).value(forKey: "name") as? String
            txtCity.text = ""
            stateIDstr = (self.arrChildCategory.object(at: indexPath.row) as! NSDictionary).value(forKey: "id") as! NSString
            
            popview2.isHidden=true
            footerView2.isHidden=true
            
            self.arrChildCategory.removeAllObjects()
            self.searchResults.removeAllObjects()
            volunterFbTblView.removeFromSuperview()
        }
        
        self.tabBarController?.tabBar.isHidden = false
    }
    

    
    
    
    
    
    @IBAction func CitybuttClicked(_ sender: Any)
    {
        if self.txtState.text?.characters.count == 0
        {
            AFWrapperClass.alert(Constants.applicationName, message: "Please select state first", view: self)
        }
        else
        {
            
            let baseURL  = String(format: "%@getState","http://think360.in/sosimpli/api/index.php/12345/")
            
             let params = "country_id=\("")&state_id=\(stateIDstr)"
            
            AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
            
            AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
                
                DispatchQueue.main.async {
                    
                    AFWrapperClass.svprogressHudDismiss(view: self)
                    
                    let responceDic:NSDictionary = jsonDic as NSDictionary
                    
                    print(responceDic)
                    
                    if (responceDic.object(forKey: "status") as! Bool) == true
                    {
                        let responceDic2:NSDictionary = (responceDic.object(forKey: "data") as? NSDictionary)!
                        self.arrChildCategory2 = (responceDic2.object(forKey: "city") as? NSArray)! as! NSMutableArray
                       self.getCityMethod()
                    }
                    else
                    {
                        AFWrapperClass.alert(Constants.applicationName, message: responceDic.object(forKey: "message") as! String, view: self)
                    }
                }
                
            })
            { (error) in
                
                AFWrapperClass.svprogressHudDismiss(view: self)
                
                AFWrapperClass.alert(Constants.applicationName, message: error.localizedDescription, view: self)
            }
        }
    }
    
    
    
    
    
    func getCityMethod ()
    {
        self.tabBarController?.tabBar.isHidden = true
        
        popview3.isHidden=false
        footerView3.isHidden=false
        
        popview3.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview3.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview3)
        
        footerView3.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        footerView3.backgroundColor = UIColor.white
        popview3.addSubview(footerView3)
        
        let bglab = UILabel()
        bglab.frame = CGRect(x:0, y:0, width:footerView3.frame.size.width, height:70)
        bglab.backgroundColor=#colorLiteral(red: 0.7728603482, green: 0.1228929684, blue: 0.2116835117, alpha: 1)
        footerView3.addSubview(bglab)
        
        let forgotlab = UILabel()
        forgotlab.frame = CGRect(x:0, y:10, width:footerView3.frame.size.width, height:60)
        forgotlab.backgroundColor=#colorLiteral(red: 0.7728603482, green: 0.1228929684, blue: 0.2116835117, alpha: 1)
        forgotlab.text="Select City"
        forgotlab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        forgotlab.textColor=UIColor.white
        forgotlab.textAlignment = .center
        footerView3.addSubview(forgotlab)
        
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:footerView3.frame.size.width-35, y:30, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "cancel-music.png"), for: .normal)
        crossbutt.addTarget(self, action: #selector(DeliveryAddressViewController.CloseButtonAction2(_:)), for: UIControlEvents.touchUpInside)
        footerView3.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:footerView3.frame.size.width-50, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(DeliveryAddressViewController.CloseButtonAction2(_:)), for: UIControlEvents.touchUpInside)
        footerView3.addSubview(crossbutt2)
        
        
        volunterFbTblView = UITableView()
        volunterFbTblView.frame = CGRect(x: 0, y: bglab.frame.origin.y+bglab.frame.size.height, width: footerView3.frame.size.width, height: footerView3.frame.size.height-70)
        volunterFbTblView.delegate = self
        volunterFbTblView.dataSource = self
        volunterFbTblView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        volunterFbTblView.backgroundColor = UIColor.clear
        volunterFbTblView.tableFooterView = UIView()
        volunterFbTblView.tag = 3
        footerView3.addSubview(volunterFbTblView)
        
        
        theSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        theSearchBar?.delegate = self
        theSearchBar?.placeholder = "Search City"
        theSearchBar?.showsCancelButton = false
        theSearchBar?.tag = 2
        volunterFbTblView.tableHeaderView = theSearchBar
        theSearchBar?.isUserInteractionEnabled = true
        
    }
    

    
    func CloseButtonAction2(_ sender: UIButton!)
    {
        popview3.isHidden=true
        footerView3.isHidden=true
        
        self.arrChildCategory2.removeAllObjects()
        self.searchResults2.removeAllObjects()
        volunterFbTblView.removeFromSuperview()
        
        self.tabBarController?.tabBar.isHidden = false
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
