//
//  WordTableViewCell.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/9/22.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    private lazy var nameLabel = UILabel()
    private lazy var meaningLabel = UILabel()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with word: Word) {
        nameLabel.text = word.name
        meaningLabel.text = word.meaning
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        meaningLabel.text = nil
    }
}

extension WordTableViewCell {
    func setupLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(meaningLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            meaningLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            meaningLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            meaningLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            meaningLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        
    }
}
