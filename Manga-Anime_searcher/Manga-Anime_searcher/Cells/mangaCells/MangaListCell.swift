//
//  MangaListCell.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/14/22.
//

import UIKit

class MangaListCell: UITableViewCell {

    
    @IBOutlet weak var MangaImage: UIImageView!
    
    @IBOutlet weak var mangaTitleLabel: UILabel!
    
  
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var sypnosisLabel: UILabel!
    
//    @IBOutlet weak var epidNumLabel: UILabel!
    
    @IBOutlet weak var rankinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
