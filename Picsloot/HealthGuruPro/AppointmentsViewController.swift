//
//  AppointmentsViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 13/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class AppointmentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var ApprovalCount: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!

    @IBOutlet weak var upcominglistCount: UILabel!
    
    @IBOutlet weak var leftDateButt: UIButton!
    @IBOutlet weak var rightDateButt: UIButton!
    @IBOutlet weak var weekDaylab: UILabel!
    @IBOutlet weak var Datelab: UILabel!
    @IBOutlet weak var DateheightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var appontmentTabl: UITableView!
    
    var cell: PatientsCell!
    var cell2: PatientsCell!
    
    var NewlistArray = NSMutableArray()
    var OldlistArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButt.isHidden = true
        leftDateButt.isHidden = true
        rightDateButt.isHidden = true
        
        appontmentTabl.tableFooterView = UIView()
        
        appontmentTabl.tag = 1
        DateheightConstraint.constant = 50
        weekDaylab.isHidden = false
        Datelab.isHidden = false
        upcominglistCount.textAlignment = .center
        upcominglistCount.text = "4 Upcoming Appointment"
        appontmentTabl.reloadData()

        // Do any additional setup after loading the view.
    }
    
    //MARK: NotificationButt clicked:

    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    //MARK: Approval list clicked:
    
    @IBAction func ApprovalListClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentRequestViewController") as? AppointmentRequestViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    //MARK: Segment changed:
    
    @IBAction func SegmentChanged(_ sender: Any)
    {
        if segControl.selectedSegmentIndex == 0
        {
            appontmentTabl.tag = 1
            DateheightConstraint.constant = 50
            weekDaylab.isHidden = false
            Datelab.isHidden = false
            upcominglistCount.textAlignment = .center
            upcominglistCount.text = "4 Upcoming Appointment"
            appontmentTabl.reloadData()
        }
        else if segControl.selectedSegmentIndex == 1
        {
            appontmentTabl.tag = 2
            DateheightConstraint.constant = 1
            weekDaylab.isHidden = true
            Datelab.isHidden = true
            upcominglistCount.textAlignment = .left
            upcominglistCount.text = "8 Appointments Done"
            appontmentTabl.reloadData()
        }
    }
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 74
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.tag == 1
        {
            return 4
        }
        else if tableView.tag == 2
        {
            return 8
        }
        else
        {
          return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView.tag == 1
        {
            let identifier = "PatientsCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PatientsCell
            
            if cell == nil
            {
                tableView.register(UINib(nibName: "PatientsCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PatientsCell
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            appontmentTabl.separatorStyle = .none
            appontmentTabl.separatorColor = UIColor.clear
            
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
        else if tableView.tag == 2
        {
            let identifier = "PatientsCell"
            cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? PatientsCell
            
            if cell2 == nil
            {
                tableView.register(UINib(nibName: "PatientsCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? PatientsCell
            }
            
            cell2.selectionStyle = UITableViewCellSelectionStyle.none
            appontmentTabl.separatorStyle = .none
            appontmentTabl.separatorColor = UIColor.clear
            
            if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4
            {
                cell2.userNameHeight.constant = 25
                cell2.userType.isHidden = false
                cell2.userPic.image = UIImage(named: "User")
                cell2.userPreferTime.text = "M"
                cell2.userTime.text = "10-11"
            }
            else
            {
                cell2.userNameHeight.constant = 50
                cell2.userType.isHidden = true
                cell2.userPic.image = UIImage(named: "DefaultImage")
                cell2.userPreferTime.text = "E"
                cell2.userTime.text = "02-03"
            }
            return cell2
        }
        return cell2
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.tag == 1
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PatientDetailViewController") as? PatientDetailViewController
            myVC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myVC!, animated: true)
        }
        else if tableView.tag == 2
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PatientDetailViewController") as? PatientDetailViewController
            myVC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(myVC!, animated: true)
        }
    }
    

    
    //MARK: Add New Appointment clicked:
    
    @IBAction func AddNewAppontmentClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPatientViewController") as? AddNewPatientViewController
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
