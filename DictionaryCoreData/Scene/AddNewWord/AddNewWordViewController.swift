//
//  AddNewWordViewController.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/9/22.
//

import UIKit

class AddNewWordViewController: UIViewController {
    
    private lazy var nameTextField = makeTextField(placeHolder: "Enter the Word")
    private lazy var meaningTextField = makeTextField(placeHolder: "Enter the Meaning")
    private let database: DatabaseProtocol
 
    var didAddNewWord: ((Word) -> Void)?
    
    init(database: DatabaseProtocol) {
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
}

private extension AddNewWordViewController {
    
    func setupLayout() {
        view.backgroundColor = .white
        
        let addButton = UIBarButtonItem.init(title: "Save",
                                             style: .plain,
                                             target: self,
                                             action: #selector(didClickSaveButton))
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(nameTextField)
        view.addSubview(meaningTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        meaningTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            meaningTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            meaningTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            meaningTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            meaningTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func didClickSaveButton() {
        guard let name = nameTextField.text, !name.isEmpty else {
            
            print("Name field con not be Empty")
            return }
    
    guard let meaning = meaningTextField.text, !meaning.isEmpty else {
            print("Meaning field con not be Empty")
            return }
        
        let newWord = database.insert(name: name, meaning: meaning)
        didAddNewWord?(newWord)
        navigationController?.popViewController(animated: true)
    }
}

    func makeTextField(placeHolder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = placeHolder
        return textField
    }
 






