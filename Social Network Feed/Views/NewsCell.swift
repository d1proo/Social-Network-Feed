//
//  NewsCell.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 21.11.2025.
//

import UIKit

class NewsCell: UICollectionViewCell {
	
	lazy var newsTitle: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.font = .systemFont(ofSize: 16, weight: .bold)
		label.textColor = .black
		label.numberOfLines = 2
		return label
	}()
	
	lazy var newsBody: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.font = .systemFont(ofSize: 12, weight: .regular)
		label.textColor = .black
		label.numberOfLines = 3
		return label
	}()
	
	lazy var userLogo: UIImageView = {
		let imageView = UIImageView()
		imageView.image = LogoProvider.randomSystemLogo()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 40
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with news: News) {
		newsTitle.text = news.title
		newsBody.text = news.body
	}
	
	private func setupUI() {
		self.layer.borderColor = UIColor.lightGray.cgColor
		self.backgroundColor = .white
		self.layer.borderWidth = 1.0
		self.layer.cornerRadius = 12
		
		contentView.addSubview(userLogo)
		contentView.addSubview(newsTitle)
		contentView.addSubview(newsBody)
		
		userLogo.translatesAutoresizingMaskIntoConstraints = false
		newsTitle.translatesAutoresizingMaskIntoConstraints = false
		newsBody.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			userLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			userLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			userLogo.widthAnchor.constraint(equalToConstant: 80),
			userLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			newsTitle.leadingAnchor.constraint(equalTo: userLogo.trailingAnchor, constant: 8),
			newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			newsBody.leadingAnchor.constraint(equalTo: userLogo.trailingAnchor, constant: 8),
			newsBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			newsBody.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			newsBody.topAnchor.constraint(greaterThanOrEqualTo: newsTitle.bottomAnchor, constant: 8)
		])
	}
}
