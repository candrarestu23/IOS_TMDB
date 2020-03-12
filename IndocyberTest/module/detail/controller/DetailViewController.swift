//
//  DetailViewController.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class DetailViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var posterImg: UIImageView!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var youtubePlayer: WKYTPlayerView!
  
  var movieID: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let ID = self.movieID {
      fetchHistory(id: ID)
    }
  }
  
  private func fetchHistory(id: Int){
    let param = ["api_key": Constant.API_KEY, "language": Constant.LANG, "append_to_response" : "videos"] as [String : Any]
    
    DetailMovieRequest.shared.getMovieDetail(id: id ,parameter: param) { (data, error) in
      if error != nil {
        
      }
      
      guard let data = data else { return }
      
      do {
        let dataObject = try JSONDecoder().decode(DetailMovieModel.self, from: data)
        let videos = dataObject.videos?.results
        var listGenre = ""
        for genre in dataObject.genres ?? [] {
          listGenre += genre.name! + ","
        }
        
        self.titleLabel.text = dataObject.title 
        self.yearLabel.text = "(2019)"
        self.infoLabel.text = "\(String(describing: dataObject.runtime)) min | \(listGenre)"
        self.descLabel.text = dataObject.overview
        
        let imgUrl = "http://image.tmdb.org/t/p/w185\( dataObject.posterPath ?? "")"
        self.posterImg.loadImageWithURL(imageURL: imgUrl)
        if let youtubeID = videos?[0].key{
          self.youtubePlayer.load(withVideoId: youtubeID)
          print(youtubeID)
        }
      } catch {
        print(error)
      }
    }
  }
  
}
