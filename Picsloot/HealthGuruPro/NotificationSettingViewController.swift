//
//  NotificationSettingViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 20/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class NotificationSettingViewController: UIViewController {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var backButt: UIButton!
    
    @IBOutlet weak var NotificationHeaderTest: UILabel!
    @IBOutlet weak var appointSwitch: UISwitch!
    @IBOutlet weak var feedbackSwitch: UISwitch!
    @IBOutlet weak var blogSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }

    @IBAction func appointSwitchChanged(_ sender: Any)
    {
        
    }
    
    @IBAction func feedbackSwitchChanged(_ sender: Any)
    {
        
    }
    
    @IBAction func blogSwitchChanged(_ sender: Any)
    {
        
    }
    
    @IBAction func ResetNotificationButtClicked(_ sender: Any)
    {
        
    }
    
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
