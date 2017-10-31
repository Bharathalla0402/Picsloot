//
//  AppointmentRequestViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 08/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit


class AppointmentRequestCell: UITableViewCell
{
    @IBOutlet weak var addedPlusImage: UIImageView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userPreferTime: UILabel!
    @IBOutlet weak var userNameHeight: NSLayoutConstraint!
}


class AppointmentRequestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var appointReqTabl: UITableView!
    @IBOutlet weak var NotificationCount: UILabel!
    
    var cell: AppointmentRequestCell!
    var cell2: TimeSlotCell!
    var AppointReqArray = NSMutableArray()
    var MorninglistArray = NSMutableArray()
    var EveninglistArray = NSMutableArray()
    
    var popview = UIView()
    var footerView = UIView()
    
    @IBOutlet var MorningTabl: UITableView!
    @IBOutlet var EveningTabl: UITableView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        appointReqTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
     //MARK: NotificationButt clicked:
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        
        
    }
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView.tag == 1
        {
            return 40
        }
        else if tableView.tag == 2
        {
            return 40
        }
        else
        {
            return 74
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.tag == 1
        {
            return 4
        }
        else if tableView.tag == 2
        {
            return 4
        }
        else
        {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView.tag == 1
        {
            let identifier = "TimeSlotCell"
            cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? TimeSlotCell
            
            if cell2 == nil
            {
                tableView.register(UINib(nibName: "TimeSlotCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? TimeSlotCell
            }
            
            cell2.selectionStyle = UITableViewCellSelectionStyle.none
            MorningTabl.separatorStyle = .none
            MorningTabl.separatorColor = UIColor.clear
            
            if indexPath.row == 0 || indexPath.row == 2
            {
                cell2.TimeSlotlab.text = "09 - 10"
                cell2.CountLab.isHidden = true
                cell2.clickedSlotImage.isHidden = true
            }
            else
            {
                cell2.TimeSlotlab.text = "09 - 10"
                cell2.CountLab.text = "2"
                cell2.clickedSlotImage.isHidden = true
            }
            
            return cell2

        }
        else if tableView.tag == 2
        {
            let identifier = "TimeSlotCell"
            cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? TimeSlotCell
            
            if cell2 == nil
            {
                tableView.register(UINib(nibName: "TimeSlotCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? TimeSlotCell
            }
            
            cell2.selectionStyle = UITableViewCellSelectionStyle.none
            EveningTabl.separatorStyle = .none
            EveningTabl.separatorColor = UIColor.clear
            
            if indexPath.row == 0 || indexPath.row == 2
            {
                cell2.TimeSlotlab.text = "02 - 03"
                cell2.CountLab.isHidden = true
                cell2.clickedSlotImage.isHidden = true
            }
            else
            {
                cell2.TimeSlotlab.text = "02 - 03"
                cell2.CountLab.text = "1"
                cell2.clickedSlotImage.isHidden = true
            }
            
            return cell2
        }
        else
        {
            
            let identifier = "AppointmentRequestCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AppointmentRequestCell
            
            if cell == nil
            {
                tableView.register(UINib(nibName: "AppointmentRequestCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AppointmentRequestCell
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            appointReqTabl.separatorStyle = .none
            appointReqTabl.separatorColor = UIColor.clear
            
            if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4
            {
                cell.userNameHeight.constant = 25
                cell.userType.isHidden = false
                cell.addedPlusImage.image = UIImage(named: "AddPlus")
                cell.userPic.image = UIImage(named: "User")
                cell.userPreferTime.text = "M"
            }
            else
            {
                cell.userNameHeight.constant = 50
                cell.userType.isHidden = true
                cell.addedPlusImage.image = UIImage(named: "Added")
                cell.userPic.image = UIImage(named: "DefaultImage")
                cell.userPreferTime.text = "E"
            }
            
            return cell
 
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.tag == 1
        {
            popview.isHidden=true
            footerView.isHidden=true
        }
        else if tableView.tag == 2
        {
            popview.isHidden=true
            footerView.isHidden=true
        }
        else
        {
           self.TimeSlotView()
        }
    }
    

    // MARK: - Time Slot View
    
    func TimeSlotView() -> Void
    {
        popview.isHidden=false
        footerView.isHidden=false
        
        popview.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview)
        
        footerView.frame = CGRect(x:10, y:popview.frame.size.height/2-130, width:popview.frame.size.width-20, height:260)
        footerView.backgroundColor = UIColor.white
        popview.addSubview(footerView)
        
        
        let titlelab = UILabel()
        titlelab.frame = CGRect(x:10, y:5, width:footerView.frame.size.width-20, height:40)
        titlelab.text="Assign Time Slot"
        titlelab.font =  UIFont(name:"System", size: 16)
        titlelab.textColor=#colorLiteral(red: 0.1379635036, green: 0.1363001764, blue: 0.1703013182, alpha: 1)
        titlelab.textAlignment = .center
        footerView.addSubview(titlelab)
        
        let leftView = UIView()
        leftView.frame = CGRect(x:0, y:titlelab.frame.size.height+titlelab.frame.origin.y, width:footerView.frame.size.width/2, height:footerView.frame.size.height-50)
        leftView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        footerView.addSubview(leftView)
        
        let Morninglab = UILabel()
        Morninglab.frame = CGRect(x:5, y:5, width:leftView.frame.size.width-10, height:30)
        Morninglab.text="Morning"
        Morninglab.font =  UIFont(name:"System", size: 16)
        Morninglab.textColor=#colorLiteral(red: 0.1379635036, green: 0.1363001764, blue: 0.1703013182, alpha: 1)
        Morninglab.textAlignment = .center
        leftView.addSubview(Morninglab)
        
        
        MorningTabl = UITableView()
        MorningTabl.frame = CGRect(x: 0, y: 40, width: leftView.frame.size.width, height: leftView.frame.size.height-40)
        MorningTabl.delegate = self
        MorningTabl.dataSource = self
        MorningTabl.tag = 1
        MorningTabl.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        MorningTabl.backgroundColor = UIColor.clear
        MorningTabl.tableFooterView = UIView()
        leftView.addSubview(MorningTabl)
        
        
        
        let RightView = UIView()
        RightView.frame = CGRect(x:footerView.frame.size.width/2, y:titlelab.frame.size.height+titlelab.frame.origin.y, width:footerView.frame.size.width/2, height:footerView.frame.size.height-50)
        RightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        footerView.addSubview(RightView)
        
        let Eveninglab = UILabel()
        Eveninglab.frame = CGRect(x:5, y:5, width:leftView.frame.size.width-10, height:30)
        Eveninglab.text="Evening"
        Eveninglab.font =  UIFont(name:"System", size: 16)
        Eveninglab.textColor=#colorLiteral(red: 0.1379635036, green: 0.1363001764, blue: 0.1703013182, alpha: 1)
        Eveninglab.textAlignment = .center
        RightView.addSubview(Eveninglab)
        
        
        EveningTabl = UITableView()
        EveningTabl.frame = CGRect(x: 0, y: 40, width: leftView.frame.size.width, height: leftView.frame.size.height-40)
        EveningTabl.delegate = self
        EveningTabl.dataSource = self
        EveningTabl.tag = 2
        EveningTabl.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        EveningTabl.backgroundColor = UIColor.clear
        EveningTabl.tableFooterView = UIView()
        RightView.addSubview(EveningTabl)
    }
    
    
    
   // MARK: - Add New Appointment Butt Clicked
    
    @IBAction func addNewAppointmentClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPatientViewController") as? AddNewPatientViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    // MARK: - Back Butt Clicked
    
    @IBAction func backButtClicked(_ sender: Any)
    {
         _ = self.navigationController?.popViewController(animated: true)  
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       // popview.isHidden=true
       // footerView.isHidden=true
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
