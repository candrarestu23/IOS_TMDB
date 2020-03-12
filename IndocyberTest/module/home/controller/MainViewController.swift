//
//  MainViewController.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  private var pages = 2
  
  private var movieData: [ListMovieModel] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    initCollectionView()
    fetchHistory(page: 1)
  }
  
  private func initCollectionView() {
    let nib = UINib(nibName: "ListMovieViewCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "MovieCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsHorizontalScrollIndicator = true
  }
  
  private func fetchHistory(page: Int){
    let param = ["api_key": Constant.API_KEY, "language": Constant.LANG, "sort_by": Constant.SORT_DESC, "include_adult": false, "include_video": false, "page" : page] as [String : Any]
    
    ListMovieRequest.shared.getMovieList(parameter: param) { (data, error) in
      if error != nil {
        
      }
      
      guard let data = data else { return }
      
      do {
        let dataObject = try JSONDecoder().decode(ParentListModel.self, from: data)
        let data = dataObject.results
        if let itemList = data {
          self.movieData.append(contentsOf: itemList)
        }
        print(self.movieData.count)
        self.collectionView.reloadData()
      } catch {
        print(error)
      }
    }
  }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.movieData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? ListMovieViewCell else {
      fatalError("can't dequeue CustomCell")
    }
    let data = self.movieData[indexPath.row]
    cell.posterImg.loadImageUsingCache(withUrl:"http://image.tmdb.org/t/p/w500\(data.posterPath ?? "")")
    cell.titleLabel.text = data.originalTitle
    cell.voterLabel.text = String(data.voteCount ?? 0)
    cell.ratingLabel.text = String(data.voteAvarage ?? 0)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    detailVC.movieID = self.movieData[indexPath.row].id
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 400)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if (indexPath.row == self.movieData.count - 1 ) {
      fetchHistory(page: self.pages)
      self.pages += 1
    }
  }
  
}
