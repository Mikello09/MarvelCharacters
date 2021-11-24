//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Mikel on 22/11/21.
//

import XCTest
@testable import MarvelCharacters

class MarvelCharactersTests: XCTestCase {
    
    
    class CharacterListPresenterSpy: CharacterListPresenterProtocol{
        
        var characterListSuccess = false
        var characterListFail = false
        
        func setCharacterList(characters: [Character]) {
            characterListSuccess = true
        }
        
        func failGettingCharacters(error: ErrorCode) {
            characterListFail = true
        }
        
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyCharacterList() throws {
        let presenterSpy = CharacterListPresenterSpy()
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        presenter.delegate = presenterSpy
        interactor.delegate = presenter
        interactor.delegate?.characterList(characters: [])
        XCTAssert(presenterSpy.characterListFail)
    }
    
    func testFullCharacterList() throws{
        let presenterSpy = CharacterListPresenterSpy()
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        presenter.delegate = presenterSpy
        interactor.delegate = presenter
        interactor.delegate?.characterList(characters: [Character()])
        XCTAssert(presenterSpy.characterListSuccess)
    }

}
