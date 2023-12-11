//
//  Factory.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 10/12/23.
//

import UIKit

class Factory {
    
    static func buildLabel(text: String, textColor: UIColor = .label, textAlignment: NSTextAlignment = .left, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
        return label
    }
    
    static func buildImage(image: UIImage?) -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "bitcoinsign.circle.fill")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }
}
