//
//  AppManager.swift
//  RestaurentSample
//
//  Created by Abhishek K on 12/03/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RestaurentManager{
    
    struct Constant {
        static let  password:String = "1234"
        static let emptyString = ""
        static let queueOrNot = "queueOrNot"
        static let name = "name"
        
    }
    
    enum UserType:String{
        case receptionist
        case customer
    }
    
    enum DefaultsKeys:String{
        case username
        case password
        case userType
        case name
        case phoneNumber
        case numberOfPerson
        case queueOrNot
        case count
    }
    
    class DataManager{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let defaults = UserDefaults.standard
        var managedObjectContext:NSManagedObjectContext{
            return delegate.persistentContainer.viewContext
        }
        func fetch(_ argument:String?,_ parameter:Any?) -> [NSManagedObject]?{
            let fetchRequest = NSFetchRequest<Queue>(entityName: "Queue")
            if let argument = argument, let parameter = parameter{
                fetchRequest.predicate = NSPredicate(format: "%K == %@",argument , parameter as! CVarArg)
            }
            do{
            let fetchResults = try managedObjectContext.fetch(fetchRequest)
            return fetchResults
            }catch{
                print("Error while fetching data!!!")
            }
            return nil
        }
        
        func delete(_ object:Queue){
            
            let fetchResult = self.fetch(RestaurentManager.Constant.name, object.name)
            managedObjectContext.delete((fetchResult?.first)!)
            do{
            try managedObjectContext.save()
            }catch{
                print("Error while deleting data!!!")
            }
        }
        func modify(_ object:Queue) -> Bool{
            
            let fetchResult = self.fetch(RestaurentManager.Constant.name, object.name) as! [Queue]
            fetchResult.first?.queueOrNot = false
            do{
            try managedObjectContext.save()
            return true
            }catch{
                print("Error while modifying!!!")
                return false
            }          
            
        }
        
        func add(strData:Dictionary<String, Any>) -> Bool{
            
            let queue = Queue(context: managedObjectContext)
            queue.name = strData[RestaurentManager.DefaultsKeys.name.rawValue] as? String
            queue.phoneNumber = strData[RestaurentManager.DefaultsKeys.phoneNumber.rawValue] as? String
            queue.numberOfPerson = strData[RestaurentManager.DefaultsKeys.numberOfPerson.rawValue] as? String
            queue.queueOrNot = strData[RestaurentManager.DefaultsKeys.queueOrNot.rawValue] as! Bool
            queue.count = strData[RestaurentManager.DefaultsKeys.count.rawValue] as? String
            
            delegate.saveContext()
            
            return true
        }
        
        func isUserLoggedIn() -> Bool{
            if let username = defaults.object(forKey: DefaultsKeys.username.rawValue) , let password = defaults.object(forKey: DefaultsKeys.password.rawValue), let userType = defaults.object(forKey: DefaultsKeys.userType.rawValue){
                return true
            }
            return false
            
        }
        
        
    }
    
    final class User{
      var username:String?
      var password:String?
      var userType:UserType?
      let defaults = UserDefaults.standard
      static var sharedInstance:User?{
        get{
        let instance = User()
        return instance
        }
        set(newValue){
            sharedInstance?.username = nil
            sharedInstance?.password = nil
            sharedInstance?.userType = nil
         
        }
      }
      private init(){
        username = defaults.object(forKey: DefaultsKeys.username.rawValue) as? String
        password = defaults.object(forKey: DefaultsKeys.password.rawValue) as? String
        userType = RestaurentManager.UserType(rawValue: (defaults.object(forKey: DefaultsKeys.userType.rawValue) as? String)!)!
      }
       
      func destroy(){
        User.sharedInstance = nil
        defaults.removeObject(forKey: DefaultsKeys.username.rawValue)
        defaults.removeObject(forKey: DefaultsKeys.password.rawValue)
        defaults.removeObject(forKey: DefaultsKeys.userType.rawValue)
        defaults.synchronize()
        }
        
       
        
        
        
        
        
    }
}
    
    
    




