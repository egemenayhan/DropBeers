//
//  BeerCalculator.swift
//  DropBeers
//
//  Created by Apple Seed on 5.09.2020.
//

import Foundation

class BeerCalculator {

    typealias CalculatorResult = Result<BeerBrewResult, CalculatorError>
    typealias BeerBrewResult = [Int: BrewType]

    enum CalculatorError: Error {
        case noSolution
        case fileError
    }

    private struct Customer {
        var id: Int
        var likedBeers: [Beer]
    }

    private var beerTypeCount = 0
    private var customers: [Customer] = []
    private var results: BeerBrewResult = [:]
    private let fileURL: URL

    init(with fileURL: URL) {
        self.fileURL = fileURL
    }

    func calculate() -> CalculatorResult {
        let result: CalculatorResult
        do {
            try self.readFile(at: fileURL)
            if !cleanSingleOptionsCheckIfNoSolution() {
                findRequiredBrews()
                result = .success(results)
            } else {
                result = .failure(CalculatorError.noSolution)
            }
        } catch {
            result = .failure(CalculatorError.fileError)
        }
        return result
    }

    private func cleanSingleOptionsCheckIfNoSolution() -> Bool {
        var customerIdsToDelete: [Int] = []
        for customer in customers where customer.likedBeers.count == 1 {
            guard let beer = customer.likedBeers.first else { return false }
            if let currentBrew = results[beer.id], currentBrew != beer.brew {
                return true // No solution case
            }
            customerIdsToDelete.append(customer.id)
            results[beer.id] = beer.brew
        }
        customers.removeAll { customerIdsToDelete.contains($0.id) }
        removeSelectedBeersFromCustomers()
        setDefaultBrewToEmptyResults()
        return false
    }

    private func setDefaultBrewToEmptyResults() {
        guard beerTypeCount > 0 else { return }
        for index in 1...beerTypeCount where results[index] == nil {
            results[index] = BrewType.classic
        }
    }

    private func removeSelectedBeersFromCustomers() {
        for var customer in customers {
            customer.likedBeers.removeAll { results.keys.contains($0.id) }
        }
    }

    private func findRequiredBrews() {
        var isAllSatisfied = true
        customers.forEach { (customer) in
            if !isSatisfied(customer: customer) {
                updateResult(for: customer)
                isAllSatisfied = customers.count == 1 // If there is only one user we dont need to check again
                return
            }
        }
        if !isAllSatisfied {
            findRequiredBrews()
            return
        }
    }

    private func updateResult(for customer: Customer) {
        for beer in customer.likedBeers where beer.brew == .barrelAged {
            results[beer.id] = beer.brew
        }
    }

    private func isSatisfied(customer: Customer) -> Bool {
        var isSatisfied = false
        customer.likedBeers.forEach { (beer) in
            if results[beer.id] == beer.brew {
                isSatisfied = true
                return
            }
        }
        return isSatisfied
    }

    private func createCustomer(id: Int, info: String) -> Customer {
        var beers: [Beer] = []
        var type: Int?
        var brew: BrewType?
        let components = info.components(separatedBy: .whitespaces)
        for (index, component) in components.enumerated() {
            if index % 2 == 0 {
                type = Int(component)
                continue
            } else {
                brew = BrewType(rawValue: component)
            }
            if let beerType = type, let beerBrew = brew {
                beers.append(Beer(id: beerType, brew: beerBrew))
                type = nil
                brew = nil
            }
        }
        return Customer(id: id, likedBeers: beers)
    }

    private func readFile(at fileURL: URL) throws {
        let content = try String(contentsOfFile: fileURL.path, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
        var contents: [String] = content.components(separatedBy: .newlines)
        beerTypeCount = Int(contents.removeFirst().trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        contents = Array(Set(contents))
        customers = []
        for (index, info) in contents.enumerated() {
            customers.append(createCustomer(id: index + 1, info: info.trimmingCharacters(in: .whitespacesAndNewlines)))
        }
    }

}
