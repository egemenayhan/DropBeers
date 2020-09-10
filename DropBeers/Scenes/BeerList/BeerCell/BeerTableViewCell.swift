//
//  BeerTableViewCell.swift
//  DropBeers
//
//  Created by Apple Seed on 6.09.2020.
//

import UIKit
import AlamofireImage

struct BeerCellPresentation {
    let name: String?
    let imagePath: String?
    let abv: Double?
    let brewType: BrewType
}

class BeerTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet private weak var beerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var abvLabel: UILabel!
    @IBOutlet private weak var brewLabel: UILabel!

    var presentation: BeerCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        beerImageView.af.cancelImageRequest()
        nameLabel.text = nil
        abvLabel.text = nil
        brewLabel.text = nil
    }

    private func updateUI() {
        guard let presentation = presentation else { return }

        nameLabel.text = presentation.name
        abvLabel.text = "\(presentation.abv ?? 0)"
        brewLabel.text = presentation.brewType.title

        if let imageURL = URL(string: presentation.imagePath ?? "") {
            beerImageView.af.setImage(withURL: imageURL)
        }
    }

}
