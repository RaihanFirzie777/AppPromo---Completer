//
//  PromoDetailViewController.swift
//  AppPromo
//
//  Created by admin on 6/17/24.
//

import UIKit

class PromoDetailViewController: UIViewController {
    var promo: Promo?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var promoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        guard let promo = promo else { return }

        titleLabel.text = promo.name
        descriptionLabel.text = promo.detail

        // Load image from URL
        if let url = URL(string: promo.imagesURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.promoImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}

