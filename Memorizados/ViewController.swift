//
//  ViewController.swift
//  Memorizados
//
//  Created by Julio Rodríguez on 20/10/22.
//

import UIKit

protocol MemoryItemsRepository {
    func getItems(from fileName: String) throws -> [MemoryItem]
}

class ViewController: UIViewController {
    private var memoryItems: [MemoryItem] = []
    private let cellIdentifier = "CellIdentifier"
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.memoryItems = (try? getItems(from: "MemoryItems")) ?? []
    }
}

// MARK: MemoryItemsRepository
extension ViewController: MemoryItemsRepository {
    func getItems(from fileName: String) throws -> [MemoryItem] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return []
        }
        let data = try Data(contentsOf: url)
        let memoryItems = try JSONDecoder().decode([MemoryItem].self, from: data)
        return memoryItems
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = memoryItems[indexPath.row]
        let viewController = MemoryViewController()
        viewController.saveItem(memoryItem: item)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let item = memoryItems[indexPath.row]
        cell.detailTextLabel?.text = item.text
        cell.detailTextLabel?.numberOfLines = .zero
        cell.textLabel?.text = item.title
        return cell
    }
}
