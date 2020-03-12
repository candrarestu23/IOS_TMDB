//
//  ListMovieViewCell.swift
//  IndocyberTest
//
//  Created by User on 12/03/20.
//  Copyright © 2020 candra. All rights reserved.
//

import UIKit

class ListMovieViewCell: UICollectionViewCell {

  @IBOutlet weak var posterImg: UIImageView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var voterLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

}
