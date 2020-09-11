//
//  BeerListTests.swift
//  DropBeersTests
//
//  Created by Apple Seed on 10.09.2020.
//

import XCTest
@testable import DropBeers

class BeerListTests: XCTestCase {

    var provider: MockBeerDataProvider!
    lazy var viewModel: BeerListViewModel = {
        return BeerListViewModel(state: BeerListState(), provider: provider)
    }()

    override func setUpWithError() throws {
        provider = MockBeerDataProvider()
    }

    func testFetchRequiredBeersSuccess() throws {
        provider.fileURL = TestFileHelper.InputFile.twoBeers.url
        provider.beers = [Beer(id: 1, brew: .barrelAged), Beer(id: 2, brew: .barrelAged)]
        viewModel.addChangeHandler { [weak self] (change) in
            switch change {
            case .beersUpdated:
                XCTAssert(self?.viewModel.state.beers == self?.provider.beers)
            case .error:
                XCTAssert(false)
            default:
                break
            }
        }
        viewModel.fetchRequiredBeers()
    }

    func testFetchRequiredBeersFailure() throws {
        viewModel.addChangeHandler { (change) in
            switch change {
            case .beersUpdated:
                XCTAssert(false)
            case .error:
                XCTAssert(true)
            default:
                break
            }
        }
        viewModel.fetchRequiredBeers()
    }

}
