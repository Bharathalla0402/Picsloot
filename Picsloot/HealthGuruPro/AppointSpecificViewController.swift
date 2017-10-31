//
//  AppointSpecificViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 14/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class AppointSpecificViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
     var cell: PatientsCell!
    
   
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var PatientTabl: UITableView!
    
    @IBOutlet weak var leftDateButt: UIButton!
    @IBOutlet weak var rightDateButt: UIButton!
    @IBOutlet weak var weekdayLab: UILabel!
    @IBOutlet weak var timeslotlab: UILabel!
    @IBOutlet weak var countlistLab: UILabel!
    
    var strweekay = NSString()
    var strTimeslot = NSString()
    var strCount = NSString()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftDateButt.isHidden = true
        rightDateButt.isHidden = true
        
        weekdayLab.text = UserDefaults.standard.object(forKey: "Weekday") as? String
        timeslotlab.text = "10-11"
        countlistLab.text = "3"
        
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
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
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
            cell.userPreferTime.text = "M"
            cell.userTime.text = "10-11"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PatientDetailViewController") as? PatientDetailViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    //MARK: Back Butt clicked:
    
    @IBAction func BackButtClicked(_ sender: Any)
    {
         _ = self.navigationController?.popToRootViewController(animated: true)
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
