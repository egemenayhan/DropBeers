//
//  StepTableViewCell.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
//

import UIKit

struct StepCellPresentation {
    let name: String?
    let amount: Amount?
    let add: String?
    let attribute: String?
}

class StepTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountStackView: UIStackView!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var addStackview: UIStackView!
    @IBOutlet private weak var addLabel: UILabel!
    @IBOutlet private weak var attributeLabel: UILabel!
    @IBOutlet private weak var additionalInfoStackView: UIStackView!

    var presentation: StepCellPresentation? {
        didSet {
            updateUI()
        }
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private func updateUI() {
        guard let presentation = presentation else { return }

        nameLabel.text = presentation.name
        if let amount = presentation.amount {
            amountLabel.text = "\(amount.value) \(amount.unit)"
            amountStackView.isHidden = false
        } else {
            amountStackView.isHidden = true
        }
        if let add = presentation.add {
            addLabel.text = add
            addStackview.isHidden = false
        } else {
            addStackview.isHidden = true
        }
        attributeLabel.text = presentation.attribute
        attributeLabel.isHidden = presentation.attribute == nil
        additionalInfoStackView.isHidden = attributeLabel.isHidden && addStackview.isHidden
    }

}
