//
//  ViewController.swift
//  Memorizados
//
//  Created by Julio Rodríguez on 20/10/22.
//

import UIKit

class ViewController: UIViewController {
    private var memoryItems: [MemoryItem] = []
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let url = Bundle.main.url(forResource: "MemoryItems", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let memoryItems = try? JSONDecoder().decode([MemoryItem].self, from: data) {
            self.memoryItems = memoryItems
        }
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
    }
}
