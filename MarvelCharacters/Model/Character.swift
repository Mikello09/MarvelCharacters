//
//  Character.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit

struct CharacterObject: Codable{
    var code: Int
    var data: CharacterData
}

struct CharacterData: Codable{
    var total: Int
    var count: Int
    var results: [Character]
}

struct Character: Codable{
    var id: Int?
    var name: String?
    var description: String?
    var resourceURI: String?
    var thumbnail: ThumbnailData?
    var comics: ComicList?
    var stories: StoryList?
    var events: EventList?
    var series: SeriesList?
}

struct ThumbnailData: Codable{
    var path: String?
    var `extension`: String?
}

struct ComicList: Codable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [ComicSummary]?
}

struct ComicSummary: Codable{
    var resourceURI: String?
    var name: String?
}

struct StoryList: Codable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorySummary]?
}

struct StorySummary: Codable{
    var resourceURI: String?
    var name: String?
    var type: String?
}

struct EventList: Codable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventSummary]?
}

struct EventSummary: Codable{
    var resourceURI: String?
    var name: String?
}

struct SeriesList: Codable{
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [SeriesSummary]?
}

struct SeriesSummary: Codable{
    var resourceURI: String?
    var name: String?
}

struct CharacterDataWrapper: Codable{
    var code: Int?
    var status: String?
}

