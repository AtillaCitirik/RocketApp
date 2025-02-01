//
//  BasketVC.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 14.01.2025.
//

import UIKit

class BasketVC: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!

    // MARK: - VAR
    private let viewModel = BasketViewModel()
    var basketTableViewManager: BasketTableViewManager!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBasketTableView()

        viewModel.onBasketItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.updateTotalPrice()
            }
        }
        viewModel.fetchBasketItems()
    }

    // MARK: - Setup
    func setupBasketTableView() {
        basketTableViewManager = BasketTableViewManager(viewModel: viewModel)
        tableView.delegate = basketTableViewManager
        tableView.dataSource = basketTableViewManager
        tableView.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: BasketTableViewCell.identifier)
    }

    // MARK: - Func
    private func updateTotalPrice() {
        let totalPrice = viewModel.calculateTotalPrice()
        priceLabel.text = String(format: "%.2f₺", totalPrice)
    }

    @IBAction func tappedCompleteButton(_ sender: Any) {
        viewModel.deleteAllBasketItems()
        showAlert(message: "Shopping complete. Basket cleared.")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
