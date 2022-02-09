//
//  CharacterResponse.swift
//  Schwiftyyyy
//
//  Created by Adrian Devezin on 4/5/21.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
