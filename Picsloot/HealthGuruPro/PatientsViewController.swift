//
//  PatientsViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 13/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit


class PatientsCell: UITableViewCell
{
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userPreferTime: UILabel!
    @IBOutlet weak var userTime: UILabel!
    @IBOutlet weak var userNameHeight: NSLayoutConstraint!
}

class PatientsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var PatientTabl: UITableView!
    
    var cell: PatientsCell!
    var AppointReqArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       backButt.isHidden = true
        
      PatientTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }

    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
   
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 74
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
         return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let identifier = "PatientsCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PatientsCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "PatientsCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PatientsCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        PatientTabl.separatorStyle = .none
        PatientTabl.separatorColor = UIColor.clear
        
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4
        {
            cell.userNameHeight.constant = 25
            cell.userType.isHidden = false
            cell.userPic.image = UIImage(named: "User")
            cell.userPreferTime.text = "M"
            cell.userTime.text = "10-11"
        }
        else
        {
            cell.userNameHeight.constant = 50
            cell.userType.isHidden = true
            cell.userPic.image = UIImage(named: "DefaultImage")
            cell.userPreferTime.text = "E"
            cell.userTime.text = "02-03"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PatientDetailViewController") as? PatientDetailViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    

     // MARK: - Add New Appointment Clicked
    
    @IBAction func AddNewAppointClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPatientViewController") as? AddNewPatientViewController
        myVC?.checkStr = "1"
        myVC?.hidesBottomBarWhenPushed = true
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
