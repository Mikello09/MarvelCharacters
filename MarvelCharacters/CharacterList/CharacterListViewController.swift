//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit

class CharacterListViewController: UIViewController{
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var charactersTable: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var presenter: CharacterListPresenter?
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI(){
        self.title = "Marvel Characters"
        noDataLabel.text = "No data available"
        
        charactersTable.delegate = self
        charactersTable.dataSource = self
        charactersTable.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
        loader.startAnimating()
        presenter?.getCharacterList()
    }
}

//MARK: PRESENTER
extension CharacterListViewController: CharacterListPresenterProtocol{
    func setCharacterList(characters: [Character]) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.characters = characters
            self.charactersTable.reloadData()
        }
    }
    
    func failGettingCharacters(error: ErrorCode) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.charactersTable.isHidden = true
            ErrorPopupRouter().goToError(navigationController: self.navigationController, error: error){
                self.noDataLabel.isHidden = false
            }
        }
    }
}

//MARK: Table
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterCell
        cell.configure(character: characters[indexPath.row], delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 382
    }
    
}

//MARK: CELL
extension CharacterListViewController: CharacterCellProtocol{
    func onCharacterSelected(character: Character) {
        CharacterDetailRouter().goToCharacterDetail(character: character, navigationController: self.navigationController)
    }
}
