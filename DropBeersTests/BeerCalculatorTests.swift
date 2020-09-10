//
//  BeerCalculatorTests.swift
//  DropBeersTests
//
//  Created by Egemen Ayhan on 10.09.2020.
//

import XCTest
@testable import DropBeers

class TestFileHelper {

    enum InputFile: String {
        case twoBeers = "2BeersInput"
        case fiveBeers = "5BeersInput"
        case noSolution = "NoSolution"

        private static let inputFileType = "txt"
        var url: URL? {
            let path = Bundle(for: TestFileHelper.self).path(
                forResource: self.rawValue,
                ofType: InputFile.inputFileType
            )
            return URL(string: path ?? "")
        }
    }

}

class BeerCalculatorTests: XCTestCase {

    func testTwoBeersInput() throws {
        guard let url = TestFileHelper.InputFile.twoBeers.url  else {
            XCTAssert(false)
            return
        }
        let expectedResult: [Int: BrewType] = [1: .barrelAged, 2: .barrelAged]
        let beerCalculator = BeerCalculator(with: url)
        switch beerCalculator.calculate() {
        case .success(let result):
            XCTAssert(result == expectedResult)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testFiveBeersInput() throws {
        guard let url = TestFileHelper.InputFile.fiveBeers.url  else {
            XCTAssert(false)
            return
        }
        let expectedResult: [Int: BrewType] = [1: .classic, 2: .barrelAged, 3: .classic, 4: .barrelAged, 5: .classic]
        let beerCalculator = BeerCalculator(with: url)
        switch beerCalculator.calculate() {
        case .success(let result):
            XCTAssert(result == expectedResult)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testNoSolutionInput() throws {
        guard let url = TestFileHelper.InputFile.noSolution.url  else {
            XCTAssert(false)
            return
        }
        let beerCalculator = BeerCalculator(with: url)
        switch beerCalculator.calculate() {
        case .success:
            XCTAssert(false)
        case .failure(let error):
            XCTAssert(error == .noSolution)
        }
    }

}
