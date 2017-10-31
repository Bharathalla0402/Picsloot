//
//  BlogViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 18/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class blogcell: UITableViewCell
{
    @IBOutlet weak var blogImage: UIImageView!
    @IBOutlet weak var blogSpecify: UILabel!
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var blogUser: UILabel!
    @IBOutlet weak var blogSpecialist: UILabel!
    @IBOutlet weak var bloglikeImage: UIImageView!
    @IBOutlet weak var blogLikeCount: UILabel!

}

class blogTypescell: UICollectionViewCell
{
    @IBOutlet weak var typeNameCell: UILabel!
}


class BlogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var backButt: UIButton!
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var blogSegment: UISegmentedControl!
    @IBOutlet weak var blogTabl: UITableView!
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var InterestedLab: UILabel!
    @IBOutlet weak var headerHeightConst: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionview: UIView!
    @IBOutlet weak var blogTypeCollectionView: UICollectionView!
    @IBOutlet weak var blogTablHeight: NSLayoutConstraint!
    
    var cell: blogcell!
    var cell2: blogcell!
    
    var cellColl: blogTypescell!
    
    var NewlistArray = NSMutableArray()
    var OldlistArray = NSMutableArray()
    
    // var theSearchBar: UISearchBar?
    
    @IBOutlet weak var theSearchBar: UISearchBar!
    
    var arryDatalistids = NSMutableArray()
    var arrChildCategory : NSMutableArray = ["Weight Loss","HairFall"]
    var searchResults = NSMutableArray()
    
    var blogTypeArray : NSMutableArray = ["NUTRITION","HEALTHY TEETH", "HEALTH & IMMUNITY", "WEIGHT LOSS"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
         backButt.isHidden = true
         blogTabl.tableFooterView = UIView()
         blogTabl.tag = 3
        
        HeaderView.isHidden = true
        collectionview.isHidden = true
        headerHeightConst.constant = 0
        collectionViewHeight.constant = 0
        blogTablHeight.constant = (3) * (122)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func NotificationButtClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    @IBAction func ChooseInterestClicked(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "HealthTopicViewController") as? HealthTopicViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    @IBAction func blogSegmentChanged(_ sender: Any)
    {
        if blogSegment.selectedSegmentIndex == 0
        {
            blogTabl.tag = 3
            
            HeaderView.isHidden = true
            collectionview.isHidden = true
            headerHeightConst.constant = 0
            collectionViewHeight.constant = 0
            blogTablHeight.constant = (3) * (122)
            
            blogTabl.reloadData()
        }
        else if blogSegment.selectedSegmentIndex == 1
        {
            blogTabl.tag = 1
            
            HeaderView.isHidden = false
            collectionview.isHidden = false
            headerHeightConst.constant = 144
            collectionViewHeight.constant = 50
            blogTablHeight.constant = CGFloat((arrChildCategory.count) * (122))
            
            
            blogTabl.reloadData()
        }
    }
    
    
    
    //  MARK: searchbar Delegates and Datasource:
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchResults.count != 0 {
            self.searchResults.removeAllObjects()
            blogTabl.tag = 1
            blogTablHeight.constant = CGFloat((arrChildCategory.count) * (122))
        }
        for i in 0..<arrChildCategory.count {
            // [searchResults removeAllObjects];
            //            let string: String = (self.arrChildCategory.object(at: i) as! NSDictionary).value(forKey: "first_name") as! String
            let string: String = (arrChildCategory[i] as? String)!
            let rangeValue: NSRange = (string as NSString).range(of: searchText, options: .caseInsensitive)
            if rangeValue.length > 0
            {
                blogTabl.tag = 2
                searchResults.add(arrChildCategory[i])
                
                 blogTablHeight.constant = CGFloat((searchResults.count) * (122))
            }
            else
            {
                
            }
        }
        blogTabl.reloadData()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
    {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        theSearchBar?.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    

    
    //MARK: TableView Delegates and Datasource:
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 122
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.tag == 1
        {
            return arrChildCategory.count
        }
        else if tableView.tag == 2
        {
            return searchResults.count
        }
        else
        {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView.tag == 1
        {
            let identifier = "blogcell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell
            
            if cell == nil
            {
                tableView.register(UINib(nibName: "blogcell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            blogTabl.separatorStyle = .none
            blogTabl.separatorColor = UIColor.clear
            
            if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4
            {
                cell.blogImage.image = UIImage(named: "blogimage")
                cell.blogSpecify.text = (arrChildCategory[indexPath.row] as? String)!
            }
            else
            {
                cell.blogImage.image = UIImage(named: "blogimage2")
                cell.blogSpecify.text = (arrChildCategory[indexPath.row] as? String)!
            }
            
            return cell
            
        }
        else if tableView.tag == 2
        {
            let identifier = "blogcell"
            cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell
            
            if cell2 == nil
            {
                tableView.register(UINib(nibName: "blogcell", bundle: nil), forCellReuseIdentifier: identifier)
                cell2 = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell
            }
            
            cell2.selectionStyle = UITableViewCellSelectionStyle.none
            blogTabl.separatorStyle = .none
            blogTabl.separatorColor = UIColor.clear
            
            if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4
            {
                let VolunteerID: String = (searchResults[indexPath.row] as? String)!
                if VolunteerID == "HairFall"
                {
                     cell2.blogImage.image = UIImage(named: "blogimage2")
                }
                else
                {
                     cell2.blogImage.image = UIImage(named: "blogimage")
                }
                cell2.blogSpecify.text = (searchResults[indexPath.row] as? String)!
            }
            else
            {
                let VolunteerID: String = (searchResults[indexPath.row] as? String)!
                if VolunteerID == "HairFall"
                {
                    cell2.blogImage.image = UIImage(named: "blogimage2")
                }
                else
                {
                    cell2.blogImage.image = UIImage(named: "blogimage")
                }
                cell2.blogSpecify.text = (searchResults[indexPath.row] as? String)!
            }
            return cell2
        }
        else
        {
            let identifier = "blogcell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell
            
            if cell == nil
            {
                tableView.register(UINib(nibName: "blogcell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? blogcell
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            blogTabl.separatorStyle = .none
            blogTabl.separatorColor = UIColor.clear
            
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
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "BlogDetailViewController") as? BlogDetailViewController
        myVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    // MARK:  Collection View Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return blogTypeArray.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cellColl = collectionView.dequeueReusableCell(withReuseIdentifier: "blogTypescell", for: indexPath) as! blogTypescell
        
        cellColl.typeNameCell.text = blogTypeArray[indexPath.row] as? String
        
        return cellColl
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "SpecificHealthTopicViewController") as? SpecificHealthTopicViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//       return CGSize(width: 120, height: 40)
//    }
//    
   

    @IBAction func BackButtClicked(_ sender: Any)
    {
        
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
