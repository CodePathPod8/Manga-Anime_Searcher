//
//  AnimeTableCell.swift
//  Manga-Anime_searcher
//
//  Created by Shankar Ale Magar on 10/30/22.
//

import UIKit
import AlamofireImage

class AnimeTableCell: UITableViewCell{
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var catagory: UILabel!
    var AnimesTransferred = [[String: Any]] ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        let width = collectionView.frame.size.width*2
        layout.itemSize = CGSize(width: width, height: 300)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension AnimeTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var Anime = AnimesTransferred[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection_cell", for: indexPath) as? SmallcellCollection else {
            fatalError("Wrong cell class dequeued")
        }
        //let baseUrl = "https://myanimelist.net/anime/genre/57/"

        cell.AnimeName.text = Anime["title"] as? String
//        let posterUrl = URL(string: baseUrl+cell.AnimeName.text!)
//
//        
//        cell.AnimeImages.af.setImage(withURL: posterUrl!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
return CGSize(width: 149, height: 210)
    }
}
