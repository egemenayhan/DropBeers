//
//  BeerStepPresentation.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 8.09.2020.
//

import Foundation

struct BeerStepPresentation {

    enum StepType {
        case malt
        case hop
        case method

        var title: String {
            switch self {
            case .hop:
                return "HOPS"
            case .malt:
                return "MALTS"
            case .method:
                return "METHODS"
            }
        }
    }

    var steps: [StepType: [StepCellPresentation]] = [:]

    func presentations(for section: Int) -> [StepCellPresentation]? {
        let key = Array(steps.keys)[section]
        return steps[key]
    }

    mutating func update(with beer: Beer) {
        steps = [:]
        if let malts = beer.malts {
            map(ingredients: malts, toType: .malt)
        }
        if let hops = beer.hops {
            map(ingredients: hops, toType: .hop)
        }
        if let methods = beer.methods {
            map(methods: methods, toType: .method)
        }
    }

    private mutating func map(ingredients: [Ingredient], toType key: StepType) {
        steps[key] = ingredients.map {
            return StepCellPresentation(
                name: $0.name,
                amount: $0.amount,
                add: $0.add,
                attribute: $0.attribute
            )
        }
    }

    private mutating func map(methods: [Method], toType key: StepType) {
        var stepPresentations: [StepCellPresentation] = []
        methods.forEach { (method) in
            let title = method.title
            let presentations = method.infos.map { (info) -> StepCellPresentation in
                let duration = info.duration == nil ? nil : String(format: "%.0f", info.duration ?? 0)
                return StepCellPresentation(
                    name: title,
                    amount: info.temp,
                    add: nil,
                    attribute: duration
                )
            }
            stepPresentations.append(contentsOf: presentations)
        }
        steps[key] = stepPresentations
    }

}
