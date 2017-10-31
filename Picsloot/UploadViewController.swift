//
//  UploadViewController.swift
//  Picsloot
//
//  Created by think360 on 17/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import UICircularProgressRing


class UploadViewController: UIViewController,UICircularProgressRingDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var progressRing: UICircularProgressRingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButt.isHidden = true
        
        progressRing.delegate = self
        progressRing.animationStyle = kCAMediaTimingFunctionLinear
        progressRing.font = UIFont.systemFont(ofSize: 70)
        progressRing.animationStyle = kCAMediaTimingFunctionLinear
        progressRing.setProgress(value: 99, animationDuration: 4, completion: nil)

        // Do any additional setup after loading the view.
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    // The delegate method!
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView)
    {
        if ring === progressRing
        {
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "FinalConfirmViewController") as? FinalConfirmViewController
            myVC?.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(myVC!, animated: true)
        }
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
