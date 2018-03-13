//
//  AddDataViewController.swift
//  RestaurentSample
//
//  Created by admin on 10/03/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class AddDataViewController: UIViewController {

    
    @IBOutlet weak var name:UITextField?
    @IBOutlet weak var phoneNumber:UITextField?
    @IBOutlet weak var numberOfPeople:UITextField?
    @IBOutlet weak var count:UITextField?
    @IBOutlet weak var isqueue:UITextField?
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addAction(sender:Any){
    
        
//        let context = delegate.persistentContainer.viewContext
//
//        let queue = Queue(context: context)
//        queue.name = name?.text
//        queue.phoneNumber = phoneNumber?.text
//        queue.numberOfPerson = numberOfPeople?.text
//        queue.count = count?.text
//        if let queueOrNot = isqueue?.text{
//            if queueOrNot == "true"{
//        queue.queueOrNot = true
//            }else{
//                queue.queueOrNot = false
//            }
//        }
        
        var dict = [String:Any]()
        dict[RestaurentManager.DefaultsKeys.name.rawValue] = name?.text
        dict[RestaurentManager.DefaultsKeys.phoneNumber.rawValue] = phoneNumber?.text
        dict[RestaurentManager.DefaultsKeys.numberOfPerson.rawValue] = numberOfPeople?.text
        dict[RestaurentManager.DefaultsKeys.count.rawValue] = count?.text
        if let queueOrNot = isqueue?.text{
            if queueOrNot == "true"{
                dict[RestaurentManager.DefaultsKeys.queueOrNot.rawValue] = true
            }else{
               dict[RestaurentManager.DefaultsKeys.queueOrNot.rawValue]  = false
            }
        }
        
        
        
        
        
       // delegate.saveContext()
        if RestaurentManager.DataManager().add(strData: dict){
        dismiss(animated: true, completion: nil)
        }else{
            print("Error while inserting data!!")
        }
        
    
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
