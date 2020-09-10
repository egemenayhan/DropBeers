//
//  StepTableViewCell.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 6.09.2020.
//

import UIKit

struct StepCellPresentation {
    let name: String?
    let amount: Unit?
    let add: String?
    let attribute: String?
    var isIdle: Bool = true
}

class StepTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var addStackview: UIStackView!
    @IBOutlet private weak var addLabel: UILabel!
    @IBOutlet private weak var attributeLabel: UILabel!
    @IBOutlet private weak var additionalInfoStackView: UIStackView!
    @IBOutlet private weak var stepDoneButton: UIButton!

    var stepDoneHandler: ((IndexPath) -> Void)?

    var presentation: StepCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.minimumScaleFactor = 0.6

        stepDoneButton.setTitle("IDLE", for: .normal)
        stepDoneButton.setTitle("DONE", for: .selected)
        stepDoneButton.setTitleColor(.white, for: .normal)
        stepDoneButton.tintColor = .clear
        stepDoneButton.layer.cornerRadius = 8.0
        stepDoneButton.clipsToBounds = true
    }

    private func updateUI() {
        guard let presentation = presentation else { return }

        nameLabel.text = presentation.name
        if let amount = presentation.amount {
            amountLabel.text = "\(amount.value) \(amount.unit)"
            amountLabel.isHidden = false
        } else {
            amountLabel.isHidden = true
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

        stepDoneButton.isSelected = !presentation.isIdle
        stepDoneButton.backgroundColor = presentation.isIdle ? .systemBlue : .systemGreen
    }

    @IBAction private func stepDoneTapped(_ sender: Any) {
        guard !stepDoneButton.isSelected,
            let tableView = superview as? UITableView,
            let indexPath = tableView.indexPath(for: self) else { return }
        stepDoneHandler?(indexPath)
    }

}
