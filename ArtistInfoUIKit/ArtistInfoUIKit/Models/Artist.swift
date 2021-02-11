//
//  Artist.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import Foundation
import CoreData


struct ArtistWrapper: Codable {
    var resultCount: Int
    var results: [Artist]
}

struct Artist: Codable {
    var trackId: Int?
    var artistName: String
    var trackName: String?
    var releaseDate: String
    var primaryGenreName: String
    var trackPrice: Double?
}
