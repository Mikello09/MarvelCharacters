//
//  CharacterCell.swift
//  MarvelCharacters
//
//  Created by Mikel on 23/11/21.
//

import Foundation
import UIKit

protocol CharacterCellProtocol{
    func onCharacterSelected(character: Character)
}

class CharacterCell: UITableViewCell{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var characterThumbnail: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var comicsTitle: UILabel!
    @IBOutlet weak var comicsNumber: UILabel!
    @IBOutlet weak var storiesTitle: UILabel!
    @IBOutlet weak var storiesNumber: UILabel!
    @IBOutlet weak var eventsTitle: UILabel!
    @IBOutlet weak var eventsNumber: UILabel!
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var seriesNumber: UILabel!
    
    var delegate: CharacterCellProtocol?
    var character: Character?
    
    func configure(character: Character, delegate: CharacterCellProtocol?){
        self.delegate = delegate
        self.character = character
        
        
        container.layer.cornerRadius = 12
        
        characterThumbnail.layer.cornerRadius = 12
        characterThumbnail.layer.borderColor = UIColor.gray.cgColor
        characterThumbnail.layer.borderWidth = 1
        characterThumbnail.contentMode = .scaleAspectFit
        characterThumbnail.layer.masksToBounds = true
        ImageManager().getImage(path: character.thumbnail?.path ?? "", variant: .standardXLarge, imageExtension: character.thumbnail?.extension ?? ""){ characterImage in
            DispatchQueue.main.async {
                self.characterThumbnail.image = characterImage
            }
        }
        
        characterName.text = character.name
        comicsTitle.text = "Comics:"
        comicsNumber.text = String(character.comics?.returned ?? 0)
        storiesTitle.text = "Stories:"
        storiesNumber.text = String(character.stories?.returned ?? 0)
        eventsTitle.text = "Events:"
        eventsNumber.text = String(character.events?.returned ?? 0)
        seriesTitle.text = "Series:"
        seriesNumber.text = String(character.series?.returned ?? 0)
        
    }
    
    @IBAction func onCharacterClicked(_ sender: Any) {
        if let character = character {
            self.delegate?.onCharacterSelected(character: character)
        }
    }
}
