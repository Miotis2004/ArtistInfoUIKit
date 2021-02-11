//
//  NetworkManager.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import UIKit

final class NetworkManager {
    static var shared = NetworkManager()
    
    let session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager {
    func loadTrackList(name: String, completion: @escaping ([Artist]) -> Void) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(name)") else {
            print("Guard URL statement failed")
            completion([])
            return
        }
        
        self.session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let wrapper = try JSONDecoder().decode(ArtistWrapper.self, from: data)
                completion(wrapper.results)
            } catch {
                print(error)
            }
        }.resume()
    }
}
