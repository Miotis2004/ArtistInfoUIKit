//
//  ViewModelTests.swift
//  ArtistInfoUIKitTests
//
//  Created by Ronald Joubert on 2/15/21.
//

import XCTest
@testable import ArtistInfoUIKit

class ViewModelTests: XCTestCase {

    var viewModel: ViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModel = ViewModel(networkManager: MockNetworkManager())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArtistInfo() {
        // Arrange
        let artist = Artist(trackId: 1, artistName: "Snoop Dog", trackName: "Snoopy Snoop", releaseDate: "SomeDateHere", primaryGenreName: "Rap", trackPrice: 10.99)
        self.viewModel?.trackArray = [artist]
        
        // Act
        let count = self.viewModel?.count() ?? 0
        let artistName = self.viewModel?.artistName(index: 0)
        let trackName = self.viewModel?.trackName(index: 0)
        let release = self.viewModel?.releaseDate(index: 0)
        let genre = self.viewModel?.genre(index: 0)
        let price = self.viewModel?.price(index: 0)
        
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
        
        // Act / Assert
        self.viewModel?.bind(updateHandler: {
            expectation.fulfill()
        }, errorHandler: {
            XCTFail()
        })
        //wait(for: [expectation], timeout: 5.0)
        
        self.viewModel?.callNetwork(name: "")
        
        
        
    }

}



class MockNetworkManager: Network {
    
    func loadTrackList(name: String, completion: @escaping ([Artist]) -> Void) {
       
        DispatchQueue.global().async {
            let artist = Artist(trackId: 1, artistName: "Snoop Dog", trackName: "Snoopy Snoop", releaseDate: "SomeDateHere", primaryGenreName: "Rap", trackPrice: 10.99)
            completion([artist])
        }
        
    }
    
}
