//
//  CharacterService+TargetType.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import Moya



extension CharacterService: TargetType {
    
    var baseURL: URL {
        URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    var path: String {
        "characters"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        var parameters: [String : Any] = AuthHelper.createQueryParameters()
        switch self {
        case .getCharacters(let offset):
            parameters["offset"] = offset
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        [:]
    }
}
