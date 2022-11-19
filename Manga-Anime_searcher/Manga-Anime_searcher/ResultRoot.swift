////
////  ResultRoot.swift
////  Manga-Anime_searcher
////
////  Created by Yunior Sanchez on 11/19/22.
////
//
//import Foundation
//
//struct ResultRoot: Codable {
//    var pagination: [pagObject]?
//    var data: [MalObject]?
//}
////struct ResultRoot: Codable {
////
////     enum CodingKeys: String, CodingKey {
////            case malId = "mal_id"
////            case data = "data"
////     }
////}
//struct pagObject: Codable{
//    var last_visible_page: Int
//    var has_next_page: String
//    enum CodingKeys: String, CodingKey {
//        case lastvisiblepage = "last_visible_page"
//        case hasnextpage = "has_next_page"
//    }
//}
//struct MalObject: Codable {
//    var mal_id: String
//    var entry: [entrObject]
//    var content: String
//    
//    enum CodingKeys: String, CodingKey {
//      case malId = "mal_id"
//      case entry = "entry"
//      case content = "content"
//    }
//}
//
//struct entrObject: Codable {
//    var mal_ids: Int
//    var url: URL
//    var images: [imgObject]
//}
//
//struct imgObject: Codable {
//    var jpg: [jpgObject]
//}
//struct jpgObject:Codable {
//    var image_url: URL
//    var small_image_url: URL
//    var large_image_url: URL
//    enum CodingKeys: String, CodingKey {
//        case imageUrl
//        case smallImageUrl
//        case larImageURL
//    }
//}
