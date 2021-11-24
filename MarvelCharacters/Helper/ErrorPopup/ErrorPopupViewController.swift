//
//  ErrorPopupViewController.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit

class ErrorPopupViewController: UIViewController{
    
    var error: ErrorCode?
    @IBOutlet weak var errorView: ErrorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        DispatchQueue.main.async {
            self.errorView.layer.cornerRadius = 12
            self.errorView.configure(error: self.error ?? .general, delegate: self)
            self.errorView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.errorView.alpha = 1
                self.errorView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                ()
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                    self.errorView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { _ in
                    ()
                })
            })
        }
    }
}

extension ErrorPopupViewController: ErrorViewProtocol{
    func ok() {
        self.dismiss(animated: true, completion: nil)
    }
}
