//
//  RocketListViewModel.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 15.01.2025.
//

import UIKit

class RocketListViewModel {
    
    //MARK: - Var
    var rocketList: [Rocket] = []
    var reloadData: () -> () = {}
    
    var getRocketCount: Int {
        return rocketList.count
    }
    
    //MARK: - Func
    func getRocket(at index: Int) -> Rocket? {
        return rocketList[index]
    }
    
    func fetchData(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v2/launches") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }

            do {
                let decodedData = try JSONDecoder().decode([Rocket].self, from: data)
                self.rocketList = decodedData
                print(decodedData)
                completion()
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    
    func getRocketDetailViewModel(at index: Int) -> RocketDetailsViewModel? {
        guard let rocket = getRocket(at: index) else { return nil }
        return RocketDetailsViewModel(rocket: rocket)
    }
    
}
