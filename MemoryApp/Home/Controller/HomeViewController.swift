//
//  HomeViewController.swift
//  MemoryApp
//
//  Created by Nikolas Aggelidis on 23/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var memoryItemsArray = [MemoryItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMemoryItems()
    }
    
    private func loadMemoryItems() {
        guard let url = Bundle.main.url(forResource: "MemoryItems", withExtension: "json") else { fatalError("Can't find JSON file to load data.") }
        guard let data = try? Data(contentsOf: url) else { fatalError("Unable to load JSON file.") }
        let jsonDecoder = JSONDecoder()
        guard let savedMemoryItems = try? jsonDecoder.decode([MemoryItem].self, from: data) else { fatalError("Failed to decode JSON file.") }
        
        memoryItemsArray = savedMemoryItems
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = memoryItemsArray[indexPath.row].title
        cell.detailTextLabel?.text = memoryItemsArray[indexPath.row].text
        
        return cell
    }
}
