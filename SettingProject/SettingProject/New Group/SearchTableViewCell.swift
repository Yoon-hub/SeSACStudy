//
//  SearchTableViewCell.swift
//  SettingProject
//
//  Created by 최윤제 on 2022/07/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageVIew: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    func configureCell(data: Movie){
        movieTitleLabel.text = data.title
        movieSummaryLabel.text = data.overview
        dateLabel.text = data.overview
    }
    
}
