//
//  CharacterListRouter.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit


class CharacerListRouter{
    
    func createInstance() -> UINavigationController{
        let storyboard = UIStoryboard(name: "CharacterListStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "characterListStoryboard") as! CharacterListViewController
        let presenter = CharacterListPresenter()
        presenter.delegate = vc
        vc.presenter = presenter
        return UINavigationController(rootViewController: vc)
    }
    
}
