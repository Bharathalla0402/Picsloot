//
//  DoctorProfileViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 20/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class apppicCell: UICollectionViewCell
{
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var addMoreLab: UILabel!
    @IBOutlet weak var removeButt: UIButton!
}


class DoctorProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var Name: ACFloatingTextfield!
    @IBOutlet weak var MobileNumber: ACFloatingTextfield!
    @IBOutlet weak var Email: ACFloatingTextfield!
    @IBOutlet weak var txtTimeSlot: ACFloatingTextfield!

    @IBOutlet weak var sunButt: UIButton!
    @IBOutlet weak var MonButt: UIButton!
    @IBOutlet weak var TueButt: UIButton!
    @IBOutlet weak var WedButt: UIButton!
    @IBOutlet weak var ThuButt: UIButton!
    @IBOutlet weak var FriButt: UIButton!
    @IBOutlet weak var SatButt: UIButton!
    
    
    @IBOutlet weak var picsCollectionView: UICollectionView!
    
    @IBOutlet weak var saveButt: UIButton!
    
     var cell: apppicCell!
    
    var clicked1 = false
    var clicked2 = true
    var clicked3 = true
    var clicked4 = true
    var clicked5 = true
    var clicked6 = true
    var clicked7 = false
    
    
    var cell2: TimeSlotCell!
    var MorninglistArray = NSMutableArray()
    var EveninglistArray = NSMutableArray()
    
    var popview = UIView()
    var footerView = UIView()
    
    var checkStr = NSString()
    
    @IBOutlet var MorningTabl: UITableView!
    @IBOutlet var EveningTabl: UITableView!
    
    var popview2 = UIView()
    var footerView2 = UIView()
    var scroolMain = UIScrollView()
    var imageCollection = UIImageView()
    
    var arrimages = NSMutableArray()
    var a = Int()
    
    var imagePicker = UIImagePickerController()
    var currentSelectedImage = UIImage()
    @IBOutlet weak var cameraButton: UIButton!
    
    var SelectedImage = UIImage()
    var lab = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        var imag = UIImage()
        imag = UIImage(named: "DoctorPic")!
        
        var arr = NSMutableArray()
        arr.add(imag)
        arr=arr as AnyObject as! NSMutableArray
        arrimages.addObjects(from: arr as [AnyObject])
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    @IBAction func TimeSlotButtClicked(_ sender: Any)
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
        return cell2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.tag == 1
        {
            popview.isHidden=true
            footerView.isHidden=true
            txtTimeSlot.text = "09 - 10"
        }
        else if tableView.tag == 2
        {
            popview.isHidden=true
            footerView.isHidden=true
            txtTimeSlot.text = "02 - 03"
        }
        else
        {
            
        }
    }
    
 // MARK:  WeekDays Clicked
    
    @IBAction func SunButtClicked(_ sender: Any)
    {
        
        if clicked1
        {
            self.sunButt.layer.borderWidth = 2
            self.sunButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.sunButt.backgroundColor = .clear
            sunButt.setTitleColor(UIColor.darkGray, for: .normal)
           // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked1 = false
        }
        else
        {
            self.sunButt.layer.borderWidth = 0
            self.sunButt.layer.borderColor = UIColor.clear.cgColor
            self.sunButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            sunButt.setTitleColor(.white, for: .normal)
            
            clicked1 = true
        }
    }
    
    @IBAction func MonButtClicked(_ sender: Any)
    {
        if clicked2
        {
            self.MonButt.layer.borderWidth = 2
            self.MonButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.MonButt.backgroundColor = .clear
            MonButt.setTitleColor(UIColor.darkGray, for: .normal)
            // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked2 = false
        }
        else
        {
            self.MonButt.layer.borderWidth = 0
            self.MonButt.layer.borderColor = UIColor.clear.cgColor
            self.MonButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            MonButt.setTitleColor(.white, for: .normal)
            
            clicked2 = true
        }

    }
    
    @IBAction func TueButtClicked(_ sender: Any)
    {
        if clicked3
        {
            self.TueButt.layer.borderWidth = 2
            self.TueButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.TueButt.backgroundColor = .clear
            TueButt.setTitleColor(UIColor.darkGray, for: .normal)
            // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked3 = false
        }
        else
        {
            self.TueButt.layer.borderWidth = 0
            self.TueButt.layer.borderColor = UIColor.clear.cgColor
            self.TueButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            TueButt.setTitleColor(.white, for: .normal)
            
            clicked3 = true
        }

    }
    
    @IBAction func WedButtClicked(_ sender: Any)
    {
        if clicked4
        {
            self.WedButt.layer.borderWidth = 2
            self.WedButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.WedButt.backgroundColor = .clear
            WedButt.setTitleColor(UIColor.darkGray, for: .normal)
            // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked4 = false
        }
        else
        {
            self.WedButt.layer.borderWidth = 0
            self.WedButt.layer.borderColor = UIColor.clear.cgColor
            self.WedButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            WedButt.setTitleColor(.white, for: .normal)
            
            clicked4 = true
        }

    }
   
    @IBAction func ThuButtClicked(_ sender: Any)
    {
        if clicked5
        {
            self.ThuButt.layer.borderWidth = 2
            self.ThuButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.ThuButt.backgroundColor = .clear
            ThuButt.setTitleColor(UIColor.darkGray, for: .normal)
            // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked5 = false
        }
        else
        {
            self.ThuButt.layer.borderWidth = 0
            self.ThuButt.layer.borderColor = UIColor.clear.cgColor
            self.ThuButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            ThuButt.setTitleColor(.white, for: .normal)
            
            clicked5 = true
        }

    }
    
    @IBAction func FriButtClicked(_ sender: Any)
    {
        if clicked6
        {
            self.FriButt.layer.borderWidth = 2
            self.FriButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.FriButt.backgroundColor = .clear
            FriButt.setTitleColor(UIColor.darkGray, for: .normal)
            // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked6 = false
        }
        else
        {
            self.FriButt.layer.borderWidth = 0
            self.FriButt.layer.borderColor = UIColor.clear.cgColor
            self.FriButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            FriButt.setTitleColor(.white, for: .normal)
            
            clicked6 = true
        }

    }
    
    @IBAction func SatButtClicked(_ sender: Any)
    {
        if clicked7
        {
            self.SatButt.layer.borderWidth = 2
            self.SatButt.layer.borderColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            self.SatButt.backgroundColor = .clear
            SatButt.setTitleColor(UIColor.darkGray, for: .normal)
            // sunButt.tintColor = UIColor.init(red:82/255.0, green:82/255.0, blue:82/255.0, alpha: 1.0).cgColor
            
            clicked7 = false
        }
        else
        {
            self.SatButt.layer.borderWidth = 0
            self.SatButt.layer.borderColor = UIColor.clear.cgColor
            self.SatButt.backgroundColor = UIColor.init(colorLiteralRed: (37/255), green: (54/255), blue: (237/255), alpha: 1)
            SatButt.setTitleColor(.white, for: .normal)
            
            clicked7 = true
        }
    }
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        a = Int(arrimages.count)
        a = a + 1
        return a
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "apppicCell", for: indexPath) as! apppicCell
        
        if indexPath.item == a - 1
        {
            cell.picImage.image = nil
            cell.removeButt.isHidden = true
            cell.addMoreLab.isHidden = false
        }
        else
        {
            cell.addMoreLab.isHidden = true
            cell.removeButt.isHidden = false
            cell.removeButt.tag = indexPath.row
            cell.removeButt.addTarget(self, action: #selector(DoctorProfileViewController.DeleteImageClicked), for: .touchUpInside)
            cell.picImage.image = arrimages[indexPath.row] as? UIImage
        }
        
        return cell
    }
    
    
    func DeleteImageClicked(_ sender: AnyObject)
    {
        print(sender.tag)
        arrimages.remove(arrimages[sender.tag])
        print(arrimages.count)
        
        picsCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item == a - 1
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
                popOverPresentationController.sourceView                = cell
                popOverPresentationController.sourceRect                = cell.bounds
                popOverPresentationController.permittedArrowDirections  = UIPopoverArrowDirection.any
            }

        }
        else
        {
            SelectedImage = (arrimages[indexPath.row] as? UIImage)!
          imagePopUp()
        }
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
        crossbutt.addTarget(self, action: #selector(DoctorProfileViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(crossbutt)
        
        let crossbutt2 = UIButton()
        crossbutt2.frame = CGRect(x:0, y:20, width:50, height:40)
        crossbutt2.addTarget(self, action: #selector(DoctorProfileViewController.CloseButtonAction(_:)), for: UIControlEvents.touchUpInside)
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
        
        var imag = UIImage()
        imag = currentSelectedImage
      
        var arr = NSMutableArray()
        arr.add(imag)
        arr=arr as AnyObject as! NSMutableArray
        arrimages.addObjects(from: arr as [AnyObject])
        
        print(arrimages)
        
        picsCollectionView.reloadData()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    


    
    
    @IBAction func BackButtClicked(_ sender: Any)
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
