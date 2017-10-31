//
//  HealthTopicViewController.swift
//  HealthGuruPro
//
//  Created by think360 on 19/09/17.
//  Copyright © 2017 bharat. All rights reserved.
//

import UIKit

class healthTopicCell: UITableViewCell
{
    @IBOutlet weak var TestNameLab: UILabel!
    @IBOutlet weak var CellClikbutt: UIButton!
}

class HealthTopicViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var NotificationCount: UILabel!
    @IBOutlet weak var AdviceTestTabl: UITableView!
    
    var cell:healthTopicCell!
    
    //  var ItemlistArray = NSMutableArray()
    var ItemlistArray : NSMutableArray = ["Healthy Eating","Fitness","Mind-Body","Beauty","Weight Loss","Recipes"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdviceTestTabl.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func NotificationButtClick(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    
    
    //MARK: TableView Delegates and Datasource:
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 61
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ItemlistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "healthTopicCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? healthTopicCell
        
        if cell == nil
        {
            tableView.register(UINib(nibName: "healthTopicCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? healthTopicCell
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        AdviceTestTabl.separatorStyle = .none
        AdviceTestTabl.separatorColor = UIColor.clear
        
        cell.TestNameLab.text = ItemlistArray[indexPath.row] as? String
        
        cell.CellClikbutt.addTarget(self, action: #selector(HealthTopicViewController.multipleParamSelector), for: .touchUpInside)

        
    
        return cell
    }
    
    func multipleParamSelector(_ sender: AnyObject)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "SpecificHealthTopicViewController") as? SpecificHealthTopicViewController
        self.navigationController?.pushViewController(myVC!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }

    
    
    @IBAction func BackButtClick(_ sender: Any)
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
