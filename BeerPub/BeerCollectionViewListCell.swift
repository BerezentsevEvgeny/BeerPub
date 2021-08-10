//
//  BeerCollectionViewCell.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 08.08.2021.
//

import UIKit

class BeerCollectionViewListCell: UICollectionViewListCell {

    func configureCell(with beer: Beer, completion: @escaping ()->Void) {
        var content = defaultContentConfiguration()
        content.text = beer.name
        content.secondaryText = beer.tagline
        content.imageProperties.maximumSize = CGSize(width: 70, height: 70)
        content.image = UIImage(systemName: "arrow.right.circle")

        contentConfiguration = content
        accessories = [.disclosureIndicator()]
         
    }
    
}
