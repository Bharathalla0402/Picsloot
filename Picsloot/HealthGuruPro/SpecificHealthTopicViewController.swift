//
//  SpecificHealthTopicViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 19/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class blogcell3: UITableViewCell
{
    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var blogSpecify: UILabel!
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var blogUser: UILabel!
    @IBOutlet weak var blogSpecialist: UILabel!
    @IBOutlet weak var bloglikeImage: UIImageView!
    @IBOutlet weak var blogLikeCount: UILabel!
    @IBOutlet weak var cellButt: UIButton!
    
}


class SpecificHealthTopicViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var blogTablView: UITableView!
    
    var cell: blogcell3!
    
    var arryDatalistids = NSMutableArray()
    var arrChildCategory : NSMutableArray = ["Weight Loss","HairFall"]
    var searchResults = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
         blogTablView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NOtificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
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
        
        let identifier = "blogcell3"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell3
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "blogcell3", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell3
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        blogTablView.separatorStyle = .none
        blogTablView.separatorColor = UIColor.clear
        
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4
        {
            cell.blogImage.image = UIImage(named: "blogimage")
            cell.blogSpecify.text = "Weight Loss"
        }
        else
        {
            cell.blogImage.image = UIImage(named: "blogimage2")
            cell.blogSpecify.text = "Hair Fall"
        }
        
         cell.cellButt.addTarget(self, action: #selector(SpecificHealthTopicViewController.multipleParamSelector), for: .touchUpInside)
        
        return cell
    }
    
    func multipleParamSelector(_ sender: AnyObject)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "BlogDetailViewController") as? BlogDetailViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
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
