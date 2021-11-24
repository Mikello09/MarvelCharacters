//
//  CharacterListPresenter.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit


protocol CharacterListPresenterProtocol{
    func setCharacterList(characters: [Character])
    func failGettingCharacters(error: ErrorCode)
}

class CharacterListPresenter{
    
    var delegate: CharacterListPresenterProtocol?
    
    func getCharacterList(){
        CharacterListInteractor().getCharacterList(delegate: self)
    }
    
}

extension CharacterListPresenter: CharacterListInteractorProtocol{
    func characterList(characters: [Character]) {
        if characters.count > 0 {
            delegate?.setCharacterList(characters: characters)
        } else {
            delegate?.failGettingCharacters(error: .general)
        }
    }
    
    func failGettingCharacterList(error: ErrorCode) {
        delegate?.failGettingCharacters(error: error)
    }
    
}
