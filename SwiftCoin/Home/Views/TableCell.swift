//
//  TableCell.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 09/12/23.
//

import UIKit
import SDWebImage

class TableCell: UITableViewCell {
    
    static let identifier = "TableCellView"
    
    //MARK: - Coin Id
    lazy var coinMarketCapRank: UILabel = {
        Factory.buildLabel(text: "1", textColor: .secondaryLabel, textAlignment: .center, font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    //MARK: - Image
    lazy var coinImage: UIImageView = {
        Factory.buildImage(image: UIImage(systemName: "bitcoinsign.circle.fill"))
    }()
    
    //MARK: - Coin Info LEFT
    lazy var coinName: UILabel = {
        Factory.buildLabel(text: "Bitcoin", font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    lazy var coinSymbol: UILabel = {
        Factory.buildLabel(text: "BTC", textColor: .darkGray, font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    //MARK: - Coin Info RIGHT
    lazy var coinCurrentPrice: UILabel = {
        Factory.buildLabel(text: "$20.330,00", font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    lazy var coinPercentChange: UILabel = {
        Factory.buildLabel(text: "-5.60%", textColor: .systemRed, font: .systemFont(ofSize: 12, weight: .bold))
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Coin) {
        guard let url = URL(string: model.image) else { return }
        DispatchQueue.main.async {
            self.coinMarketCapRank.text = "\(model.marketCapRank)"
            self.coinImage.sd_setImage(with: url)
            self.coinName.text = model.name
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
        addSubviews(views: [coinMarketCapRank, coinImage, coinName, coinSymbol, coinCurrentPrice, coinPercentChange])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            coinMarketCapRank.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            coinMarketCapRank.centerYAnchor.constraint(equalTo: coinImage.centerYAnchor),
            coinMarketCapRank.widthAnchor.constraint(equalToConstant: 30),
            
            coinImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            coinImage.leadingAnchor.constraint(equalTo: coinMarketCapRank.trailingAnchor, constant: 0),
            coinImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            coinImage.widthAnchor.constraint(equalToConstant: 32),
            coinImage.heightAnchor.constraint(equalToConstant: 32),
            
            coinName.topAnchor.constraint(equalTo: coinImage.topAnchor),
            coinName.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 10),
            
            coinSymbol.leadingAnchor.constraint(equalTo: coinName.leadingAnchor),
            coinSymbol.bottomAnchor.constraint(equalTo: coinImage.bottomAnchor),
            
            coinCurrentPrice.topAnchor.constraint(equalTo: coinImage.topAnchor),
            coinCurrentPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            coinPercentChange.trailingAnchor.constraint(equalTo: coinCurrentPrice.trailingAnchor),
            coinPercentChange.bottomAnchor.constraint(equalTo: coinImage.bottomAnchor),
        ])
    }
}
