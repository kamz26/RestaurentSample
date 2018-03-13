//
//  ViewController.swift
//  RestaurentSample
//
//  Created by admin on 10/03/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var user:RestaurentManager.User? = nil
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        if RestaurentManager.DataManager().isUserLoggedIn(){
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WaitingListViewController") as! WaitingListViewController
            present(viewController, animated: false, completion: nil)
        }
    
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender:UIButton){
        if self.username.text == RestaurentManager.UserType.receptionist.rawValue{
            if password.text == RestaurentManager.Constant.password{
                defaults.set(username.text!, forKey: RestaurentManager.DefaultsKeys.username.rawValue)
                defaults.set(password.text!, forKey: RestaurentManager.DefaultsKeys.password.rawValue)
                defaults.set(RestaurentManager.UserType.receptionist.rawValue, forKey: RestaurentManager.DefaultsKeys.userType.rawValue)
                defaults.synchronize()
                user = RestaurentManager.User.sharedInstance
                
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WaitingListViewController") as! WaitingListViewController
                present(viewController, animated: false, completion: nil)
            }    
        }else{
            let queueUser = RestaurentManager.DataManager().fetch(RestaurentManager.Constant.name,username.text!)
            if let user = queueUser{
            if user.count > 0 && password.text! == RestaurentManager.Constant.password{
                defaults.set(username.text!, forKey: RestaurentManager.DefaultsKeys.username.rawValue)
                defaults.set(password.text!, forKey: RestaurentManager.DefaultsKeys.password.rawValue)
                defaults.set(RestaurentManager.UserType.customer.rawValue, forKey: RestaurentManager.DefaultsKeys.userType.rawValue)
                defaults.synchronize()
                self.user = RestaurentManager.User.sharedInstance
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WaitingListViewController") as! WaitingListViewController
                present(viewController, animated: false, completion: nil)
            }
            }
            
            
        }
        
    }
    
   
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

