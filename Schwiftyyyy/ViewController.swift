//
//  ViewController.swift
//  Schwiftyyyy
//
//  Created by Adrian Devezin on 4/5/21.
//

import UIKit
import Combine

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    private var characters: [Character] = []
    private var cancellables : [AnyCancellable] = []
    private var activityView: UIActivityIndicatorView?
    private let viewModel = CharactersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        let cancellable = viewModel.$viewState.sink(receiveValue: { viewState  in
            switch viewState {
            
            case .loading:
                self.showActivityIndicator()
            case let .characters(data):
                self.setData(character: data)
            }
        })
        cancellables.append(cancellable)
    }
    
    
    private func setData(character: [Character]) {
        hideActivityIndicator()
        characters = character
        tableView.reloadData()
    }
    
    private func createView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.Identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func showActivityIndicator() {
        if activityView == nil {
            activityView = UIActivityIndicatorView(style: .large)
            activityView?.center = self.view.center
            activityView?.layer.cornerRadius = 8
            activityView?.backgroundColor = UIColor.black
            activityView?.hidesWhenStopped = true
            activityView?.alpha = 0.8
            view.addSubview(activityView!)
            activityView?.translatesAutoresizingMaskIntoConstraints = false
            activityView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            activityView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            activityView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            activityView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        activityView?.startAnimating()
    }
    
    private func hideActivityIndicator() {
        if (activityView != nil) {
            activityView?.stopAnimating()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.Identifier, for: indexPath) as? CharacterViewCell else {
            fatalError()
        }
        
        let character = characters[indexPath.row]
        cell.setCharacter(character: character)
        return cell
    }
}

