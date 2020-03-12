//
//  Request.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import Foundation
import Alamofire

struct ErrorRequestModel : Codable {
  let errorCode, message: String
  
  enum CodingKeys: String, CodingKey {
    case errorCode = "error_code"
    case message
  }
}
let imdbToken = "2972cae9753a74c718255cacf52897df" // for testing

let headers = ["Content-Type": "application/json"]

class Request: Any {
  let baseApiUrl = Constant.BASE_URL
  func get(_ url: String, parameters: Parameters? = nil, completion: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url,method: .get, parameters: parameters, headers: headers).validate().responseData { response in
      switch response.result {
      case .success(let value):
        completion(value, nil)
      case .failure(let error):
        if let statusCode = response.response?.statusCode, let data = response.data {
          #if DEBUG
          debugPrint("ERROR STATUS CODE \(statusCode) of \(url)")
          #endif

          if statusCode == 429 {
            completion(nil, error)
            return
          }
          
          do {
            let decodedData = try JSONDecoder().decode(ErrorRequestModel.self, from: data)
            completion(nil, NSError(domain: "", code: statusCode, userInfo: [
              NSLocalizedDescriptionKey: decodedData.message
            ]))
          } catch {
            completion(nil, error)
          }
        } else {
          completion(nil, error)
        }
      }
    }
  }
  
  
//MARK: - Post With Token
  func post(_ url: String, parameters: Parameters? = nil, completion: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData { response in
      switch response.result {
      case .success(let value):
        completion(value, nil)
      case .failure(let error):
        if let statusCode = response.response?.statusCode, let data = response.data {
          #if DEBUG
          debugPrint("ERROR STATUS CODE \(statusCode) of \(url)")
          #endif

          do {
            let decodedData = try JSONDecoder().decode(ErrorRequestModel.self, from: data)
            completion(nil, NSError(domain: "", code: statusCode, userInfo: [
              NSLocalizedDescriptionKey: decodedData.message
            ]))
          } catch {
            completion(nil, error)
          }
        } else {
          completion(nil, error)
        }
      }
    }
  }
}
