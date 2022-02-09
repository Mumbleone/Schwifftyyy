//
//  CharacterViewCell.swift
//  Schwiftyyyy
//
//  Created by Adrian Devezin on 4/5/21.
//

import Foundation
import UIKit
import SDWebImage

class CharacterViewCell: UITableViewCell {
    
    static let Identifier = "CharacterViewCell"
    private var characterImage: UIImageView!
    private var characterName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        createView()
    }
    
    private func createView() {
        createCharacterImage()
        createName()
    }
    
    private func createCharacterImage() {
        characterImage = UIImageView()
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(characterImage)
        
        characterImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor).isActive = true
        
        characterImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: characterImage.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor).isActive = true
    }
    
    private func createName() {
        characterName = UILabel()
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.textColor = UIColor.black
        characterName.numberOfLines = 0
        
        contentView.addSubview(characterName)
        
        let imageLayoutGuide = UILayoutGuide()
        contentView.addLayoutGuide(imageLayoutGuide)
        
        imageLayoutGuide.trailingAnchor.constraint(equalTo: characterImage.trailingAnchor).isActive = true
        
        characterName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        characterName.leadingAnchor.constraint(equalTo: imageLayoutGuide.trailingAnchor, constant: 8).isActive = true
        characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func setCharacter(character: Character) {
        characterName.text = character.name
        if let url = URL(string: character.image) {
            characterImage.sd_setImage(with: url)
        }
    }
}
