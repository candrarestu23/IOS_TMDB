//
//  ParentListModel.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import Foundation

struct ListMovieModel: Codable {
  let voteCount: Int?
  let posterPath: String?
  let id: Int?
  let originalTitle: String?
  let title: String?
  let voteAvarage: Double?
  let overview: String?
  
  enum CodingKeys: String, CodingKey {
    case voteCount = "vote_count"
    case posterPath = "poster_path"
    case id = "id"
    case originalTitle = "original_title"
    case title = "title"
    case voteAvarage = "vote_average"
    case overview = "overview"

  }
}

struct ParentListModel: Codable {
  let page: Int?
  let totalPages: Int?
  let results: [ListMovieModel]?
  
  enum CodingKeys: String, CodingKey {
    case page = "page"
    case totalPages = "total_pages"
    case results = "results"
  }
}
