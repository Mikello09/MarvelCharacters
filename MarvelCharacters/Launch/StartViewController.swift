//
//  LaunchViewController.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit

class StartViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let characterListVC = CharacerListRouter().createInstance()
        UIApplication.shared.windows.first?.rootViewController = characterListVC
    }
    
}
