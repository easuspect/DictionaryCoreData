//
//  UpdateWordViewController.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/14/22.
//

import UIKit

class UpdateWordViewController: UIViewController {
    
    
    lazy var updateNameLabel = UILabel()
    lazy var updateMeaningLabel = UILabel()
    private lazy var updateWordTextField = UITextField()
    private lazy var updateDoneButton = UIButton()
    
    
    private let database: DatabaseProtocol
    
   // var didAddNewWord: ((Word) -> Void)?
    
    init(database: DatabaseProtocol) {
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension UpdateWordViewController {
    
    func setupLayout() {
        
        view.backgroundColor = .white
        
        view.addSubview(updateNameLabel)
        view.addSubview(updateMeaningLabel)
        view.addSubview(updateWordTextField)
        view.addSubview(updateDoneButton)
        updateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        updateMeaningLabel.translatesAutoresizingMaskIntoConstraints = false
        updateWordTextField.translatesAutoresizingMaskIntoConstraints = false
        updateDoneButton.translatesAutoresizingMaskIntoConstraints = false
        
        let updateButton = UIBarButtonItem.init(title: "Update",
                                                style: .plain,
                                                target: self,
                                                action: #selector(DidClickUpdateButton))
        navigationItem.rightBarButtonItem = updateButton
        
        updateDoneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        
        updateDoneButton.backgroundColor = .blue
        updateDoneButton.titleLabel?.textColor = .black
        updateDoneButton.setTitle("Done", for: UIControl.State.normal)
        
        
        NSLayoutConstraint.activate([
            updateNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            updateNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            updateNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            updateNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            updateMeaningLabel.leadingAnchor.constraint(equalTo: updateNameLabel.leadingAnchor),
            updateMeaningLabel.trailingAnchor.constraint(equalTo: updateNameLabel.trailingAnchor),
            updateMeaningLabel.topAnchor.constraint(equalTo: updateNameLabel.bottomAnchor, constant: 20),
            updateMeaningLabel.heightAnchor.constraint(equalToConstant: 50),
            
            updateWordTextField.leadingAnchor.constraint(equalTo: updateMeaningLabel.leadingAnchor),
            updateWordTextField.trailingAnchor.constraint(equalTo: updateMeaningLabel.trailingAnchor),
            updateWordTextField.topAnchor.constraint(equalTo: updateMeaningLabel.bottomAnchor, constant: 20),
            updateWordTextField.heightAnchor.constraint(equalToConstant: 70),
            
            updateDoneButton.leadingAnchor.constraint(equalTo: updateWordTextField.leadingAnchor),
            updateDoneButton.topAnchor.constraint(equalTo: updateWordTextField.bottomAnchor, constant: 20),
            updateDoneButton.heightAnchor.constraint(equalToConstant: 50),
            updateDoneButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension UpdateWordViewController {
    @objc func DidClickUpdateButton() {
        updateWordTextField.isHidden = false
        updateDoneButton.isHidden = false
        updateWordTextField.backgroundColor = .lightGray
        
    }
    
    @objc
    func doneButtonPressed() {
        updateMeaningLabel.text = updateWordTextField.text
        
    }
    
    
}

