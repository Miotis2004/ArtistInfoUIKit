//
//  ViewModel.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import Foundation
import CoreData

class ViewModel {
    
    var networkManager: NetworkManager
    var trackArray: [Artist]? {
        didSet {
            self.updateHandler?()
        }
    }
    var updateHandler: (() -> Void)?
 
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func bind(updateHandler: @escaping (() -> Void)) {
        self.updateHandler = updateHandler
    }
    
}

extension ViewModel {
    
    func callNetwork(name: String) {
        self.networkManager.loadTrackList(name: name) { [weak self] (artists) in
            self?.trackArray = artists
        }
    }
    
    // Functions to retrieve data from the model
    func count() -> Int {
        return self.trackArray?.count ?? 0
    }
    
    func artistName(index: Int) -> String {
        return self.trackArray?[index].artistName ?? ""
    }
    
    func trackName(index: Int) -> String {
        return self.trackArray?[index].trackName ?? ""
    }
    
    func releaseDate(index: Int) -> String {
        return self.trackArray?[index].releaseDate ?? ""
    }
    
    func genre(index: Int) -> String {
        return self.trackArray?[index].primaryGenreName ?? ""
    }
    
    func price(index: Int) -> Double {
        return self.trackArray?[index].trackPrice ?? 0.0
    }
    
}
