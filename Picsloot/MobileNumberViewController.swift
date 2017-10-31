//
//  MobileNumberViewController.swift
//  Picsloot
//
//  Created by think360 on 13/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit


class MobileNumberViewController: UIViewController,UITextFieldDelegate {
    
    var emailChkStr = String()
    var socialID = String()
    var emailGet = String()
    var nameGet = String()
    var socialRegistaerStr = String()
    var method = String()
    var StrName = String()
    var StrName2 = String()
    var socialApi = String()
    var CountryPicker = UIButton()
    var imgURL = NSURL()

    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       //  self.addDoneButtonOnKeyboard()
        
    //    NotificationCenter.default.addObserver(self, selector: #selector(MobileNumberViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    //    NotificationCenter.default.addObserver(self, selector: #selector(MobileNumberViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(MobileNumberViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.txtMobileNumber.inputAccessoryView = doneToolbar
    }
    
    
    func doneButtonAction()
    {
       self.view.endEditing(true)
    }

    // MARK: - Next Butt Clicked
    
    @IBAction func NextButtClicked(_ sender: Any)
    {
        UserDefaults.standard.set(txtMobileNumber.text!, forKey: "mobile")
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
        myVC?.emailGet = emailGet
        myVC?.nameGet = nameGet
        myVC?.socialID = socialID
        myVC?.imgURL = imgURL
        myVC?.emailChkStr = emailChkStr
        myVC?.socialRegistaerStr = socialRegistaerStr
        self.navigationController?.pushViewController(myVC!, animated: true)
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
