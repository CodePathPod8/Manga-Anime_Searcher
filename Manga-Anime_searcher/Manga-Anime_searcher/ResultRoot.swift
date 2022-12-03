//
//  ResultRoot.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/19/22.
//

import Foundation

struct ResultRoot: Decodable {
    var pagination: [PagObject]?
    var data: [MalObject]?
}

//struct ResultRoot: Codable {
//    enum CodingKeys: String, CodingKey {
//        case malId = "mal_id"
//        case data = "data"
//    }
//}

struct PagObject: Decodable {
    var lastVisiblePage: Int?
    var hasNextPage: String?
    
    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
    }
}

struct MalObject: Decodable {
    var malId: String?
    var entry: [EntrObject]?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
      case malId = "mal_id"
      case entry = "entry"
      case content = "content"
    }
}

struct EntrObject: Decodable {
    var mal_ids: Int?
    var url: URL?
    var images: [ImgObject]?
}

struct ImgObject: Decodable {
    var jpg: [JpgObject]?
}
struct JpgObject: Decodable {
    var imageUrl: URL?
    var smallimageUrl: URL?
    var largeImageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case smallimageUrl = "small_image_url"
        case largeImageUrl = "large_image_url"
    }
}
