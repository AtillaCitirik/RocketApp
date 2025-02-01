//
//  BasketViewModel.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 17.01.2025.
//

import Foundation
import CoreData
import UIKit

class BasketViewModel {
    
    //MARK: - Var
    private(set) var basketItems: [BasketRocket] = []
    var onBasketItemsUpdated: (() -> Void)?
    
    //MARK: - Lifecycle
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAddToBasketNotification),
            name: .addToBasket,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Func
    func fetchBasketItems() {
        basketItems = CoreDataManager.shared.fetchBaketItems()
        print("Sepet Verileri:", basketItems)
        onBasketItemsUpdated?()
    }
    
    func addToBasket(rocket: BasketRocket) {
        CoreDataManager.shared.addToBasket(rocket: rocket)
        fetchBasketItems()
    }
    
    func updateQuantity(for id: String, by amount: Int) {
        CoreDataManager.shared.updateQuantity(for: id, by: amount)
        fetchBasketItems()
    }
    
    func calculateTotalPrice() -> Double {
        return basketItems.reduce(0) { total, item in
            total + (item.price * Double(item.quantity))
        }
    }
    
    func deleteBasketItem(with id: String) {
        CoreDataManager.shared.deleteBasketItem(id: id)
        fetchBasketItems()
    }
    
    func deleteAllBasketItems() {
        CoreDataManager.shared.clearBasket()
        fetchBasketItems()
    }
    
    func calculateTotalQuantity() -> Int {
        return basketItems.reduce(0) { total, item in
            total + item.quantity
        }
    }
    
    @objc func handleAddToBasketNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let id = userInfo["id"] as? String,
              let name = userInfo["name"] as? String,
              let price = userInfo["price"] as? Double,
              let quantity = userInfo["quantity"] as? Int else { return }

        let rocket = BasketRocket(id: id, name: name, price: price, quantity: quantity)
        if let existingItem = basketItems.first(where: { $0.id == id }) {
            updateQuantity(for: existingItem.id, by: quantity)
        } else {
            addToBasket(rocket: rocket)
        }
    }
}
