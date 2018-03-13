//
//  WaitingListViewController.swift
//  RestaurentSample
//
//  Created by admin on 10/03/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

class WaitingListViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var totalCount:UILabel?
    @IBOutlet weak var occupiedCount:UILabel?
    @IBOutlet weak var inqueueCount:UILabel?
    @IBOutlet weak var AddButton:UIBarButtonItem?
    
   var delegate = UIApplication.shared.delegate as! AppDelegate
    var dataArr:[Queue]? = [Queue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalCount?.text = "4"
        if RestaurentManager.User.sharedInstance?.userType != RestaurentManager.UserType.receptionist{
             AddButton?.title = RestaurentManager.Constant.emptyString
        }
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    
    
    func loadData(){
        
        self.tableView?.reloadData()
        
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

    
    @IBAction func addAction(sender:Any){
        
        let button = sender as! UIBarButtonItem
        if button.title != RestaurentManager.Constant.emptyString{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddDataViewController") as! AddDataViewController
        present(viewController, animated: true, completion: nil)
        }
        
    }
    @IBAction func logoutAction(sender:Any){
        
        
        dismiss(animated: true, completion: nil)
        
       RestaurentManager.User.sharedInstance?.destroy()
        
    }
    
    
}

extension WaitingListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            
            
            return (RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: false))?.count)!
           
            
        }
        return (RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: true))?.count)!
        

      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0{
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
           
            let data = RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: false))
            RestaurentManager.DataManager().delete(data![indexPath.row] as! Queue)
            self.tableView?.reloadData()
           
        }
        return [delete]
        }else{
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
                
                let data = RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: true))
                RestaurentManager.DataManager().delete(data![indexPath.row] as! Queue)
                self.tableView?.reloadData()
            }
            let allocate = UITableViewRowAction(style: .normal, title: "Allocate") { (action, indexpath) in
                
                let data = RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: true))
                if RestaurentManager.DataManager().modify(data![indexPath.row] as! Queue){
                    self.tableView?.reloadData()
                }
                
            }
            
            
            return [delete,allocate]
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WaitingListCell
        if indexPath.section == 0{
          let data = RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: false)) as! [Queue]
          cell.name?.text = data[indexPath.row].name
          cell.phoneNumber?.text = data[indexPath.row].phoneNumber
          cell.numberOfpeople?.text = data[indexPath.row].numberOfPerson
          cell.count?.text = data[indexPath.row].count
          occupiedCount?.text = data.count.description
            view.layoutIfNeeded()
        }else{
            let data = RestaurentManager.DataManager().fetch(RestaurentManager.Constant.queueOrNot, NSNumber(booleanLiteral: true)) as! [Queue]
            cell.name?.text = data[indexPath.row].name
            cell.phoneNumber?.text = data[indexPath.row].phoneNumber
            cell.numberOfpeople?.text = data[indexPath.row].numberOfPerson
            cell.count?.text = data[indexPath.row].count
            inqueueCount?.text = data.count.description
            view.layoutIfNeeded()
            
        }
        
       
        
        return cell
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Allocated"
        }
        return "Queue"
    }
    
    
    
    
    
    
}
