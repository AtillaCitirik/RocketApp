//
//  RocketListCollectionViewManager.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 15.01.2025.
//

import UIKit

protocol RocketListCollectionViewManagerDelegate: AnyObject {
    func didSelectRocket(with viewModel: RocketDetailsViewModel)
    func showAlert(title: String, message: String)
}

class RocketListCollectionViewManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Var
    var viewModel = RocketListViewModel()
    weak var delegate: RocketListCollectionViewManagerDelegate?

    //MARK: - Lifecycle
    init(viewModel: RocketListViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - CollectionView func
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getRocketCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketListCollectionViewCell.identifier, for: indexPath) as! RocketListCollectionViewCell
        
        let rocket = viewModel.getRocket(at: indexPath.row)
        
        cell.data = rocket
        cell.actionAddToBasketButton = {
            NotificationCenter.default.post(
                name: .addToBasket,
                object: nil,
                userInfo: ["id": rocket?.rocket?.rocket_id, "name": rocket?.rocket?.rocket_name, "price": rocket?.price ?? 123321.2, "quantity": 1]
            )
            
            self.delegate?.showAlert(title: "Succes", message: "Rocket added to basket!")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rocketDetailViewModel = viewModel.getRocketDetailViewModel(at: indexPath.row) {
            delegate?.didSelectRocket(with: rocketDetailViewModel)
        }
    }
}

extension RocketListCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 24, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
