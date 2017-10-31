//
//  PatientProfileViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 15/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class profileCell: UITableViewCell
{
    @IBOutlet weak var DescImage: UIImageView!
    @IBOutlet weak var DescTitle: UILabel!
}

class PatientProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileTabl: UITableView!
    
    @IBOutlet weak var profileTablHeight: NSLayoutConstraint!
    
    var cell:profileCell!
    
  //  var ItemlistArray = NSMutableArray()
    var ItemlistArray : NSMutableArray = ["Bharath Kumar","bharath.think360@gmail.com","8143547797","B+","Male","25","Smoke Allergy"]
    var ImageslistArray : NSMutableArray = ["Name","Email","Mobile","Blood","Gender","Age","Alergy"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    ProfileTabl.tableFooterView = UIView()
        
        profileTablHeight.constant = CGFloat((ItemlistArray.count) * (51));
       
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
        return 51
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
              
    }
    

     //MARK: Back Butt Clicked
    
    @IBAction func backButtClicked(_ sender: Any)
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
