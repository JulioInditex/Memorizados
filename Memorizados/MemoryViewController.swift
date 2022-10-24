//
//  MemoryViewController.swift
//  Memorizados
//
//  Created by Julio Rodríguez on 20/10/22.
//

import Foundation
import UIKit

protocol MemoryViewControllerProtocol {
    func saveItem(memoryItem: MemoryItem)
}

class MemoryViewController: UIViewController {
    private var item: MemoryItem? {
        didSet {
            updateMemoryItemView()
        }
    }
    private let textView = UITextView()
    private var blanksRevealed = Int.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 20),
            view.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20)
        ])
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = .systemFont(ofSize: 20)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textViewTapped))
        textView.addGestureRecognizer(tapGesture)
    }
    
    private func updateMemoryItemView() {
        guard let memoryItem = item else {
            return
        }

        self.title = memoryItem.title
        textView.text = item?.textToShow(blanksRevealed: blanksRevealed) ?? ""
    }
    
    @objc
    func textViewTapped() {
        guard blanksRevealed != item?.itemSplitedBySpaces.count else {
            return
        }
        
        blanksRevealed += 1
        updateMemoryItemView()
    }
}

// MARK: MemoryViewControllerProtocol
extension MemoryViewController: MemoryViewControllerProtocol {
    func saveItem(memoryItem: MemoryItem) {
        self.item = memoryItem
    }
}
