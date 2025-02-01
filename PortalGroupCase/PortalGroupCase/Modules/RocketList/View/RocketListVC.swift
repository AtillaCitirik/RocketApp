//
//  RocketListVC.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 13.01.2025.
//

import UIKit

class RocketListVC: UIViewController {

    //MARK: - UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Var
    let viewModel = RocketListViewModel()
    var collectionViewManager: RocketListCollectionViewManager!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        collectionViewManager = RocketListCollectionViewManager(viewModel: viewModel)
        collectionViewManager.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4 - 32, height: 200)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = collectionViewManager
        collectionView.dataSource = collectionViewManager
        collectionView.register(UINib(nibName: "RocketListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RocketListCollectionViewCell.identifier)
        fetchData()
    }
    
    //MARK: - Func
    private func fetchData() {
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension RocketListVC: RocketListCollectionViewManagerDelegate {
    func didSelectRocket(with viewModel: RocketDetailsViewModel) {
        let storyboard = UIStoryboard(name: "RocketDetails", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(identifier: "RocketDetailsVC") as? RocketDetailsVC {
            detailsVC.viewModel = viewModel
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
