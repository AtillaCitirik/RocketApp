//
//  BasketTableViewManager.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 17.01.2025.
//
//

import UIKit

class BasketTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Var
    private let viewModel: BasketViewModel

    //MARK: - Lifecycle
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }

    //MARK: - Func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as! BasketTableViewCell
        let rocket = viewModel.basketItems[indexPath.row]
        cell.configure(with: rocket)
        cell.minusButton.tag = indexPath.row
        cell.plusButton.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension BasketTableViewManager: BasketTableViewCellDelegate {
    func didTapPlusButton(at index: Int) {
        let rocket = viewModel.basketItems[index]
        viewModel.updateQuantity(for: rocket.id, by: 1)
    }

    func didTapMinusButton(at index: Int) {
        let rocket = viewModel.basketItems[index]
        viewModel.updateQuantity(for: rocket.id, by: -1)
    }
}
