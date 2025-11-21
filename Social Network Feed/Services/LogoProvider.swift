//
//  LogoProvider.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 17.11.2025.
//

import UIKit

class LogoProvider {
	static func randomSystemLogo() -> UIImage? {
		let symbols = ["person.circle.fill", "person.2.circle.fill", "person.3.fill",
					  "heart.circle.fill", "star.circle.fill", "bookmark.circle.fill",
					  "flag.circle.fill", "bell.circle.fill", "gear.circle.fill"]
		
		guard let randomSymbol = symbols.randomElement(),
			  var image = UIImage(systemName: randomSymbol) else {
			return nil
		}
		
		let randomColor = UIColor.random()
		image = image.withTintColor(randomColor, renderingMode: .alwaysOriginal)
		return image
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(
			red: .random(in: 0.3...0.9),
			green: .random(in: 0.3...0.9),
			blue: .random(in: 0.3...0.9),
			alpha: 1.0
		)
	}
}
