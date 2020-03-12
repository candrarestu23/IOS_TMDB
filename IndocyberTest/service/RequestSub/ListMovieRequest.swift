//
//  ListMovieRequest.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import Foundation
class ListMovieRequest: Request {
  static let shared = ListMovieRequest()
    
  func getMovieList(parameter: [String: Any], completion: @escaping (Data?, Error?) -> Void) {
    let url = baseApiUrl + "discover/movie"
    get(url, parameters: parameter) { (result, error) in
      completion(result, error)
    }
  }
}
