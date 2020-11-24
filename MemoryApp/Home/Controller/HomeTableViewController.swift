//
//  HomeTableViewController.swift
//  MemoryApp
//
//  Created by Nikolas Aggelidis on 23/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let dataSource = MemoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
    }
}

extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let memoryItemDetailsViewController = UIStoryboard(name: "MemoryItemDetails", bundle: nil).instantiateViewController(identifier: "MemoryItemDetailsViewController") as? MemoryItemDetailsViewController else { fatalError("Unable to instantiate MemoryItemDetailsViewController.") }
        memoryItemDetailsViewController.memoryItem = dataSource.memoryItem(at: indexPath.row)
        
        navigationController?.pushViewController(memoryItemDetailsViewController, animated: true)
    }
}
