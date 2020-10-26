//
//  CharacterDataContainer.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation

struct MarvelCharacter: Equatable, Decodable {
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        let imageContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .thumbnail)
        var string = try imageContainer.decode(String.self, forKey: .path)
        string = string.replacingOccurrences(of: "http", with: "https")
        string += "."
        string += try imageContainer.decode(String.self, forKey: .ext)
        thumbnail = string
    }

    enum CharacterKeys: String, CodingKey {
        case id, name, description, thumbnail
    }

    enum ImageKeys: String, CodingKey {
        case path, ext = "extension"
    }
}

extension MarvelCharacter: Identifiable {}
