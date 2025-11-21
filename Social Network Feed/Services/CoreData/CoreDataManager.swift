//
//  CoreDataManager.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 18.11.2025.
//

import CoreData

class CoreDataManager {
	static let shared = CoreDataManager()
	
	let persistentContainer: NSPersistentContainer
	let context: NSManagedObjectContext
	
	private init() {
		persistentContainer = NSPersistentContainer(name: "Social_Network_Feed")
		persistentContainer.loadPersistentStores { description, error in
			if let error = error {
				fatalError("Unable to load persistent stores: \(error)")
			}
		}
		context = persistentContainer.viewContext
	}
	
	func saveNews(newsArray: [News]) {
		let context = CoreDataManager.shared.context
		
		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NewsItem.fetchRequest()
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try context.execute(deleteRequest)
			
			for news in newsArray {
				let newsItem = NewsItem(context: context)
				newsItem.userId = Int16(news.userId)
				newsItem.id = Int16(news.id)
				newsItem.title = news.title
				newsItem.body = news.body
			}
			try context.save()
		} catch {
			print("Error saving news to CoreData: \(error)")
		}
	}

	func fetchNews() -> [News] {
		let newsItems = try? CoreDataManager.shared.context.fetch(NewsItem.fetchRequest())
		guard let fetchedNewsItems = newsItems else { return [] }
		
		let sortedNewsItems = fetchedNewsItems.sorted { $0.id < $1.id }
		
		return sortedNewsItems.map { newsItem in
			News(
				userId: Int(newsItem.userId),
				id: Int(newsItem.id),
				title: newsItem.title ?? "",
				body: newsItem.body ?? ""
			)
		}
	}
}
