//
//  CoreDataManager.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 18.01.2025.
//

import UIKit
import CoreData

class CoreDataManager {
    //MARK: - Singleton
    static let shared = CoreDataManager()
    
    //MARK: Var
    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - Lifecycle
    private init() {}
    
    //MARK: - Func
    func fetchBaketItems() -> [BasketRocket] {
        let fetchRequest: NSFetchRequest<BasketItemEntity> = BasketItemEntity.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.map { basketItem in
                BasketRocket(id: basketItem.id ?? "",
                             name: basketItem.name ?? "",
                             price: basketItem.price,
                             quantity: Int(basketItem.quantity))
            }
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }
    
    func addToBasket(rocket: BasketRocket) {
        let fetchRequest: NSFetchRequest<BasketItemEntity> = BasketItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", rocket.id)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if let exitingItem = result.first {
                exitingItem.quantity += 1
            } else {
                let newItem = BasketItemEntity(context: context)
                newItem.id = rocket.id
                newItem.name = rocket.name
                newItem.price = rocket.price
                newItem.quantity = 1
            }
            try context.save()
            NotificationCenter.default.post(name: .changedBasketCount, object: nil)
        } catch {
            print("Core Data processing error: \(error)")
        }
    }
    
    func updateQuantity(for id: String, by amount: Int) {
        let fetchRequest: NSFetchRequest<BasketItemEntity> = BasketItemEntity.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "id == %@", id)

         do {
             let results = try context.fetch(fetchRequest)
             
             if let existingItem = results.first {
                 let newQuantity = Int(existingItem.quantity) + amount
                 
                 if newQuantity <= 0 {
                     context.delete(existingItem)
                 } else {
                     existingItem.quantity = Int16(newQuantity)
                 }
                 
                 try context.save()
                 NotificationCenter.default.post(name: .changedBasketCount, object: nil)
             }
         } catch {
             print("Core Data quantity update error: \(error)")
         }
     }
    
    func deleteBasketItem(id: String) {
        let fetchRequest: NSFetchRequest<BasketItemEntity> = BasketItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let itemToDelete = result.first {
                context.delete(itemToDelete)
                try context.save()
                NotificationCenter.default.post(name: .changedBasketCount, object: nil)
            }
        } catch {
            print("Core Data deletion error: \(error)")
        }
    }
    
    func clearBasket() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = BasketItemEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            NotificationCenter.default.post(name: .changedBasketCount, object: nil)
        } catch {
            print("Core Data deletion error(All): \(error)")
        }
    }
    
    func fetchTotalBasketQuantity() -> Int {
        let fetchRequest: NSFetchRequest<BasketItemEntity> = BasketItemEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.reduce(0) { $0 + Int($1.quantity) }
        } catch {
            print("Core Data'dan toplam miktar alınırken hata oluştu: \(error)")
            return 0
        }
    }
    
}
