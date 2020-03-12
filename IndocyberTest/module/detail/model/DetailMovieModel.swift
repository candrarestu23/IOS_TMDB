//
//  ParentDetailModel.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import Foundation
struct DetailMovieModel: Codable {
  let voteCount: Int?
  let posterPath: String?
  let id: Int?
  let originalTitle: String?
  let title: String?
  let voteAvarage: Double?
  let overview: String?
  let runtime: Int?
  let videos: VideosParentModel?
  let genres: [GenreModel]?
  
  enum CodingKeys: String, CodingKey {
    case voteCount = "vote_count"
    case posterPath = "poster_path"
    case id = "id"
    case originalTitle = "original_title"
    case title = "title"
    case voteAvarage = "vote_average"
    case overview = "overview"
    case runtime = "runtime"
    case videos = "videos"
    case genres = "genres"
  }
}

struct GenreModel : Codable{
  let id: Int?
  let name: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name
  }
}

struct VideosModel: Codable {
  let id: String?
  let key: String?
  let name: String?
  enum CodingKeys: String, CodingKey {
    case id,key,name
  }
}

struct VideosParentModel: Codable {
  let results: [VideosModel]?
  
  enum CodingKeys: String, CodingKey {
    case results
  }
}
