//
//  BasketTableViewCell.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 14.01.2025.
//
//

protocol BasketTableViewCellDelegate: AnyObject {
    func didTapPlusButton(at index: Int)
    func didTapMinusButton(at index: Int)
}

import UIKit

class BasketTableViewCell: UITableViewCell {
    //MARK: - Identifier
    static let identifier = "BasketTableViewCell"

    //MARK: - UI Elements
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!

    //MARK: - Var
    weak var delegate: BasketTableViewCellDelegate?

    //MARK: - Configure
    func configure(with rocket: BasketRocket) {
        nameLabel.text = rocket.name
        priceLabel.text = "\(rocket.price)₺"
        countLabel.text = "\(rocket.quantity)"
    }

    //MARK: - Func
    @IBAction func tappedMinusButton(_ sender: UIButton) {
        delegate?.didTapMinusButton(at: sender.tag)
    }

    @IBAction func tappedPlusButton(_ sender: UIButton) {
        delegate?.didTapPlusButton(at: sender.tag)
    }
}
