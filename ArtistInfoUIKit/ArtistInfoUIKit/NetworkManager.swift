//
//  NetworkManager.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import UIKit

enum CustomError: Error {
    case urlFailure
    case dataFailure
    case decodeFailure
}

protocol Network {
    func loadTrackList(name: String, completion: @escaping (Result<[Artist], Error>) -> Void)
}

final class NetworkManager {
    static var shared = NetworkManager()
    
    let session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: Network {
    func loadTrackList(name: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(name)") else {
            print("Guard URL statement failed")
            completion(.failure(CustomError.urlFailure))
            return
        }
        
        self.session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(CustomError.dataFailure))
                return
            }
            
            do {
                let wrapper = try JSONDecoder().decode(ArtistWrapper.self, from: data)
                completion(.success(wrapper.results))
            } catch {
                print(error)
                completion(.failure(CustomError.decodeFailure))
            }
        }.resume()
    }
}

protocol CustomSession {
    func loadTrackList(url: URL, completion: @escaping (Result<[Artist], Error>) -> Void)
}

extension URLSession: CustomSession {
    
    func loadTrackList(url: URL, completion: @escaping (Result<[Artist], Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
                    
                    guard let data = data else {
                        completion(.failure(CustomError.dataFailure))
                        return
                    }
                    
                    do {
                        let wrapper = try JSONDecoder().decode(ArtistWrapper.self, from: data)
                        completion(.success(wrapper.results))
                    } catch {
                        print(error)
                        completion(.failure(CustomError.decodeFailure))
                    }
                }.resume()
    }
    
}
