//
//  StringExtensions.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import Foundation

extension String {
    
    func convertStringDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: self) ?? Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
}
