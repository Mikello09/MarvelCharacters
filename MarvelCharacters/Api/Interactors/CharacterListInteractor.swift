//
//  CharacterListInteractor.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit

protocol CharacterListInteractorProtocol{
    func characterList(characters: [Character])
    func failGettingCharacterList(error: ErrorCode)
}

class CharacterListInteractor{
    
    var delegate: CharacterListInteractorProtocol?
    
    func getCharacterList(delegate: CharacterListInteractorProtocol){
        self.delegate = delegate
        CharacterListWorker().getCharacterList(delegate: self)
    }
    
}

extension CharacterListInteractor: CharacterListWorkerProtocol{
    func success(characterList: [Character]) {
        delegate?.characterList(characters: characterList)
    }
    
    func fail(error: ErrorCode) {
        delegate?.failGettingCharacterList(error: error)
    }
    
    
}
