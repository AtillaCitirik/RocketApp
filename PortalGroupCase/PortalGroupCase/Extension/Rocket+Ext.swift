//
//  Rocket+Ext.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 19.01.2025.
//

extension Rocket {
    func toBasketRocket(quantity: Int = 1) -> BasketRocket {
        return BasketRocket(
            id: self.rocket?.rocket_id ?? "",
            name: self.rocket?.rocket_name ?? "",
            price: self.price ?? 123321.3,
            quantity: quantity
        )
    }
}
