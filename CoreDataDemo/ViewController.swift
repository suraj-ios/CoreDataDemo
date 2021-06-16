//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by IDEAQU on 16/06/21.
//  Copyright © 2021 IDEAQU. All rights reserved.
//

import UIKit
import  CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createData(_ sender: Any) {
        createData()
    }
    
    @IBAction func retrieveData(_ sender: Any) {
        retrieveData()
    }
    
    @IBAction func updateData(_ sender: Any) {
        updateData()
    }
    
    @IBAction func deleteData(_ sender: Any) {
        deleteData()
    }
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "UserRecord", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        for i in 1...5 {
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(i, forKeyPath: "userID")
            user.setValue(Int16("000\(i)"), forKeyPath: "rollNumber")
            user.setValue("Name\(i)", forKeyPath: "name")
            user.setValue("suraj\(i)@test.com", forKey: "email")
            user.setValue(i, forKey: "mobileNumber")
        }
        
        do{
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserRecord")

        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "userID") as! Int)
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    func updateData(){
        //As we know that container is set up in the AppDelegates so we need to refer that container.
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
             
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserRecord")
             fetchRequest.predicate = NSPredicate(format: "name = %@", "Suraj1")
             do
             {
                 let test = try managedContext.fetch(fetchRequest)
        
                     let objectUpdate = test[0] as! NSManagedObject
                     objectUpdate.setValue("newName", forKey: "name")
                     objectUpdate.setValue("newmail", forKey: "email")
                     do{
                         try managedContext.save()
                     }
                     catch
                     {
                         print(error)
                     }
                 }
             catch
             {
                 print(error)
             }
    }
    
    func deleteData(){
        //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserRecord")
         fetchRequest.predicate = NSPredicate(format: "name = %@", "Suraj3")
        
         do
         {
             let test = try managedContext.fetch(fetchRequest)
             
             let objectToDelete = test[0] as! NSManagedObject
             managedContext.delete(objectToDelete)
             
             do{
                 try managedContext.save()
             }
             catch
             {
                 print(error)
             }
             
         }
         catch
         {
             print(error)
         }
    }
    
}

