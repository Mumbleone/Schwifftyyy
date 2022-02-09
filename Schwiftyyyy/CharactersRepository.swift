//
//  CharactersRepository.swift
//  Schwiftyyyy
//
//  Created by Adrian Devezin on 4/5/21.
//

import Foundation
import Combine

protocol CharactersRepository {
    func getCharacters() -> AnyPublisher<CharacterResponse, Error>
}

class CharactersRepositoryImpl: CharactersRepository {
    func getCharacters() -> AnyPublisher<CharacterResponse, Error> {
        CharactersApi.getCharacters()
    }
}
