//
//  Extensions.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 10/12/23.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach({ addSubview($0.self) })
    }
}

//MARK: - Configura design da célula da CollectionView
func configCellForCollection(cell: UIView) {
    cell.layer.cornerRadius = 20
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.lightGray.cgColor
    cell.layer.shadowColor = UIColor.black.cgColor
    cell.layer.shadowOffset = CGSize(width: 5, height: 5)
    cell.layer.shadowOpacity = 0.25
    cell.layer.shadowRadius = 5
    cell.backgroundColor = .systemBackground
}

//MARK: - Formatar valores da moeda
func formatarMoeda(_ numero: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2

    if let valorFormatado = formatter.string(from: NSNumber(value: numero)) {
        return "R$\(valorFormatado)"
    } else {
        return "Erro ao formatar o valor."
    }
}
