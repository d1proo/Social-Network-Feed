//
//  News.swift
//  Social Network Feed
//
//  Created by Дмитрий Прохоренко on 14.11.2025.
//

struct News: Decodable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}
