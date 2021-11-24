//
//  ErrorPopupRouter.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit


class ErrorPopupRouter{
    
    func goToError(navigationController: UINavigationController?, error: ErrorCode, completion: @escaping(()->())){
        if let navigationController = navigationController {
            let storyboard = UIStoryboard(name: "ErrorPopupStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "errorPopupStoryboard") as! ErrorPopupViewController
            vc.error = error
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .currentContext
            navigationController.present(vc, animated: true, completion: completion)
        }
    }
    
}
