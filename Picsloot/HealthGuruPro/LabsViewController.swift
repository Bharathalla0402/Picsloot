//
//  LabsViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 13/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit


class LabsListCell: UITableViewCell
{
    @IBOutlet weak var LabImage: UIImageView!
    @IBOutlet weak var LabName: UILabel!
    @IBOutlet weak var LabContact: UILabel!
    @IBOutlet weak var LabAddress: UILabel!
    
}


class LabsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var LabsCount: UILabel!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var Labstabl: UITableView!
    
    var cell: LabsListCell!
  

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Notification Butt Clicked:
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        
    }
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       return 145
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let identifier = "LabsListCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LabsListCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "LabsListCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LabsListCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        Labstabl.separatorStyle = .none
        Labstabl.separatorColor = UIColor.clear
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }

    
    
    //MARK: Back Butt Clicked:

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
