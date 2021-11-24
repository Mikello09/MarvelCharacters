//
//  DetailItemCell.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit


class DetailItemCell: UICollectionViewCell{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var detailTitle: UILabel!
    
    func configure(detailTitle: String){
        container.layer.cornerRadius = 4
        self.detailTitle.text = detailTitle
    }
    
}
