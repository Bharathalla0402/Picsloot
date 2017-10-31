//
//  NotificationViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 14/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit


class Notificationscell: UITableViewCell
{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTime: UILabel!
    @IBOutlet weak var userPreference: UILabel!
    @IBOutlet weak var userPreferDay: UILabel!
    @IBOutlet weak var userPreferTimeslot: UILabel!
}


class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var NotificationTabl: UITableView!
     var cell: Notificationscell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
         NotificationTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let identifier = "Notificationscell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Notificationscell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "Notificationscell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Notificationscell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        NotificationTabl.separatorStyle = .none
        NotificationTabl.separatorColor = UIColor.clear
        
                
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
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
