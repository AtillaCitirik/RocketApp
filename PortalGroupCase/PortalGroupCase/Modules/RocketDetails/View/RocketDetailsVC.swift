//
//  RocketDetailsVC.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 14.01.2025.
//

import UIKit

class RocketDetailsVC: UIViewController {

    //MARK: - UI Elements
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketDetailLabel: UILabel!
    @IBOutlet weak var rocketLaunchYearLabel: UILabel!
    @IBOutlet weak var rocketPriceLabel: UILabel!
    @IBOutlet weak var addToBasketButton: UIButton!
    
    //MARK: - Var
    var viewModel: RocketDetailsViewModel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        rocketNameLabel.text = viewModel.rocketName
        rocketLaunchYearLabel.text = viewModel.launchYear
        rocketImageView.loadImage(from: viewModel.missionImageURL)
        rocketDetailLabel.text = viewModel.missionDescription
        rocketPriceLabel.text = "\(viewModel.price)₺"
    }
    
    //MARK: - Func
    @IBAction func tappedAddtoBasketButton(_ sender: Any) {
        viewModel.addToBasket()
        let alert = UIAlertController(title: "Succes", message: "Rocket added to basket", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
