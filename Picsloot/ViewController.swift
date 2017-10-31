//
//  ViewController.swift
//  Picsloot
//
//  Created by think360 on 13/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
    
    var  faceBookDic = NSDictionary()
    var imageURL = NSURL()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Mobile Number Clicked
    
    @IBAction func MobileNumberClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "MobileNumberViewController") as? MobileNumberViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
     // MARK: - Facebook Butt Clicked
    
    @IBAction func FacebookButtClicked(_ sender: Any)
    {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                       // fbLoginManager.logOut()
                    }
                    
                }
            }
        }

    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    self.faceBookDic = result as! [String : AnyObject] as NSDictionary
                    
                    print( self.faceBookDic)
                    
                    let myVC = self.storyboard?.instantiateViewController(withIdentifier: "MobileNumberViewController") as? MobileNumberViewController
                    self.navigationController?.pushViewController(myVC!, animated: true)
                    
                    myVC?.emailGet = self.faceBookDic.object(forKey: "email") as! String
                    myVC?.nameGet = self.faceBookDic.object(forKey: "name") as! String
                    myVC?.socialID = self.faceBookDic.object(forKey: "id") as! String
                    let info : NSDictionary =  self.faceBookDic.object(forKey: "picture") as! NSDictionary
                    let info2 : NSDictionary =  info.object(forKey: "data") as! NSDictionary
                    let url: NSString = (info2.object(forKey: "url") as? NSString)!
                    print(url)
                    myVC?.imgURL = NSURL(string: url as String)!
                    myVC?.emailChkStr = "YES"
                    myVC?.socialRegistaerStr = "FaceBook"
                    
                }
            })
        }
    }

    
    
    // MARK: - Google Butt Clicked

    @IBAction func GoogleButtClicked(_ sender: Any)
    {
        GIDSignIn.sharedInstance().signOut()
        
        let sighIn:GIDSignIn = GIDSignIn.sharedInstance()
        sighIn.delegate = self;
        sighIn.uiDelegate = self;
        sighIn.shouldFetchBasicProfile = true
        sighIn.scopes = ["https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/userinfo.email","https://www.googleapis.com/auth/userinfo.profile","https://www.googleapis.com/auth/plus.me"];
        sighIn.clientID = "872610494649-k5ri8en2pvk6mqqj9k60hf3lag3l8fr9.apps.googleusercontent.com"
        sighIn.signIn()
        GIDSignIn.sharedInstance().signOut()
    }
    
    
    
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        AFWrapperClass.svprogressHudDismiss(view: self);
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            return
        }
        reportAuthStatus()
        
        //print("\(user.profile.name) \n \(user.profile.email) \n \(user.authentication.idToken) \n \(user.userID)")
        
        if GIDSignIn.sharedInstance().currentUser.profile.hasImage
        {
            imageURL = user.profile.imageURL(withDimension: UInt(120)) as NSURL
            print("Image Url : \(imageURL)")
        }
        
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "MobileNumberViewController") as? MobileNumberViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
        
        myVC?.emailGet = user.profile.email
        myVC?.nameGet = user.profile.name
        myVC?.socialID = user.userID
        myVC?.emailChkStr = "YES"
        myVC?.imgURL = imageURL
        myVC?.socialRegistaerStr = "Google"
        
        
        print(user.profile.email)
        print(user.profile.name)
        print(user.userID)
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            
        }else
        {
            
        }
    }
    func reportAuthStatus() -> Void {
        let googleUser:GIDGoogleUser = GIDSignIn.sharedInstance().currentUser
        if (googleUser.authentication != nil)
        {
            print("Status: Authenticated")
        }else
        {
            print("Status: Not authenticated")
        }
        
    }
    func refreshUserInfo() -> Void {
        if GIDSignIn.sharedInstance().currentUser.authentication == nil {
            return
        }
        if !GIDSignIn.sharedInstance().currentUser.profile.hasImage {
            return
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

