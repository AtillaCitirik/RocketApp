//
//  RocketDetailsViewModel.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 17.01.2025.
//

import UIKit

class RocketDetailsViewModel {
    
    //MARK: - Var
    private let rocket: Rocket
    
    var rocketName: String {
        return rocket.rocket?.rocket_name ?? "Unknown Mission"
    }

    var launchYear: String {
        return rocket.launch_year ?? "Unknown Year"
    }

    var missionImageURL: String {
        return rocket.links?.mission_patch ?? ""
    }
    
    var missionDescription: String {
        return rocket.details ?? "No description available"
    }
    
    var price: Double {
        return rocket.price ?? 123321.2
    }
    
    //MARK: - Lifecycle
    init(rocket: Rocket) {
        self.rocket = rocket
    }
    
    //MARK: - Func
    func addToBasket() {
        NotificationCenter.default.post(
            name: .addToBasket,
            object: nil,
            userInfo: ["id": rocket.rocket?.rocket_id, "name": rocket.rocket?.rocket_name, "price": rocket.price ?? 123321.2, "quantity": 1]
        )
        print("Rocket added to basket: \(rocket)")
    }
}
