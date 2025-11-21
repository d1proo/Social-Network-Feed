//
//  ViewController.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 14.11.2025.
//

import UIKit

class ViewController: UIViewController {
	
	private let viewModel = NewsViewModel()
	private let activityIndicator = UIActivityIndicatorView(style: .large)
	private let refreshControl = UIRefreshControl()
	
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
		cv.contentInsetAdjustmentBehavior = .never
		cv.isHidden = true
		return cv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 0.99, green: 0.97, blue: 0.94, alpha: 1.0)
		setupActivityIndicator()
		setupCollectionView()
		setupViewModel()
		viewModel.fetchNews()
	}
	
	private func setupViewModel() {
		viewModel.onUpdate = { [weak self] in
			DispatchQueue.main.async {
				self?.activityIndicator.stopAnimating()
				self?.collectionView.isHidden = false
				self?.collectionView.reloadData()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
					self?.refreshControl.endRefreshing()
				}
			}
		}
		
		viewModel.onError = { [weak self] errorMessage in
			DispatchQueue.main.async {
				let alert = UIAlertController(title: "Ошибка!", message: errorMessage, preferredStyle: .alert)
				let okAction = UIAlertAction(title: "OK", style: .default)
				alert.addAction(okAction)
				self?.present(alert, animated: true)
			}
		}
	}
	
	private func setupActivityIndicator() {
		activityIndicator.color = .gray
		activityIndicator.hidesWhenStopped = true
		view.addSubview(activityIndicator)
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
	private func setupCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		view.addSubview(collectionView)
		
		refreshControl.tintColor = .gray
		refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
		collectionView.refreshControl = refreshControl
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	@objc private func refreshNews() {
		viewModel.fetchNews()
	}
}

extension ViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItems()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
		let newsItem = viewModel.newsAtIndex(indexPath.row)
		cell.configure(with: newsItem)
		return cell
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.frame.width - 32
		return CGSize(width: width, height: 100)
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 16
	}
}
