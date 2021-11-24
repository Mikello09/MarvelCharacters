//
//  CharacterListWorker.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit

protocol CharacterListWorkerProtocol{
    func success(characterList: [Character])
    func fail(error: ErrorCode)
}

class CharacterListWorker: BaseWorker{
    
    let characterListURL = "/v1/public/characters"
    
    var delegate: CharacterListWorkerProtocol?
    
    
    func getCharacterList(delegate: CharacterListWorkerProtocol){
        self.delegate = delegate
        
        let session = getUrlSession()
        guard let request = getUrlRequest(url: baseURL + characterListURL, method: .get) else {
            self.delegate?.fail(error: .general)
            return
        }
        
        print("\(String(describing: request.url))")
        var dataTask: URLSessionDataTask?
        dataTask = session.dataTask(with: request){ data, response, error in
            defer{dataTask = nil}
                if let httpResponse = response as? HTTPURLResponse,
                   error == nil,
                   let data = data{
                    self.processResponse(statusCode: httpResponse.statusCode){ resultSuccess, error in
                        do {
                            if resultSuccess{
                                let charactersObject = try self.newJSONDecoder().decode(CharacterObject.self, from: data)
                                self.delegate?.success(characterList: charactersObject.data.results)
                            } else {
                                self.delegate?.fail(error: error ?? .general)
                            }
                        } catch {
                            self.delegate?.fail(error: .general)
                        }
                    }
                } else {
                    self.delegate?.fail(error: .general)
                }
        }
        dataTask?.resume()
    }
    
}
