//
//  AnimeListCell.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/12/22.
//

import UIKit

class AnimeListCell: UITableViewCell {

    @IBOutlet weak var animeImage: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var sypnosisLabel: UILabel!
    @IBOutlet weak var epidNumLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
