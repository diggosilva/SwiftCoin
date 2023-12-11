//
//  CoinViewController.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 09/12/23.
//

import UIKit

class CoinViewController: UIViewController {
    
    private let homeView = HomeView()
    private let service = Service.shared
    private let collectionCellView = CollectionCell()
    var coins: [Coin] = []
    var topMovingCoins: [Coin] = []
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setDelegatesAndDataSources()
        fetchData()
    }
    
    func fetchData() {
        service.fetchCoinData { coin in
            DispatchQueue.main.async {
                self.coins = coin
                self.configureTopMovingCoins()
                self.homeView.activityIndicator.stopAnimating()
                self.homeView.collectionView.reloadData()
                self.homeView.tableView.reloadData()
            }
        }
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        self.topMovingCoins = Array(topMovers.prefix(10))
        self.homeView.titleLabel.text = "Top \(topMovingCoins.count) Principais Impulsionadores"
    }
    
    func configNav() {
        title = "Preços Online"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    func setDelegatesAndDataSources() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
}

//MARK: - CollectionView
extension CoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topMovingCoins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        configCellForCollection(cell: cell)
        cell.configure(model: topMovingCoins[indexPath.item])
        return cell
    }
}

extension CoinViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}

//MARK: - TableView
extension CoinViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { return UITableViewCell() }
        cell.configure(model: coins[indexPath.row])
        return cell
    }
}
