//
//  DashboardViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 06/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit




class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var NotificationCountLab: UILabel!
    @IBOutlet weak var ApprovalPendingCountlab: UILabel!
    @IBOutlet weak var weekLab: UILabel!
    @IBOutlet weak var Datelab: UILabel!
    @IBOutlet weak var leftDateButt: UIButton!
    @IBOutlet weak var RightDateButt: UIButton!
    @IBOutlet weak var segemnetBtn: UISegmentedControl!
    @IBOutlet weak var scheduleTabl: UITableView!
    @IBOutlet weak var scheduleTablHeight: NSLayoutConstraint!
    
    var cell: SchedulelistCell!
    var MorninglistArray = NSMutableArray()
    var EveninglistArray = NSMutableArray()
    
    var strdayid = NSString()
    var str2moroid = NSString()
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    
        
        
        scheduleTabl.tag = 1
        scheduleTablHeight.constant = (3) * (49)
    }
    
    @IBAction func leftDateClicked(_ sender: Any)
    {
        
    }
    
    @IBAction func RightDateClicked(_ sender: Any)
    {
        
    }
    
    @IBAction func SegmentValueChanged(_ sender: Any)
    {
        if segemnetBtn.selectedSegmentIndex == 0
        {
            scheduleTabl.tag = 1
            scheduleTablHeight.constant = (3) * (49)
            scheduleTabl.reloadData()
        }
        else if segemnetBtn.selectedSegmentIndex == 1
        {
            scheduleTabl.tag = 2
            scheduleTablHeight.constant = (5) * (49)
            scheduleTabl.reloadData()
        }
    }
    
    
   
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 49
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.tag == 1
        {
            return 3
           // return MorninglistArray.count
        }
        else
        {
            return 5
           // return EveninglistArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "SchedulelistCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SchedulelistCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "SchedulelistCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SchedulelistCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
//        if tableView.tag == 1
//        {
//            cell.timeLab.text! = "10.00 am - 12.00 am"
//            cell.countLab.text! = "6"
//        }
//        else
//        {
//            cell.timeLab.text! = "4.00 pm - 6.00 pm"
//            cell.countLab.text! = "6"
//        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    
    //MARK: Callender View:
    
    
 

    override func didReceiveMemoryWarning()
    {
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
