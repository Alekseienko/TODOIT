//
//  DetailView.swift
//  TODOIT
//
//  Created by alekseienko on 27.03.2023.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Property
    
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Configuration

extension DetailView {
    
    private func config() {
        self.backgroundColor = UIColor.systemBackground
        configTableView()
    }
    
    private func configTableView() {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
