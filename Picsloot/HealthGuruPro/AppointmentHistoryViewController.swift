//
//  AppointmentHistoryViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 15/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell
{
    @IBOutlet weak var MorEvelab: UILabel!
    @IBOutlet weak var timeSlotLab: UILabel!
    @IBOutlet weak var DateLab: UILabel!
    @IBOutlet weak var testCountLab: UILabel!
    @IBOutlet weak var prescriptionCountlab: UILabel!
   
}

class AppointmentHistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var HistoryTabl: UITableView!
    
    var cell:HistoryCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HistoryTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
     //MARK: Notification Butt Clicked

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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "HistoryCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HistoryCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HistoryCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        HistoryTabl.separatorStyle = .none
        HistoryTabl.separatorColor = UIColor.clear
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailHistoryViewController") as? DetailHistoryViewController
        myVC?.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    

     //MARK: Back Butt Clicked
    
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
