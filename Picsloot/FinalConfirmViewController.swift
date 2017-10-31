//
//  FinalConfirmViewController.swift
//  Picsloot
//
//  Created by think360 on 17/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class FinalConfirmViewController: UIViewController {

    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         backButt.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
     //MARK: View Order clicked:
    
    @IBAction func ViewOrderButtClicked(_ sender: Any)
    {
         _ = self.tabBarController?.selectedIndex = 1
        self.navigationController?.popToRootViewController(animated: true)
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
