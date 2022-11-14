//
//  WordListViewController.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/7/22.
//

import UIKit

class WordListViewController: UIViewController {
    
    private let database: DatabaseProtocol

    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(WordTableViewCell.self, forCellReuseIdentifier: "WordTableViewCell")
        return table
    }()
    
    var wordList: [Word] = []

    init(database: DatabaseProtocol) {
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        fetchWords()
    }
}

private extension WordListViewController {
    func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(didClickAddButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func didClickAddButton() {
        navigateToAddNewWord()
    }
    
    func navigateToAddNewWord() {
        let addWordVC = AddNewWordViewController(database: database)
        addWordVC.didAddNewWord = { [weak self] newWord in
            self?.wordList.append(newWord)
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(addWordVC, animated: true)
    }
    
    func fetchWords() {
        self.wordList = database.fetch()
        tableView.reloadData()
    }
}

extension WordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateWordVC = UpdateWordViewController(database: database)
        updateWordVC.updateNameLabel.text = wordList[indexPath.row].name
        updateWordVC.updateMeaningLabel.text = wordList[indexPath.row].meaning
        
        navigationController?.pushViewController(updateWordVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            database.delete(word: wordList[indexPath.row])
            wordList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}

extension WordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as? WordTableViewCell else {
            fatalError("Couldn`t find WordTableViewCell")
        }
        cell.configure(with: wordList[indexPath.row])
        
        return cell
    }
}





