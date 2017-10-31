//
//  NotificationViewController.swift
//  Picsloot
//
//  Created by think360 on 14/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class notificationCell: UITableViewCell
{
    @IBOutlet weak var NotificationLab: UILabel!
    
}

class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationTabl: UITableView!
    
    
    var Cell:notificationCell!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationTabl.rowHeight = UITableViewAutomaticDimension
        NotificationTabl.estimatedRowHeight = 50
        NotificationTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "notificationCell"
        Cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? notificationCell
        
        if Cell == nil
        {
            tableView.register(UINib(nibName: "notificationCell", bundle: nil), forCellReuseIdentifier: identifier)
            Cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? notificationCell
        }
        
        Cell.selectionStyle = UITableViewCellSelectionStyle.none
        NotificationTabl.separatorStyle = .none
        NotificationTabl.separatorColor = UIColor.clear
        
        
        
        let boldAttribute = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName: UIColor.black
            ] as [String : Any]
        
        let regularAttribute = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName: UIColor.lightGray
            ] as [String : Any]
        
        
        let mutableAttributedString3 = NSMutableAttributedString()
        let regularAttributedString3 = NSAttributedString(string: "Date 27/09/2017, 4.00 PM, ", attributes: regularAttribute)
        let boldAttributedString3 = NSAttributedString(string: "PicsLOOT Images Printout send your mentioned Address.", attributes: boldAttribute)
        mutableAttributedString3.append(regularAttributedString3)
        mutableAttributedString3.append(boldAttributedString3)
        Cell.NotificationLab.attributedText = mutableAttributedString3
        
        
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
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
