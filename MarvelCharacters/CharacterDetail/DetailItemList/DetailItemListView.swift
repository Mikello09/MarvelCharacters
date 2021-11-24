//
//  DetailItemListView.swift
//  MarvelCharacters
//
//  Created by Mikel on 24/11/21.
//

import Foundation
import UIKit

enum DetailType: String{
    case comics = "Comics"
    case stories = "Stories"
    case series = "Series"
    case events = "Events"
}

class DetailItemListView: UIView{
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var detailItemTitle: UILabel!
    @IBOutlet weak var detailItemCollection: UICollectionView!
    @IBOutlet weak var noDataLbel: UILabel!
    
    var detailData: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private lazy var gridModeLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.minimumLineSpacing = 0
        collectionFlowLayout.scrollDirection = .horizontal
        return collectionFlowLayout
    }()
    
    func configure(detailType: DetailType, data: [String]){
        detailItemTitle.text = detailType.rawValue
        
        if data.count > 0 {
            self.detailData = data
            
            detailItemCollection.delegate = self
            detailItemCollection.dataSource = self
            detailItemCollection.register(UINib(nibName: "DetailItemCell", bundle: nil), forCellWithReuseIdentifier: "detailItem")
            detailItemCollection.collectionViewLayout = gridModeLayout
            
            
            detailItemCollection.reloadData()
        } else {
            detailItemCollection.isHidden = true
            noDataLbel.text = "No data for \(detailType.rawValue)"
            noDataLbel.isHidden = false
        }
    }
    
}

extension DetailItemListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailItem", for: indexPath) as! DetailItemCell
        cell.configure(detailTitle: self.detailData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
}



extension DetailItemListView{
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
