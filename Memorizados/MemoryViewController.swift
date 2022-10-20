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
    private var memoryItem: MemoryItem? {
        didSet {
            if let memoryItem = memoryItem {
                textView.text = memoryItem.title + "\n" + memoryItem.text
            }
        }
    }
    private let textView = UITextView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
        textView.isEditable = false
    }
}

extension MemoryViewController: MemoryViewControllerProtocol {
    func saveItem(memoryItem: MemoryItem) {
        self.memoryItem = memoryItem
    }
}
