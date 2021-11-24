//
//  ImageManager.swift
//  MarvelCharacters
//
//  Created by Mikel on 23/11/21.
//

import Foundation
import UIKit


enum ImageVariant: String{
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXLarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
    
    case standardSmall = "standard_small"
    case standardMedium = "standard_medium"
    case standardLarge = "standard_large"
    case standardXLarge = "standard_xlarge"
    case standardFantastic = "standard_fantastic"
    case standardAmazing = "standard_amazing"
    
    case landscapeSmall = "landscape_small"
    case landscapeMedium = "landscape_medium"
    case landscapeLarge = "landscape_large"
    case landscapeXLarge = "landscape_xlarge"
    case landscapeAmazaing = "landscape_amazing"
    case landscapeIncredible = "landscape_incredible"
}

class ImageManager{
    
    func constructImagePath(path: String, variant: ImageVariant, imageExtension: String) -> String{
        return path + "/" + variant.rawValue + "." + imageExtension
    }
    
    func getImage(path: String, variant: ImageVariant, imageExtension: String, completion: @escaping((_ : UIImage?) -> ())){
        if let imageURL = URL(string: constructImagePath(path: path, variant: variant, imageExtension: imageExtension)){
            ImageCache.shared.getCachedImage(url: imageURL){ returnedImage in
                completion(returnedImage)
            }
        } else {
            completion(nil)
        }
    }
    
}

class ImageCache{
    
    static let shared: ImageCache = ImageCache()
    let cache = NSCache<NSString,UIImage>()
    
    private let concurrentCacheQueue = DispatchQueue(label: "imageCacheQueue", attributes: .concurrent)
    
    func getCachedImage(url: URL, completion: @escaping(_ image: UIImage?) -> ()){
        
        concurrentCacheQueue.async(flags: .barrier) { [weak self] in
            
            guard let self = self else { return }
            
            
            if let cachedImage = self.cache.object(forKey: NSString(string: url.path)){
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            } else {
                DispatchQueue.global(qos: .background).async {
                    do {
                        if
                            let imageData = try? Data(contentsOf: url),
                            let imageToSave = UIImage(data: imageData){
                            self.cache.setObject(imageToSave, forKey: NSString(string: url.path))
                            DispatchQueue.main.async {
                                completion(imageToSave)
                            }
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                }
                
            }
        
        }
    }
}
