//
//  AdviceTestViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 15/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class AdviceTestCell: UITableViewCell
{

    @IBOutlet weak var TestNameLab: UILabel!
}

class AdviceTestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var AdviceTestTabl: UITableView!
    
    var cell:AdviceTestCell!
    
    //  var ItemlistArray = NSMutableArray()
    var ItemlistArray : NSMutableArray = ["Urine Routine Examination","KFT (kidney Function Test)","CBC (Complete Blood Counts)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdviceTestTabl.tableFooterView = UIView()

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
        return 61
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ItemlistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "AdviceTestCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AdviceTestCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "AdviceTestCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AdviceTestCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        AdviceTestTabl.separatorStyle = .none
        AdviceTestTabl.separatorColor = UIColor.clear
        
        cell.TestNameLab.text = ItemlistArray[indexPath.row] as? String
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }

    @IBAction func AddMoreTestButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AddMoreTestViewController") as? AddMoreTestViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }


    @IBAction func BackButtClicked(_ sender: Any)
    {
         _ = self.navigationController?.popViewController(animated: true)
        
//        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PatientDetailViewController") as? PatientDetailViewController
//        myVC?.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(myVC!, animated: true)
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
