//
//  NewsViewModel.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 21.11.2025.
//

import Foundation

class NewsViewModel {
	
	private let networkManager: NetworkManager
	private let coreDataManager: CoreDataManager
	
	var news: [News] = []
	var onUpdate: (() -> Void)?
	var onError: ((String) -> Void)?
	
	init(networkManager: NetworkManager = .shared, coreDataManager: CoreDataManager = .shared) {
		self.networkManager = networkManager
		self.coreDataManager = coreDataManager
	}
	
	func fetchNews() {
		networkManager.fetchNews(from: networkManager.link) { [weak self] result in
			switch result {
			case .success(let news):
				self?.news = news
				self?.coreDataManager.saveNews(newsArray: news)
				self?.onUpdate?()
				
			case .failure(let error):
				let errorMessage = self?.warningMessage(error: error) ?? "Unknown error"
				self?.news = self?.coreDataManager.fetchNews() ?? []
				self?.onUpdate?()
				self?.onError?(errorMessage)
			}
		}
	}
	
	func numberOfItems() -> Int {
		return news.count
	}
	
	func newsAtIndex(_ index: Int) -> News {
		return news[index]
	}
	
	func warningMessage(error: NetworkError) -> String {
		switch error {
		case .someError:
			return "Ошибка загрузки данных. Данные будут загружены локально."
		}
	}
}
