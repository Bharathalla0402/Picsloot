//
//  ProfileViewController.swift
//  Picsloot
//
//  Created by think360 on 14/10/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class addessCell: UITableViewCell
{
    
}

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var userPic: UIImageView!

    @IBOutlet weak var addressTabl: UITableView!
    
     var Cell: addessCell!
    @IBOutlet weak var camerabutt: UIButton!
    
    var imagePicker = UIImagePickerController()
    var currentSelectedImage = UIImage()
    
    @IBOutlet weak var userName: ACFloatingTextfield!
    @IBOutlet weak var userEmail: ACFloatingTextfield!
    @IBOutlet weak var userMobile: ACFloatingTextfield!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userName.text = UserDefaults.standard.string(forKey: "name")
        userEmail.text = UserDefaults.standard.string(forKey: "email")
        userMobile.text = UserDefaults.standard.string(forKey: "mobile")
        
        
       
        
        
         imagePicker.delegate = self

        // Do any additional setup after loading the view.
        
        backButt.isHidden = true
        
      
        addressTabl.tableFooterView = UIView()
    }
    
    //MARK: NotificationButt clicked:
    
    @IBAction func NotificationbuttClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    @IBAction func ProfileButtClicked(_ sender: Any)
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
    

    
    
    @IBAction func SaveProfileClicked(_ sender: Any)
    {
        UserDefaults.standard.set(userName.text!, forKey: "name")
        UserDefaults.standard.set(userEmail.text!, forKey: "email")
        UserDefaults.standard.set(userMobile.text!, forKey: "mobile")
    }
    
    @IBAction func LogoutClicked(_ sender: Any)
    {
        
    }
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "addessCell"
        Cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? addessCell
        
        if Cell == nil
        {
            tableView.register(UINib(nibName: "addessCell", bundle: nil), forCellReuseIdentifier: identifier)
            Cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? addessCell
        }
        
        Cell.selectionStyle = UITableViewCellSelectionStyle.none
        addressTabl.separatorStyle = .none
        addressTabl.separatorColor = UIColor.clear
        
        return Cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressViewController") as? EditAddressViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        backView.backgroundColor = #colorLiteral(red: 0.933103919, green: 0.08461549133, blue: 0.0839477703, alpha: 1)
        
        
        
        let myImage = UIImageView(frame: CGRect(x: backView.frame.size.width/2-8, y: backView.frame.size.height/2-14, width: 16, height: 16))
        
        myImage.image = UIImage(named: "Delete")
        
        backView.addSubview(myImage)
        
        
        
        let label = UILabel(frame: CGRect(x: 0, y: myImage.frame.origin.y+14, width: backView.frame.size.width, height: 25))
        
        label.text = "Remove"
        
        label.textAlignment = .center
        
        label.textColor = UIColor.white
        
        label.font = UIFont(name: label.font.fontName, size: 14)
        
        backView.addSubview(label)
        
        
        
        
        
        
        
        let imgSize: CGSize = tableView.frame.size
        
        UIGraphicsBeginImageContextWithOptions(imgSize, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        
        backView.layer.render(in: context!)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        
        
        
        
        
        
        let delete = UITableViewRowAction(style: .destructive, title: "           ") { (action, indexPath) in
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressViewController") as? EditAddressViewController
            self.navigationController?.pushViewController(myVC!, animated: true)
            
        }
        
        
        
        delete.backgroundColor = UIColor(patternImage: newImage)
        
        
        
        
        
        
        
        
        
        
        
        let backViewEdit = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        backViewEdit.backgroundColor = #colorLiteral(red: 0.1318215132, green: 0.01255247556, blue: 0.8887208104, alpha: 1)
        
        
        
        let editImage = UIImageView(frame: CGRect(x: backViewEdit.frame.size.width/2-8, y: backViewEdit.frame.size.height/2-14, width: 16, height: 16))
        
        editImage.image = UIImage(named: "Edit")
        
        backViewEdit.addSubview(editImage)
        
        
        
        let editLabel = UILabel(frame: CGRect(x: 0, y: myImage.frame.origin.y+14, width: backViewEdit.frame.size.width, height: 25))
        
        editLabel.text = "Edit  "
        
        editLabel.textAlignment = .center
        
        editLabel.textColor = UIColor.white
        
        editLabel.font = UIFont(name: label.font.fontName, size: 14)
        
        backViewEdit.addSubview(editLabel)
        
        
        
        
        
        
        
        let imgSizeEdit: CGSize = tableView.frame.size
        
        UIGraphicsBeginImageContextWithOptions(imgSizeEdit, false, UIScreen.main.scale)
        
        let contextEdit = UIGraphicsGetCurrentContext()
        
        backViewEdit.layer.render(in: contextEdit!)
        
        let newImageEdit: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        
        
        
        
        let share = UITableViewRowAction(style: .normal, title: "          ") { (action, indexPath) in
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressViewController") as? EditAddressViewController
            self.navigationController?.pushViewController(myVC!, animated: true)
            
        }
        
        
        
        share.backgroundColor = UIColor(patternImage: newImageEdit)
        
        
        
        
        
        
        
        
        
        return [delete, share]
        
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
