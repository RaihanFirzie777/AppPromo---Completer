//
//  ViewController.swift
//  AppPromo
//
//  Created by admin on 6/17/24.
//

import UIKit

class PromoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var promos: [Promo] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchPromos()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PromoCell")
    }

    func fetchPromos() {
        NetworkManager.shared.fetchPromos { [weak self] promos, error in
            guard let self = self else { return }
            if let promos = promos {
                self.promos = promos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let error = error {
                print("Error fetching promos: \(error)")
            }
        }
    }

    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCell", for: indexPath)
        let promo = promos[indexPath.row]
        cell.textLabel?.text = promo.name
        return cell
    }

    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promo = promos[indexPath.row]
        performSegue(withIdentifier: "showPromoDetail", sender: promo)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPromoDetail" {
            if let detailVC = segue.destination as? PromoDetailViewController {
                detailVC.promo = sender as? Promo
            }
        }
    }
}





