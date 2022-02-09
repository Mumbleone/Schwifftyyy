//
//  CharactersSource.swift
//  Schwiftyyyy
//
//  Created by Adrian Devezin on 4/5/21.
//

import Foundation
import Combine

enum CharactersApi {
    static let client = ApiClient()
}

extension CharactersApi {
    
    static func getCharacters() -> AnyPublisher<CharacterResponse, Error> {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character"),let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLCompoents for getCategories")
        }
        let request = URLRequest(url: components.url!)
        return client.run(request)
            .map(\.value)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

