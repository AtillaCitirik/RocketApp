//
//  RocketListCollectionViewCell.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 14.01.2025.
//

import UIKit

class RocketListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier: String = "RocketListCollectionViewCell"
    
    //MARK: - UI Elements
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var launchYearLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: - Var
    var data: Rocket? {
        didSet{
            if let name = data?.rocket?.rocket_name {
                rocketNameLabel.text = "\(name)"
            }
            if let launchYear = data?.launch_year {
                launchYearLabel.text = "\(launchYear)"
            }
            if let imageURL = data?.links?.mission_patch {
                DispatchQueue.main.async {
                    self.rocketImageView.loadImage(from: imageURL)
                }
            }
            priceLabel.text = "1234567₺"
        }
    }
    var actionAddToBasketButton: () -> () = {}
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    //MARK: - SetupUI
    private func setupUI() {
        layer.cornerRadius = 16
        addToBasketButton.layer.cornerRadius = 8
    }
    //MARK: - Func
    @IBAction func tappedAddToBasketButton(_ sender: Any) {
        actionAddToBasketButton()
    }
}
