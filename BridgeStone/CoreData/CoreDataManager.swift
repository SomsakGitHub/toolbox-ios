//
//  CoreDataManager.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var UserCoreData: [User] = []
    var FavoriteFleetCoreData: [FavoriteFleet] = []
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "BridgeStone")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveUserData(accessToken: String, refreshToken: String) {
        
        deleteUserData(entityName: "User")
        let managedContext = self.persistentContainer.viewContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let recent = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        //3
        recent.setValue(accessToken, forKey: "accessToken")
        recent.setValue(refreshToken, forKey: "refreshToken")
        
        //4
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
//        do {
//            UserCoreData = try managedContext.fetch(User.fetchRequest())
//            for index in UserCoreData{
//                print("UserCoreData.accessToken \(String(describing: index.accessToken))")
//                print("UserCoreData.refreshToken \(String(describing: index.refreshToken))")
//            }
//        } catch let error as NSError  {
//            print("Could not save \(error), \(error.userInfo)")
//        }
    }
    
    func deleteUserData(entityName: String) {
        let managedContext = self.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        //3
        do{
            let results:[NSManagedObject] = (try managedContext.fetch(fetchRequest) as! [NSManagedObject])
            for i in results{
                managedContext.delete(i)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getUserData() -> [User] {
        let managedContext = self.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        //3
        do{
            let results:[User] = (try managedContext.fetch(fetchRequest) as! [User])
            return results
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return []
    }

//    func saveFavoriteFleetData(userData: UserManager) {
//            
////            deleteUserData(entityName: "FavoriteFleet")
//            let managedContext = self.persistentContainer.viewContext
//            
//            //2
//            let entity =  NSEntityDescription.entity(forEntityName: "FavoriteFleet", in: managedContext)
//            let recent = NSManagedObject(entity: entity!, insertInto: managedContext)
//            
//            //3
//            recent.setValue(userData.favoriteFleet, forKey: "name")
//            
//            //4
//            do {
//                try managedContext.save()
//            } catch let error as NSError  {
//                print("Could not save \(error), \(error.userInfo)")
//            }
//            
//            do {
//                FavoriteFleetCoreData = try managedContext.fetch(FavoriteFleet.fetchRequest())
//                for index in FavoriteFleetCoreData{
//                    print("FavoriteFleetCoreData.name \(String(describing: index.name))")
//                }
//            } catch let error as NSError  {
//                print("Could not save \(error), \(error.userInfo)")
//            }
//        }
    
    func fetchFavoriteFleet() -> [FavoriteFleet]{
        let managedContext = self.persistentContainer.viewContext
        var favoriteFleet : [FavoriteFleet] = []
        
        do {
            favoriteFleet = try managedContext.fetch(FavoriteFleet.fetchRequest())
        } catch  {
            print(error)
        }
        
        return favoriteFleet
    }
}
