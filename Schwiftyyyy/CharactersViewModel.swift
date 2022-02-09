//
//  CharactersViewModel.swift
//  Schwiftyyyy
//
//  Created by Adrian Devezin on 4/5/21.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    
    private let repo = CharactersRepositoryImpl()
    private var cancellables: [AnyCancellable] = []
    
    @Published
    var viewState: ViewState = .loading
    
    // Create the view state enum here
    
    enum ViewState {
        case loading
        case characters([Character])
    }
    
    init() {
        let cancel = repo.getCharacters().mapError({ (error) -> Error in
            print(error)
            return error
        }).sink(receiveCompletion: {_ in }, receiveValue: { response in
            self.displayCharacters(characters: response.results)
        })
        cancellables.append(cancel)
    }
    
    // Create the displayCharacters function here
    func displayCharacters(characters: [Character]) {
      viewState = .characters(characters)
    }
}
