//
//  CharacterDetailRouter.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit


class CharacterDetailRouter{
    
    func goToCharacterDetail(character: Character, navigationController: UINavigationController?){
        if let navigationController = navigationController {
            let storyboard = UIStoryboard(name: "CharacterDetailStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "characterDetailStoryboard") as! CharacterDetailViewController
            let presenter = CharacterDetailPresenter()
            presenter.character = character
            presenter.delegate = vc
            vc.presenter = presenter
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .currentContext
            navigationController.present(vc, animated: true, completion: nil)
            
        }
    }
    
}
