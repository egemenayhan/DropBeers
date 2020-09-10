//
//  BeerDetailTests.swift
//  DropBeersTests
//
//  Created by Egemen Ayhan on 10.09.2020.
//

import XCTest
@testable import DropBeers

class BeerDetailTests: XCTestCase {

    var mockProvider: MockBeerDataProvider!
    lazy var viewModel: BeerDetailViewModel = {
        return BeerDetailViewModel(state: BeerDetailState(beer: beer), provider: mockProvider)
    }()
    var beer = Beer(id: 0, brew: .barrelAged)

    override func setUpWithError() throws {
        mockProvider = MockBeerDataProvider()
    }

    func testFetchBeerDetailSuccess() throws {
        mockProvider.beer = beer
        viewModel.addChangeHandler { [weak self] (change) in
            switch change {
            case .beerDetailFetched:
                XCTAssert(self?.viewModel.state.beer == self?.beer)
            case .error:
                XCTAssert(false)
            default:
                break
            }
        }
        viewModel.fetchDetails()
    }

    func testFetchBeerDetailFail() throws {
        viewModel.addChangeHandler { (change) in
            switch change {
            case .beerDetailFetched:
                XCTAssert(false)
            case .error:
                XCTAssert(true)
            default:
                break
            }
        }
        viewModel.fetchDetails()
    }

}
