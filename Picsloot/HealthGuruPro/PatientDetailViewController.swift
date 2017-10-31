//
//  PatientDetailViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 14/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class PrescriptionCell: UICollectionViewCell
{
    @IBOutlet weak var PrescriptionImage: UIImageView!
    @IBOutlet weak var deletePresButt: UIButton!
}

class PatientDetailViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate
{
    
     var cell: PrescriptionCell!
    
    @IBOutlet weak var NotificationCount: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userWeekDay: UILabel!
    @IBOutlet weak var userPreferTime: UILabel!
    
    @IBOutlet weak var prescriptionLab: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var PrescriptionCollectionView: UICollectionView!
    
    var imagePicker = UIImagePickerController()
    var currentSelectedImage = UIImage()
    @IBOutlet weak var cameraButton: UIButton!
    
    
    var popview2 = UIView()
    var footerView2 = UIView()
    var scroolMain = UIScrollView()
    var imageCollection = UIImageView()
    
    var arrimages = NSMutableArray()
    var SelectedImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         imagePicker.delegate = self
        
        userLocation.text = "Sco 106, Top Floor, Sector 40C, Chandigarah, India, 160036"
        
        var imag = UIImage()
        imag = UIImage(named: "SampleDoc")!
        
        var arr = NSMutableArray()
        arr.add(imag)
        arr=arr as AnyObject as! NSMutableArray
        arrimages.addObjects(from: arr as [AnyObject])

        // Do any additional setup after loading the view.
    }
    
     // MARK:  Notification Butt Clicked
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    // MARK:  QR Clicked
    
    @IBAction func QRCodeClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "QrReaderViewController") as? QrReaderViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
     // MARK:  Profile Butt Clicked
    
    @IBAction func ProfileButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PatientProfileViewController") as? PatientProfileViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    // MARK:  Appointment Butt Clicked
    
    @IBAction func AppointmentButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentHistoryViewController") as? AppointmentHistoryViewController
        myVC?.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    // MARK:  Advice Butt Clicked
    
    @IBAction func AdviceButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AdviceTestViewController") as? AdviceTestViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrimages.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrescriptionCell", for: indexPath) as! PrescriptionCell
        
        cell.PrescriptionImage.image = arrimages[indexPath.row] as? UIImage
        cell.deletePresButt.tag = indexPath.row
        cell.deletePresButt.addTarget(self, action: #selector(PatientDetailViewController.DeleteImageClicked), for: .touchUpInside)
        return cell
    }
    
    func DeleteImageClicked(_ sender: AnyObject)
    {
        print(sender.tag)
        arrimages.remove(arrimages[sender.tag])
        print(arrimages.count)
        
        PrescriptionCollectionView.reloadData()
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
         SelectedImage = (arrimages[indexPath.row] as? UIImage)!
      imagePopUp()
    }
    
    
    func imagePopUp() -> Void
    {
        popview2.isHidden=false
        footerView2.isHidden=false
        
        // arryDatalistids.removeAllObjects()
        
        popview2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview2.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview2)
        
        footerView2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        footerView2.backgroundColor = UIColor.white
        popview2.addSubview(footerView2)
        
        let bglab = UILabel()
        bglab.frame = CGRect(x:0, y:0, width:footerView2.frame.size.width, height:64)
        bglab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        footerView2.addSubview(bglab)
        
        let forgotlab = UILabel()
        forgotlab.frame = CGRect(x:0, y:13, width:footerView2.frame.size.width, height:51)
        forgotlab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        forgotlab.text="Urine Routine Examination"
        forgotlab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        forgotlab.textColor=#colorLiteral(red: 0.143925637, green: 0.1810115576, blue: 0.9281523824, alpha: 1)
        forgotlab.textAlignment = .center
        footerView2.addSubview(forgotlab)
        
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:8, y:27, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "Cross"), for: .normal)
        crossbutt.addTarget(self, action: #selector(PatientDetailViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:0, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(PatientDetailViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt2)
        
        scroolMain.frame = CGRect(x:0, y:64, width:footerView2.frame.size.width, height:footerView2.frame.size.height-64)
        footerView2.addSubview(scroolMain)
        
        scroolMain.minimumZoomScale = 1.0
        scroolMain.maximumZoomScale = 6.0
        scroolMain.contentSize = CGSize(width: 1280, height: 960)
        scroolMain.delegate = self
        
        
        imageCollection.frame = CGRect(x:0, y:0, width:scroolMain.frame.size.width, height:scroolMain.frame.size.height)
        imageCollection.image = SelectedImage
        imageCollection.contentMode = .scaleAspectFit
        
        
        
        scroolMain.addSubview(imageCollection)
    }
    
    
    func CloseButtonAction(_ sender: UIButton!)
    {
        popview2.isHidden=true
        footerView2.isHidden=true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return imageCollection
    }
    

     // MARK:  Add Test Butt Clicked

    @IBAction func AddTestButtClicked(_ sender: Any)
    {
//        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AddMoreTestViewController") as? AddMoreTestViewController
//        myVC?.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(myVC!, animated: true)
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "AdviceTestViewController") as? AdviceTestViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
     // MARK:  Add Prescription Butt Clicked
    
    @IBAction func AddPrescriptionButtClicked(_ sender: Any)
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
            popOverPresentationController.sourceView                = cameraButton
            popOverPresentationController.sourceRect                = cameraButton.bounds
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
//        currentSelectedImage = self.image(withReduce: currentSelectedImage, scaleTo: CGSize(width: CGFloat(25), height: CGFloat(25)))
        
        dismiss(animated: true, completion: nil)
        
        imagePopUp2()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    

    
    func imagePopUp2() -> Void
    {
        popview2.isHidden=false
        footerView2.isHidden=false
        
        // arryDatalistids.removeAllObjects()
        
        popview2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview2.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview2)
        
        footerView2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        footerView2.backgroundColor = UIColor.white
        popview2.addSubview(footerView2)
        
        let bglab = UILabel()
        bglab.frame = CGRect(x:0, y:0, width:footerView2.frame.size.width, height:64)
        bglab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        footerView2.addSubview(bglab)
        
        let forgotlab = UILabel()
        forgotlab.frame = CGRect(x:0, y:13, width:footerView2.frame.size.width, height:51)
        forgotlab.backgroundColor=#colorLiteral(red: 0.2318001091, green: 0.9187230468, blue: 0.8519064784, alpha: 1)
        forgotlab.text="Prescription"
        forgotlab.font =  UIFont(name:"Helvetica-Bold", size: 18)
        forgotlab.textColor=#colorLiteral(red: 0.143925637, green: 0.1810115576, blue: 0.9281523824, alpha: 1)
        forgotlab.textAlignment = .center
        footerView2.addSubview(forgotlab)
        
        
        let crossbutt = UIButton()
        crossbutt.frame = CGRect(x:8, y:27, width:25, height:25)
        crossbutt.setImage( UIImage.init(named: "Cross"), for: .normal)
        crossbutt.addTarget(self, action: #selector(AddMoreTestViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:footerView2.frame.size.width-50, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(AddMoreTestViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt2)
        
        
        
        let Rightbutt = UIButton()
        Rightbutt.frame = CGRect(x:footerView2.frame.size.width-35, y:27, width:25, height:25)
        Rightbutt.setImage( UIImage.init(named: "Right"), for: .normal)
        Rightbutt.addTarget(self, action: #selector(PatientDetailViewController.RightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(Rightbutt)
        
        let Rightbutt2 = UIButton()
        Rightbutt2.frame = CGRect(x:footerView2.frame.size.width-50, y:20, width:50, height:40)
        Rightbutt2.addTarget(self, action: #selector(PatientDetailViewController.RightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(Rightbutt2)
        
        
        
        let ProfileView = UIView()
        ProfileView.frame = CGRect(x:0, y:64, width:footerView2.frame.size.width, height:70)
        ProfileView.backgroundColor = .white
        footerView2.addSubview(ProfileView)
        
        let userImage = UIImageView()
        userImage.frame = CGRect(x:10, y:10, width:50, height:50)
        userImage.image = UIImage(named: "User")
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 25
        userImage.clipsToBounds = true
        ProfileView.addSubview(userImage)
        
        let userName = UILabel()
        userName.frame = CGRect(x:70, y:10, width:ProfileView.frame.size.width-80, height:25)
        userName.text = "Harpreet Kaur"
        userName.font = UIFont .systemFont(ofSize: 14)
        userName.textAlignment = .left
        ProfileView.addSubview(userName)
        
        let usertype = UILabel()
        usertype.frame = CGRect(x:70, y:35, width:75, height:25)
        usertype.text = "Corporate"
        usertype.layer.cornerRadius = 4.0
        usertype.layer.borderWidth = 1.0
        usertype.layer.borderColor = UIColor.init(red:59/255.0, green:234/255.0, blue:217/255.0, alpha: 1.0).cgColor
        usertype.font = UIFont .systemFont(ofSize: 12)
        usertype.textAlignment = .center
        ProfileView.addSubview(usertype)
        
        
        
        scroolMain.frame = CGRect(x:0, y:134, width:footerView2.frame.size.width, height:footerView2.frame.size.height-134)
        scroolMain.backgroundColor=#colorLiteral(red: 0.952861011, green: 0.952994287, blue: 0.9528189301, alpha: 1)
        footerView2.addSubview(scroolMain)
        
        scroolMain.minimumZoomScale = 1.0
        scroolMain.maximumZoomScale = 6.0
        scroolMain.contentSize = CGSize(width: 1280, height: 960)
        scroolMain.delegate = self
        
        
        imageCollection.frame = CGRect(x:0, y:0, width:scroolMain.frame.size.width, height:scroolMain.frame.size.height)
        imageCollection.image = currentSelectedImage
        imageCollection.contentMode = .scaleAspectFit
        
        
        scroolMain.addSubview(imageCollection)
    }

    
    func RightButtonAction(_ sender: UIButton!)
    {
        popview2.isHidden=true
        footerView2.isHidden=true
        
        var imag = UIImage()
        imag = currentSelectedImage
        
        var arr = NSMutableArray()
        arr.add(imag)
        arr=arr as AnyObject as! NSMutableArray
        arrimages.addObjects(from: arr as [AnyObject])
        
        print(arrimages)
        
        PrescriptionCollectionView.reloadData()
    }
    
    
    

    @IBAction func BackButtClicked(_ sender: Any)
    {
      _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
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
