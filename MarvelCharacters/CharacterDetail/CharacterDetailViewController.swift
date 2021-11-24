//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit


class CharacterDetailViewController: UIViewController{
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTitleView: UIView!
    @IBOutlet weak var characterTitle: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var comicsView: DetailItemListView!
    @IBOutlet weak var storiesView: DetailItemListView!
    @IBOutlet weak var seriesView: DetailItemListView!
    @IBOutlet weak var eventsView: DetailItemListView!
    
    
    var presenter: CharacterDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.getCharacterDetail()
    }
    
    func configureUI(){
        characterTitleView.layer.cornerRadius = 4
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CharacterDetailViewController: CharacterDetailPresenterProtocol{
    func characterDetail(character: Character) {
        characterTitle.text = character.name
        DispatchQueue.global(qos: .background).async {
            ImageManager().getImage(path: character.thumbnail?.path ?? "", variant: .landscapeXLarge, imageExtension: character.thumbnail?.extension ?? ""){ characterImage in
                DispatchQueue.main.async {
                    self.characterImage.image = characterImage
                }
            }
        }
        characterDescription.text = character.description
        comicsView.configure(detailType: .comics, data: character.comics?.items?.compactMap({$0.name}) ?? [])
        storiesView.configure(detailType: .stories, data: character.stories?.items?.compactMap({$0.name}) ?? [])
        seriesView.configure(detailType: .series, data: character.series?.items?.compactMap({$0.name}) ?? [])
        eventsView.configure(detailType: .events, data: character.events?.items?.compactMap({$0.name}) ?? [])
    }
}
