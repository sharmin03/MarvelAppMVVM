//
//  AuthHelper.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import Moya
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
 
struct AuthHelper {
    private init() {}
    
    private static let publicKey = "bb0350ecbc64d5779f5572b19fd35d29"
    private static let privateKey = "24fccf70e4270b8c70058d12b18e0141d73cceef"
    
    static func createQueryParameters() -> [String:Any] {
        let ts = "\(Int64(Date().timeIntervalSince1970))"
        let payload = ts + privateKey + publicKey
        let hashData = MD5(string: payload)
        let hash = hashData.map { String(format: "%02hhx", $0) }.joined()
        
        return [
            "ts" : ts,
            "apikey" : publicKey,
            "hash": hash
        ]
    }
    
    
    private static func MD5(string: String) -> Data {
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
    
}
