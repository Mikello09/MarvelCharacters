//
//  BaseWorker.swift
//  MarvelCharacters
//
//  Created by Mikel on 22/11/21.
//

import Foundation
import UIKit
import CommonCrypto

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
}

enum ErrorCode: String{
    case general = "An error ocurred"
    case missingKeys = "Missing API Keys"
    case invalidHash = "Invalid hash"
    case methodNotAllowed = "Method not allowed"
    case forbidden = "Forbidden"
    
    func getMessage() -> String{
        switch self {
            case .general: return "Something went wrong"
            case .missingKeys: return "Please configure missing keys"
            case .invalidHash: return "The hash value is wrong"
            case .methodNotAllowed: return "The method is not allowed"
            case .forbidden: return "Forbidden"
        }
    }
}

class BaseWorker: NSObject{
    
    let TIME_OUT: Double = 600//10 minutes
    
    let public_key = ""//INSERT PUBLIC_KEY
    let private_key = ""//INSERT PRIVATE_KEY
    let baseURL = "https://gateway.marvel.com:443"
    
    func getUrlSession() -> URLSession{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TIME_OUT
        sessionConfig.timeoutIntervalForResource = TIME_OUT
        return URLSession(configuration: sessionConfig)
    }
    
    func getUrlRequest(url: String, method: HttpMethod, params: [String:Any] = [:], isImage: Data? = nil) -> URLRequest?{
        guard let requestURL = URL(string: url + getAuthenticationString()) else {
            return nil
        }
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    func getAuthenticationString() -> String{
        if !public_key.isEmpty && !private_key.isEmpty{
            let ts = "1"
            let hash = MD5(string: ts + private_key + public_key).map { String(format: "%02hhx", $0) }.joined()
            return "?ts=\(ts)&apikey=\(public_key)&hash=\(hash)"
        } else {
            return ""
        }
    }
    
    func processResponse(statusCode: Int, completion: @escaping(_ : Bool,_ : ErrorCode?) -> ()){
        switch statusCode{
            case 200:
                completion(true,nil)
            case 409:
                completion(false, .missingKeys)
            case 401:
                completion(false, .invalidHash)
            case 405:
                completion(false, .methodNotAllowed)
            case 403:
                completion(false, .forbidden)
            default:
                completion(false, .general)
            }
    }
    
    func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }

}
