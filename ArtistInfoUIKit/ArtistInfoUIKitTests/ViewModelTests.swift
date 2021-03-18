//
//  ViewModelTests.swift
//  ArtistInfoUIKitTests
//
//  Created by Ronald Joubert on 2/15/21.
//

import XCTest
@testable import ArtistInfoUIKit

class ViewModelTests: XCTestCase {

    var viewModelWithPassing: ViewModel?
    var viewModelWithFailing: ViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModelWithPassing = ViewModel(networkManager: MockNetworkManagerPass())
        self.viewModelWithFailing = ViewModel(networkManager: MockNetworkManagerFail())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        self.viewModelWithPassing = nil
        self.viewModelWithFailing = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArtistInfo() {
        // Arrange
        let artist = Artist(trackId: 1, artistName: "Snoop Dog", trackName: "Snoopy Snoop", releaseDate: "SomeDateHere", primaryGenreName: "Rap", trackPrice: 10.99)
        self.viewModelWithPassing?.trackArray = [artist]
        
        // Act
        let count = self.viewModelWithPassing?.count() ?? 0
        let artistName = self.viewModelWithPassing?.artistName(index: 0)
        let trackName = self.viewModelWithPassing?.trackName(index: 0)
        let release = self.viewModelWithPassing?.releaseDate(index: 0)
        let genre = self.viewModelWithPassing?.genre(index: 0)
        let price = self.viewModelWithPassing?.price(index: 0)
        
        // Assert
        XCTAssertEqual(count, 1)
        XCTAssertEqual(artistName, "Snoop Dog")
        XCTAssertEqual(trackName, "Snoopy Snoop")
        XCTAssertEqual(release, "SomeDateHere")
        XCTAssertEqual(genre, "Rap")
        XCTAssertEqual(price, 10.99)
    }
    
    func testCallNetwork() {
        // Arrange
        let expectation = XCTestExpectation()
        
        // Act
        self.viewModelWithPassing?.bind(updateHandler: {
            expectation.fulfill()
        }, errorHandler: {
            XCTFail()
        })
        self.viewModelWithPassing?.callNetwork(name: "")
        
        // Assert
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCallNetworkFail() {
        // Arrange
        let expectation = XCTestExpectation()
        
        // Act
        self.viewModelWithFailing?.bind(updateHandler: {
            XCTFail()
        }, errorHandler: {
            expectation.fulfill()
        })
        self.viewModelWithFailing?.callNetwork(name: "")
        
        // Assert
        wait(for: [expectation], timeout: 3)
    }

}



class MockNetworkManagerPass: Network {
    
    func loadTrackList(name: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
       
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
            let artist = Artist(trackId: 1, artistName: "Snoop Dog", trackName: "Snoopy Snoop", releaseDate: "SomeDateHere", primaryGenreName: "Rap", trackPrice: 10.99)
            completion(.success([artist]))
        })
        
    }
    
}

class MockNetworkManagerFail: Network {
    
    func loadTrackList(name: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
       
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
            completion(.failure(CustomError.decodeFailure))
        })
        
    }
    
}
