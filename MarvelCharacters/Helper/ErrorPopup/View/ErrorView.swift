//
//  ErrorView.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit

protocol ErrorViewProtocol{
    func ok()
}

class ErrorView: UIView{
    
    var delegate: ErrorViewProtocol?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    func configure(error: ErrorCode, delegate: ErrorViewProtocol){
        self.delegate = delegate
        
        view.layer.cornerRadius = 12
        acceptButton.layer.cornerRadius = 4
        
        errorTitle.text = "Ups!"
        errorMessage.text = error.getMessage()
        acceptButton.setTitle("OK", for: .normal)
    }
    
    @IBAction func onAccept(_ sender: UIButton) {
        delegate?.ok()
    }
}


extension ErrorView{
    func nibSetup(){
        view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
