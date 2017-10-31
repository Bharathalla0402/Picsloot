//
//  FeedBackViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 20/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class feedbackCell: UITableViewCell
{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPosted: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var reportButt: UIButton!
}

class FeedBackViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var ratingCountlab: UILabel!
    @IBOutlet weak var RatingView: UIView!
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var DoctorLikeCount: UILabel!
    @IBOutlet weak var DoctorDislikeCount: UILabel!
    @IBOutlet weak var StaffLikeCount: UILabel!
    @IBOutlet weak var StaffDislikeCount: UILabel!
    
    @IBOutlet weak var feedbackTabl: UITableView!
    @IBOutlet weak var feedbackTablHeight: NSLayoutConstraint!
    
    
    var strValue = NSString()
    var indicateimage = UIImageView()
    
    var cell:feedbackCell!
    
    var label1 = UILabel()
    
    var popview2 = UIView()
    var footerView2 = UIView()
    var ReportMessage = UITextView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ratingCountlab.text = "92 FeedBack Received"
        
        label1.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
        
        
        
        feedbackTabl.rowHeight = UITableViewAutomaticDimension
        feedbackTabl.estimatedRowHeight = 174
        feedbackTabl.tableFooterView = UIView()
        
        
        guard let labelText = label1.text else { return }
        let height = estimatedHeightOfLabel(text: labelText)
        print(height)
        
        
        feedbackTablHeight.constant = (3) * (164+height);
        
        print(feedbackTablHeight.constant)
        
       
        ratingScale()
    }
    
    func estimatedHeightOfLabel(text: String) -> CGFloat {
        
        let size = CGSize(width: view.frame.width - 16, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight
    }

    
    func ratingScale() -> Void
    {
        let rateimage1 = UIImageView(frame: CGRect(x: self.view.frame.size.width - 180, y: 12, width: 16, height: 16))
        rateimage1.image = UIImage(named: "box_1.png")
        rateimage1.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage1)
        
        let rateimage2 = UIImageView(frame: CGRect(x: rateimage1.frame.size.width + rateimage1.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage2.image = UIImage(named: "box_2.png")
        rateimage2.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage2)
        
        let rateimage3 = UIImageView(frame: CGRect(x: rateimage2.frame.size.width + rateimage2.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage3.image = UIImage(named: "box_3.png")
        rateimage3.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage3)
        
        let rateimage4 = UIImageView(frame: CGRect(x: rateimage3.frame.size.width + rateimage3.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage4.image = UIImage(named: "box_4.png")
        rateimage4.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage4)
        
        let rateimage5 = UIImageView(frame: CGRect(x: rateimage4.frame.size.width + rateimage4.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage5.image = UIImage(named: "box_5.png")
        rateimage5.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage5)
        
        let rateimage6 = UIImageView(frame: CGRect(x: rateimage5.frame.size.width + rateimage5.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage6.image = UIImage(named: "box_6.png")
        rateimage6.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage6)
        
        let rateimage7 = UIImageView(frame: CGRect(x: rateimage6.frame.size.width + rateimage6.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage7.image = UIImage(named: "box_7.png")
        rateimage7.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage7)
        
        let rateimage8 = UIImageView(frame: CGRect(x: rateimage7.frame.size.width + rateimage7.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage8.image = UIImage(named: "box_8.png")
        rateimage8.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage8)
        
        let rateimage9 = UIImageView(frame: CGRect(x: rateimage8.frame.size.width + rateimage8.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage9.image = UIImage(named: "box_9.png")
        rateimage9.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage9)
        
        let rateimage10 = UIImageView(frame: CGRect(x: rateimage9.frame.size.width + rateimage9.frame.origin.x, y: 12, width: 16, height: 16))
        rateimage10.image = UIImage(named: "box_10.png")
        rateimage10.contentMode = .scaleAspectFit
        RatingView.addSubview(rateimage10)
        
        
        strValue = "92"
        
        let a = Int(CInt(strValue as String)!)
        
        if a >= 0 && a <= 4
        {
            indicateimage = UIImageView(frame: CGRect(x: rateimage1.frame.size.width / 2 + rateimage1.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 5 && a <= 10
        {
            indicateimage = UIImageView(frame: CGRect(x: rateimage1.frame.size.width / 2 + rateimage1.frame.origin.x - 6, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 11 && a <= 20
        {
            indicateimage = UIImageView(frame: CGRect(x: rateimage2.frame.size.width / 2 + rateimage2.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 21 && a <= 30
        {
            indicateimage = UIImageView(frame: CGRect(x: rateimage3.frame.size.width / 2 + rateimage3.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 31 && a <= 40 {
            indicateimage = UIImageView(frame: CGRect(x: rateimage4.frame.size.width / 2 + rateimage4.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 41 && a <= 50
        {
            indicateimage = UIImageView(frame: CGRect(x: rateimage5.frame.size.width / 2 + rateimage5.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 51 && a <= 60 {
            indicateimage = UIImageView(frame: CGRect(x: rateimage6.frame.size.width / 2 + rateimage6.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 61 && a <= 70 {
            indicateimage = UIImageView(frame: CGRect(x: rateimage7.frame.size.width / 2 + rateimage7.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 71 && a <= 80 {
            indicateimage = UIImageView(frame: CGRect(x: rateimage8.frame.size.width / 2 + rateimage8.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 81 && a <= 90
        {
            indicateimage = UIImageView(frame: CGRect(x: rateimage9.frame.size.width / 2 + rateimage9.frame.origin.x - 7, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 91 && a <= 95 {
            indicateimage = UIImageView(frame: CGRect(x: rateimage10.frame.size.width / 2 + rateimage10.frame.origin.x - 7 , y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        else if a >= 96 && a <= 100 {
            indicateimage = UIImageView(frame: CGRect(x: rateimage10.frame.size.width / 2 + rateimage10.frame.origin.x - 2, y: rateimage1.frame.size.height + rateimage1.frame.origin.y - 4, width: 14, height: 14))
            indicateimage.image = UIImage(named: "arrow-rating.png")
            indicateimage.contentMode = .scaleAspectFit
            RatingView.addSubview(indicateimage)
        }
        
        
        let PercentNamelabel = UILabel(frame: CGRect(x: indicateimage.frame.origin.x - 5, y: indicateimage.frame.size.height + indicateimage.frame.origin.y - 8, width: 28, height: 20))
        PercentNamelabel.text = strValue as String + "%"
        PercentNamelabel.font = UIFont.systemFont(ofSize: 10)
        PercentNamelabel.textAlignment = .center
        PercentNamelabel.textColor = UIColor.darkGray
        RatingView.addSubview(PercentNamelabel)

    }
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
     //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "feedbackCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? feedbackCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "feedbackCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? feedbackCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        feedbackTabl.separatorStyle = .none
        feedbackTabl.separatorColor = UIColor.clear
        
        cell.userImage.image = UIImage(named: "User")
        cell.userDescription.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
        
//        let frame = tableView.rectForRow(at: indexPath)
//        print(frame.size.height)
        
        
        cell.reportButt.addTarget(self, action: #selector(FeedBackViewController.ReportButtClicked), for: .touchUpInside)
        
        return cell
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    

    
    //MARK: Report Butt Clicked
    
    func ReportButtClicked(_ sender: AnyObject)
    {
        popview2.isHidden=false
        footerView2.isHidden=false
        
        ReportMessage.text = ""
        
        popview2.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        popview2.backgroundColor=UIColor(patternImage: UIImage(named: "black_strip1.png")!)
        self.view.addSubview(popview2)
        
        footerView2.frame = CGRect(x:30, y:popview2.frame.size.height/2-140, width:self.view.frame.size.width-60, height:280)
        footerView2.backgroundColor = UIColor.white
        popview2.addSubview(footerView2)
        
        
        let titlelab = UILabel()
        titlelab.frame = CGRect(x:0, y:15, width:footerView2.frame.size.width, height:20)
        titlelab.text="Feedback Report"
        titlelab.textColor=#colorLiteral(red: 0.2078222036, green: 0.2078569531, blue: 0.2078112364, alpha: 1)
        titlelab.textAlignment = .center
        footerView2.addSubview(titlelab)
        
        let titlelab2 = UILabel()
        titlelab2.frame = CGRect(x:15, y:50, width:footerView2.frame.size.width-30, height:20)
        titlelab2.text="Type Message"
        titlelab2.textColor=#colorLiteral(red: 0.2078222036, green: 0.2078569531, blue: 0.2078112364, alpha: 1)
        titlelab2.textAlignment = .left
        footerView2.addSubview(titlelab2)
        
    
        ReportMessage.frame = CGRect(x:15, y:80, width:footerView2.frame.size.width-30, height:100)
        ReportMessage.textColor=#colorLiteral(red: 0.1454493999, green: 0.2132318318, blue: 0.9278818965, alpha: 1)
        ReportMessage.textAlignment = .left
        footerView2.addSubview(ReportMessage)
        
        
        let linelab = UILabel()
        linelab.frame = CGRect(x:15, y:200, width:footerView2.frame.size.width-30, height:2)
        linelab.backgroundColor = #colorLiteral(red: 0.1454493999, green: 0.2132318318, blue: 0.9278818965, alpha: 1)
        footerView2.addSubview(linelab)
        
        
        let submitbutt = UIButton()
        submitbutt.frame = CGRect(x:15, y:220, width:footerView2.frame.size.width-30, height:45)
        submitbutt.setTitle("Submit", for: .normal)
        submitbutt.backgroundColor = #colorLiteral(red: 0.1454493999, green: 0.2132318318, blue: 0.9278818965, alpha: 1)
        submitbutt.setTitleColor(.white, for: .normal)
        submitbutt.cornerRadius = 4.0
        submitbutt.addTarget(self, action: #selector(FeedBackViewController.SubmitButtonAction(_:)), for: UIControlEvents.touchUpInside)
        footerView2.addSubview(submitbutt)
        
    }
    
    func SubmitButtonAction(_ sender: AnyObject)
    {
        popview2.isHidden=true
        footerView2.isHidden=true
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
