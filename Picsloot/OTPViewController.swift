//
//  OTPViewController.swift
//  Picsloot
//
//  Created by think360 on 13/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var pinCodeTextField: PinCodeTextField!
    var check : Bool!
    @IBOutlet weak var secondsLab: UILabel!
    @IBOutlet weak var resendOTPbutt: UIButton!
    @IBOutlet weak var nextButt: UIButton!
    
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addDoneButtonOnKeyboard()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.pinCodeTextField.becomeFirstResponder()
        }
        
        pinCodeTextField.delegate = self
        pinCodeTextField.keyboardType = .decimalPad
        
        timer()
        
        check = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OTPViewController.dismissKeyboard))
        
        pinCodeTextField.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(OTPViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

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
        
       // self.pinCodeTextField.keyboardType = doneToolbar
    }
    
    func doneButtonAction()
    {
        self.view.endEditing(true)
    }

    
    
    @objc func methodOfReceivedNotification(notification: NSNotification)
    {
        check = false
    }
    
    
    func dismissKeyboard()
    {
        if check == true
        {
            view.endEditing(true)
            check = false
        }
        else
        {
            self.pinCodeTextField.becomeFirstResponder()
            check = true
        }
    }
    
    // MARK: - Resend OTP Clicked
    
    @IBAction func ResendOTPbuttClicked(_ sender: Any)
    {
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            var i = 60
            while i > -1 {
                if i == 0 {
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.resendOTPbutt.isUserInteractionEnabled = true
                    })
                    //  ResendButton.isUserInteractionEnabled = true
                }
                else {
                    usleep(1000000)
                    // sleep in microseconds
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.secondsLab.text = "Valid for \(i) Seconds"
                        self.resendOTPbutt.isUserInteractionEnabled = false
                        
                    })
                    i -= 1
                }
            }
            
        })
    }
    
    // MARK: - Next Butt Clicked
    
    @IBAction func NextButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AddProfileViewController") as? AddProfileViewController
        myVC?.emailGet = emailGet
        myVC?.nameGet = nameGet
        myVC?.socialID = socialID
        myVC?.imgURL = imgURL
        myVC?.emailChkStr = emailChkStr
        myVC?.socialRegistaerStr = socialRegistaerStr
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    
    // MARK: - Timer
    
    func timer() {
        //  _: NSInteger = 100
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            var i = 60
            while i > -1 {
                if i == 0 {
                    //                    DispatchQueue.main.async(execute: {() -> Void in
                    //
                    //                    })
                    
                    self.resendOTPbutt.isUserInteractionEnabled = true
                    //  ResendButton.isUserInteractionEnabled = true
                }
                else {
                    usleep(1000000)
                    // sleep in microseconds
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.secondsLab.text = "Valid for \(i) Seconds"
                        self.resendOTPbutt.isUserInteractionEnabled = false
                        
                    })
                    i -= 1
                }
            }
            
        })
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


extension OTPViewController: PinCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField)
    {
        print(textField.text ?? String())
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        return true
    }
}


