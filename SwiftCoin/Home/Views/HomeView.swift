//
//  HomeView.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 09/12/23.
//

import UIKit

class HomeView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    //MARK: - Top Header Collection Horizontal
    lazy var titleLabel: UILabel = {
        Factory.buildLabel(text: "Top Principais Impulsionadores", font: .systemFont(ofSize: 14, weight: .bold))
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    //MARK: - Divider
    lazy var divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .lightGray.withAlphaComponent(0.25)
        return divider
    }()
    
    //MARK: - List TableView Vertical
    lazy var allCoinsLabel: UILabel = {
        Factory.buildLabel(text: "Todas as Moedas", font: .systemFont(ofSize: 16, weight: .bold))
    }()
    
    lazy var coinLabel: UILabel = {
        Factory.buildLabel(text: "Moeda", textColor: .secondaryLabel, font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    lazy var priceLabel: UILabel = {
        Factory.buildLabel(text: "Preço", textColor: .secondaryLabel, font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup View
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews(views: [activityIndicator, titleLabel, collectionView, divider, allCoinsLabel, coinLabel, priceLabel, tableView])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
//            collectionView.widthAnchor.constraint(equalToConstant: 140),
            collectionView.heightAnchor.constraint(equalToConstant: 170),
            
            divider.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            allCoinsLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            allCoinsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            allCoinsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            coinLabel.topAnchor.constraint(equalTo: allCoinsLabel.bottomAnchor, constant: 20),
            coinLabel.leadingAnchor.constraint(equalTo: allCoinsLabel.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: allCoinsLabel.bottomAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: allCoinsLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: coinLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
