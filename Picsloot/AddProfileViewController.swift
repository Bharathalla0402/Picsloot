//
//  AddProfileViewController.swift
//  Picsloot
//
//  Created by think360 on 13/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import SDWebImage

class AddProfileViewController: UIViewController,UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: ACFloatingTextfield!
    @IBOutlet weak var userEmail: ACFloatingTextfield!
    @IBOutlet weak var checkButt: UIButton!
    
    
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
    
    var popview = UIView()
    var footerView = UIView()
    var termsView = UIWebView()
    var htmlstring=String()
    
    var imagePicker = UIImagePickerController()
    var currentSelectedImage = UIImage()
    
    @IBOutlet weak var camerabutt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         imagePicker.delegate = self
        
         userPic.sd_setImage(with: imgURL as URL!, placeholderImage: UIImage(named: "Profile"))
        userName.text! = nameGet
        userEmail.text! = emailGet
       
     self.termsmethod(baseURL: String(format:"%@", "http://think360.in/Food4All/webservices/Api.php") , params: "method=termsandcondition")
        // Do any additional setup after loading the view.
        
       
    }
    
    func ViewWillAppear()
    {
        self.userPic.layer.cornerRadius = self.userPic.frame.size.width / 2;
        self.userPic.clipsToBounds = true;
    }
    
    
    
    @objc private  func termsmethod (baseURL:String , params: String)
    {
        print(params)
        
        // AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
        AFWrapperClass.requestPOSTURLWithUrlsession(baseURL, params: params, success: { (jsonDic) in
            
            DispatchQueue.main.async {
                AFWrapperClass.svprogressHudDismiss(view: self)
                let responceDic:NSDictionary = jsonDic as NSDictionary
                print(responceDic)
                if (responceDic.object(forKey: "responseCode") as! NSNumber) == 200
                {
                    
                    self.htmlstring = (responceDic.object(forKey: "terms") as? NSString)! as String
                    
                }
                else
                {
                    
                }
            }
            
        }) { (error) in
            
//            AFWrapperClass.svprogressHudDismiss(view: self)
//            AFWrapperClass.alert(Constants.applicationName, message: error.localizedDescription, view: self)
            //print(error.localizedDescription)
        }
    }

    
    @IBAction func PictureButtClicked(_ sender: Any)
    {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let pibraryAction = UIAlertAction(title: "From Photo Library", style: .default, handler:
        {(alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        let cameraction = UIAlertAction(title: "Camera", style: .default, handler:
        {(alert: UIAlertAction!) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker,animated: true,completion: nil)
                
            } else {
                AFWrapperClass.alert(Constants.applicationName, message: "Sorry, this device has no camera", view: self)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(pibraryAction)
        optionMenu.addAction(cameraction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            let popOverPresentationController : UIPopoverPresentationController = optionMenu.popoverPresentationController!
            popOverPresentationController.sourceView                = camerabutt
            popOverPresentationController.sourceRect                = camerabutt.bounds
            popOverPresentationController.permittedArrowDirections  = UIPopoverArrowDirection.any
        }
 
    }
    
    
    
    func image(withReduce imageName: UIImage, scaleTo newsize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newsize, false, 12.0)
        imageName.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(newsize.width), height: CGFloat(newsize.height)))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        return newImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        currentSelectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPic.image = image
        } else{
            
        }
        
        dismiss(animated: true, completion: nil)
    
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }

    
    
    
    
    @IBAction func RadioButtClicked(_ sender: Any)
    {
        
    }
    
    @IBAction func termsconditionsclicked(_ sender: Any)
    {
        self.TermsConditions()
    }
    
    
    func TermsConditions() -> Void
    {
        popview.isHidden=false
        footerView.isHidden=false
        
        popview.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview)
        
        footerView.frame = CGRect(x:10, y:40, width:popview.frame.size.width-20, height:popview.frame.size.height-80)
        footerView.backgroundColor = UIColor.white
        popview.addSubview(footerView)
        
        
        let Headview = UIView()
        Headview.frame = CGRect(x:0, y:0, width:footerView.frame.size.width, height:50)
        Headview.backgroundColor=#colorLiteral(red: 0.7461653352, green: 0.1301452518, blue: 0.2200570703, alpha: 1)
        footerView.addSubview(Headview)
        
        let titlelab = UILabel()
        titlelab.frame = CGRect(x:Headview.frame.size.width/2-100, y:5, width:200, height:40)
        titlelab.text="Terms and Conditions"
        titlelab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        titlelab.textColor=UIColor.white
        titlelab.textAlignment = .center
        Headview.addSubview(titlelab)
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:Headview.frame.size.width-35, y:15, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "cancel-music.png"), for: .normal)
        crossbutt.addTarget(self, action: #selector(AddProfileViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        Headview.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:Headview.frame.size.width-50, y:0, width:50, height:50)
        crossbutt2.addTarget(self, action: #selector(AddProfileViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        Headview.addSubview(crossbutt2)
        
        termsView.frame = CGRect(x:0, y:50, width:footerView.frame.size.width, height:footerView.frame.size.height-50)
        termsView.delegate = self
        termsView.backgroundColor=UIColor.white
        footerView.addSubview(termsView)
        //let htmlString: String = "<font face='Times New Roman' size='3'>\(htmlstring)"
        termsView.loadHTMLString(htmlstring, baseURL: nil)
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.fontFamily =\"-apple-system\"")
    }
    
    func CloseButtonAction(_ sender: UIButton!)
    {
        popview.isHidden=true
        footerView.isHidden=true
    }
    
    

    
    
    @IBAction func saveuploadClicked(_ sender: Any)
    {
        
        UserDefaults.standard.set(userName.text!, forKey: "name")
        UserDefaults.standard.set(userEmail.text!, forKey: "email")
        
        
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController
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
