//
//  WordListViewController.swift
//  DictionaryCoreData
//
//  Created by NewMac on 11/7/22.
//

import UIKit

class WordListViewController: UIViewController {
    
    private let coreDataManager: CoreDataManager
    
    var wordList: [Word] = []

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
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
    }
    
    func fetchWords() {
        self.wordList = coreDataManager.fetch()
    }
}
