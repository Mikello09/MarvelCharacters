//
//  CharacterDetailPresenter.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit

protocol CharacterDetailPresenterProtocol{
    func characterDetail(character: Character)
}

class CharacterDetailPresenter{
    
    var delegate: CharacterDetailPresenterProtocol?
    
    var character: Character?
    
    func getCharacterDetail(){
        if let character = character {
            delegate?.characterDetail(character: character)
        }
    }
    
}
