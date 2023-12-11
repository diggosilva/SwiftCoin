//
//  CollectionCell.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 09/12/23.
//

import UIKit
import SDWebImage

class CollectionCell: UICollectionViewCell {
    
    static let identifier = "CollectionCellView"

    //MARK: - Image
    lazy var coinImage: UIImageView = {
        Factory.buildImage(image: UIImage(systemName: "bitcoinsign.circle.fill"))
    }()
    
    //MARK: - Coin Info
    lazy var coinSymbol: UILabel = {
        Factory.buildLabel(text: "BTC", font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    lazy var coinCurrentPrice: UILabel = {
        Factory.buildLabel(text: "R$216.754,76", textColor: .secondaryLabel, font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    //MARK: - Coin Percent Change
    lazy var coinPercentChange: UILabel = {
        Factory.buildLabel(text: "+5.60%", textColor: .systemGreen, font: .systemFont(ofSize: 18, weight: .bold))
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Coin) {
        guard let url = URL(string: model.image) else { return }
        DispatchQueue.main.async {
            self.coinImage.sd_setImage(with: url)
            self.coinSymbol.text = model.symbol.uppercased()
            self.coinCurrentPrice.text = formatarMoeda(model.currentPrice)
            self.coinPercentChange.text = "\(String(format: "%.2f", model.priceChangePercentage24H))%"
            self.coinPercentChange.textColor = model.priceChangePercentage24H > 0 ? .systemGreen : .systemRed
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews(views: [coinImage, coinSymbol, coinCurrentPrice, coinPercentChange])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            coinImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            coinImage.widthAnchor.constraint(equalToConstant: 32),
            coinImage.heightAnchor.constraint(equalToConstant: 32),
            
            coinSymbol.topAnchor.constraint(equalTo: coinImage.bottomAnchor,constant: 20),
            coinSymbol.leadingAnchor.constraint(equalTo: coinImage.leadingAnchor),
            
            coinCurrentPrice.centerYAnchor.constraint(equalTo: coinSymbol.centerYAnchor),
            coinCurrentPrice.leadingAnchor.constraint(equalTo: coinSymbol.trailingAnchor, constant: 5),
            coinCurrentPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            coinPercentChange.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor),
            coinPercentChange.leadingAnchor.constraint(equalTo: coinImage.leadingAnchor),
            coinPercentChange.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
