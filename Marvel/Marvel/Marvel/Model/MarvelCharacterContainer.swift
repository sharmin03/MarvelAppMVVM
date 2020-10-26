//
//  MarvelCharacterContainer.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation

//also confirm to Decodable

struct MarvelCharacterContainer {
    let characters: [MarvelCharacter]
}

extension MarvelCharacterContainer: Decodable {
    
    init(from decoder: Decoder) throws {
        let characterDataWrapper = try decoder.container(keyedBy: CharacterDataWrapperKeys.self)
        let characterDataContainer = try characterDataWrapper.nestedContainer(keyedBy: CharacterDataContainerKeys.self, forKey: .data)
        characters = try characterDataContainer.decode([MarvelCharacter].self, forKey: .results)
    }
    
    enum CharacterDataWrapperKeys: String, CodingKey {
        case data
    }
    
    enum CharacterDataContainerKeys: String, CodingKey {
        case results
    }
}
