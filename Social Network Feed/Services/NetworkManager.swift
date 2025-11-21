//
//  NetworkManager.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 15.11.2025.
//

import Alamofire
import Foundation

final class NetworkManager {
	
	private init() {}
	
	static let shared = NetworkManager()
	
	var link: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
	
	func fetchNews(from url: URL, completion: @escaping(Result<[News], NetworkError>) -> Void) {
		AF.request(url)
			.validate()
			.responseData { responseData in
				switch responseData.result {
				case .success(let correctData):
					let news = self.parseNews(correctData)
					completion(.success(news))
				case .failure:
					completion(.failure(.someError))
				}
			}
	}
	
	private func parseNews(_ data: Data) -> [News] {
		do {
			let news = try JSONDecoder().decode([News].self, from: data)
			return news
		} catch {
			print("Decoding error: \(error)")
			return []
		}
	}
}
