//
//  MangaTableCell.swift
//  Manga-Anime_searcher
//
//  Created by Shankar Ale Magar on 10/30/22.
//

import UIKit
import AlamofireImage

class MangaTableCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var MangaCategory: UILabel!
    
    var mangaTransferred = [[String:Any]] ()
    
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
extension MangaTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let manga = mangaTransferred[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Manga_Collection_cell", for: indexPath) as? MangasmalCollectionCell else {
            fatalError("Wrong cell class dequeueed for manga")
        }
        //the below code access the images within the Anime dict
        let imagepath = manga["images"] as! [String:Any]
        // the below coede access the jpg dict
        let jpgImage = imagepath["jpg"] as! [String:Any]
        //this access the final level of the dict
        let imageurlPath = jpgImage["large_image_url"] as! String
        // converting the string into URL
        let imgUrl = URL(string: imageurlPath)
        // display images
        cell.mangaImage.af.setImage(withURL:imgUrl!)

        cell.mangaTitleLabel.text = manga["title"] as? String
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
return CGSize(width: 149, height: 210)
    }
}

