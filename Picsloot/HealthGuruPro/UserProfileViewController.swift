//
//  UserProfileViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 18/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import Alamofire

class UserProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileTabl: UITableView!
    
    @IBOutlet weak var profiletablHeight: NSLayoutConstraint!
    var cell:profileCell!
    
   
    
    //  var ItemlistArray = NSMutableArray()
    var ItemlistArray : NSMutableArray = ["Profile","Procedure List","Procedure Packages","Notifications","Feedback","Rate us on App Store"]
    var ImageslistArray : NSMutableArray = ["userProfile","Procedure","Packages","Notifications","FeedBack","RateUs"]
    

    var arrchild = NSMutableArray()
    var arrchild2 = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ProfileTabl.tableFooterView = UIView()
        backButt.isHidden = true
        
        profiletablHeight.constant = CGFloat((ItemlistArray.count) * (62));

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
        return 62
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ItemlistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "profileCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? profileCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "profileCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? profileCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        ProfileTabl.separatorStyle = .none
        ProfileTabl.separatorColor = UIColor.clear
        
        cell.DescTitle.text = ItemlistArray[indexPath.row] as? String
        let imageName: String = ImageslistArray[indexPath.row] as? String ?? ""
        cell.DescImage.image = UIImage(named: imageName)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //  NotificationSettingViewController
        
        if indexPath.row == 0
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as? DoctorProfileViewController
            myVC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myVC!, animated: true)
        }
        else if (indexPath.row == 1)
        {
            self.ProcedureAPImethod()
        }
        else if (indexPath.row == 2)
        {
            self.PackageAPImethod()
        }
        else if (indexPath.row == 3)
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationSettingViewController") as? NotificationSettingViewController
            self.navigationController?.pushViewController(myVC!, animated: true)
        }
        else if (indexPath.row == 4)
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedBackViewController") as? FeedBackViewController
            self.navigationController?.pushViewController(myVC!, animated: true)
        }
        else if (indexPath.row == 5)
        {
            
        }
    }
    
    
    
    // MARK:  Procedure list Details API method
    
    func ProcedureAPImethod () -> Void
    {
       // doctor_package
    
     //   let todoEndpoint: String = "http://think360.in/mediapp/api/index.php/12345/doctor_procedure?doctor_id=6&type_id=1"
       
        
        let baseURL  = String(format: "http://think360.in/mediapp/api/index.php/12345/doctor_procedure?doctor_id=6&type_id=1")
        
        let params = ""
        
        AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
        
        AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
            
            DispatchQueue.main.async {
                
                AFWrapperClass.svprogressHudDismiss(view: self)
                
                let responceDic:NSDictionary = jsonDic as NSDictionary
                
                 print(responceDic)
                
                if (responceDic.object(forKey: "status") as! NSNumber) == 1
                {
                     self.arrchild = (responceDic.object(forKey: "data") as? NSMutableArray)!
                    
                   
                
                    let baseURL  = String(format: "http://think360.in/mediapp/api/index.php/12345/doctor_package?doctor_id=6&type_id=1")
                    
                    let params = ""
                    
                    AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
                    
                    AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
                        
                        DispatchQueue.main.async {
                            
                            AFWrapperClass.svprogressHudDismiss(view: self)
                            
                            let responceDic:NSDictionary = jsonDic as NSDictionary
                            
                            print(responceDic)
                            
                            if (responceDic.object(forKey: "status") as! NSNumber) == 1
                            {
                                self.arrchild2 = (responceDic.object(forKey: "data") as? NSMutableArray)!
                                
                                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ProcedurePackageViewController") as? ProcedurePackageViewController
                                myVC?.arrChildCategory = self.arrchild
                                myVC?.arrChildCategoryp2 = self.arrchild2
                                myVC?.strTitle = "Procedure List"
                                myVC?.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(myVC!, animated: true)
                                
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
    
    
    
    
    
    func PackageAPImethod () -> Void
    {
        
        let baseURL  = String(format: "http://think360.in/mediapp/api/index.php/12345/doctor_procedure?doctor_id=6&type_id=1")
        
        let params = ""
        
        AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
        
        AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
            
            DispatchQueue.main.async {
                
                AFWrapperClass.svprogressHudDismiss(view: self)
                
                let responceDic:NSDictionary = jsonDic as NSDictionary
                
                print(responceDic)
                
                if (responceDic.object(forKey: "status") as! NSNumber) == 1
                {
                    self.arrchild = (responceDic.object(forKey: "data") as? NSMutableArray)!
                    
                    
                    
                    let baseURL  = String(format: "http://think360.in/mediapp/api/index.php/12345/doctor_package?doctor_id=6&type_id=1")
                    
                    let params = ""
                    
                    AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
                    
                    AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
                        
                        DispatchQueue.main.async {
                            
                            AFWrapperClass.svprogressHudDismiss(view: self)
                            
                            let responceDic:NSDictionary = jsonDic as NSDictionary
                            
                            print(responceDic)
                            
                            if (responceDic.object(forKey: "status") as! NSNumber) == 1
                            {
                                self.arrchild2 = (responceDic.object(forKey: "data") as? NSMutableArray)!
                                
                                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ProcedurePackageViewController") as? ProcedurePackageViewController
                                myVC?.arrChildCategory = self.arrchild
                                myVC?.arrChildCategoryp2 = self.arrchild2
                                myVC?.strTitle = "Procedure Packages"
                                myVC?.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(myVC!, animated: true)
                                
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
    
    
    
    @IBAction func ContactUsButtClicked(_ sender: Any)
    {
        
    }
    

    @IBAction func BackButtClicked(_ sender: Any)
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
