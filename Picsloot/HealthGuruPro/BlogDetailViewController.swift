//
//  BlogDetailViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 19/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit
import LCBannerView
import SDWebImage

class blogcell2: UITableViewCell
{
    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var blogSpecify: UILabel!
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var blogUser: UILabel!
    @IBOutlet weak var blogSpecialist: UILabel!
    @IBOutlet weak var bloglikeImage: UIImageView!
    @IBOutlet weak var blogLikeCount: UILabel!
    
}

class BlogDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var imageBannerView: UIView!
    @IBOutlet weak var backButt: UIButton!
    
    @IBOutlet weak var bloguserImage: UIImageView!
    @IBOutlet weak var bloguserName: UILabel!
    @IBOutlet weak var bloguserSpecify: UILabel!
    @IBOutlet weak var datelab: UILabel!
    
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var blogDescription: UILabel!
    @IBOutlet weak var blogSpecifyItem: UILabel!
    @IBOutlet weak var blogTabl: UITableView!
    @IBOutlet weak var blogTablHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bloglikeImage: UIImageView!
    @IBOutlet weak var bloglikeCount: UILabel!
    @IBOutlet weak var blogShareImage: UIImageView!
    @IBOutlet weak var blogLikeButt: UIButton!
    @IBOutlet weak var blogShareButt: UIButton!
    
    
    var  imagesArray = NSArray()
    
    var cell: blogcell2!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         blogTabl.tableFooterView = UIView()
        
        bloguserImage.image = UIImage(named: "User")
        blogTitle.text = "7 Reasons Why Protien Is Effective For Weight Loss"
        blogDescription.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
         blogTablHeight.constant = (2) * (122)
       

        // Do any additional setup after loading the view.
    }
    
   
    
    //MARK: TableView Delegates and Datasource:
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 122
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let identifier = "blogcell2"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell2
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "blogcell2", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell2
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        blogTabl.separatorStyle = .none
        blogTabl.separatorColor = UIColor.clear
        
        if indexPath.row == 0 || indexPath.row == 2
        {
            cell.blogImage.image = UIImage(named: "blogimage")
            cell.blogSpecify.text = "Weight Loss"
        }
        else
        {
            cell.blogImage.image = UIImage(named: "blogimage2")
            cell.blogSpecify.text = "Hair Fall"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    
    @IBAction func likeButtClicked(_ sender: Any)
    {
        
    }
    
    
    @IBAction func ShareButtClicked(_ sender: Any)
    {
        let text = "HealthGuruPro"
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
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
