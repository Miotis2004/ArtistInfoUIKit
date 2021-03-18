//
//  ViewModel.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import UIKit


class ViewModel {
    
    var networkManager: Network
    var trackArray: [Artist]? {
        didSet {
            guard trackArray?.count ?? 0 > 0 else { return }
            self.updateHandler?()
        }
    }
    var updateHandler: (() -> Void)?
    var errorHandler: (() -> Void)?
 
    init(networkManager: Network = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func bind(updateHandler: @escaping (() -> Void), errorHandler: @escaping (() -> Void)) {
        self.updateHandler = updateHandler
        self.errorHandler = errorHandler
    }
    
}

extension ViewModel {
    
    func callNetwork(name: String) {
        self.networkManager.loadTrackList(name: name) { [weak self] (result) in
            switch result {
            case .success(let artists):
                self?.trackArray = artists
            case .failure(_):
                self?.errorHandler?()
            }
            
    
        }
    }
    
    // Functions to retrieve data from the model
    func count() -> Int {
        return self.trackArray?.count ?? 0
    }
    
    func artistName(index: Int) -> String {
        guard self.count() > index else { return "" }
        return self.trackArray?[index].artistName ?? ""
    }
    
    func trackName(index: Int) -> String {
        guard self.count() > index else { return "" }
        return self.trackArray?[index].trackName ?? ""
    }
    
    func releaseDate(index: Int) -> String {
        guard self.count() > index else { return "" }
        return self.trackArray?[index].releaseDate ?? ""
    }
    
    func genre(index: Int) -> String {
        guard self.count() > index else { return "" }
        return self.trackArray?[index].primaryGenreName ?? ""
    }
    
    func price(index: Int) -> Double {
        guard self.count() > index else { return 0.0 }
        return self.trackArray?[index].trackPrice ?? 0.0
    }
    
}
