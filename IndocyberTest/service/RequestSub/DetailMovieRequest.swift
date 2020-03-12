//
//  DetailMovieRequest.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import Foundation
class DetailMovieRequest: Request {
  static let shared = DetailMovieRequest()
    
  func getMovieDetail(id: Int,parameter: [String: Any], completion: @escaping (Data?, Error?) -> Void) {
    let url = baseApiUrl + "movie/\(id)"
    get(url, parameters: parameter) { (result, error) in
      completion(result, error)
    }
  }
}
