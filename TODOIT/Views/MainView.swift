//
//  MainView.swift
//  TODOIT
//
//  Created by alekseienko on 27.03.2023.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Property
    
    var tableView: UITableView!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Configuration

extension MainView {
    
    private func config() {
        configTableView()
        configAddButton()
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
    
    private func configAddButton() {
        self.button = UIButton(type: .custom)
        let image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withRenderingMode(.alwaysTemplate)
        self.button.setImage(image, for: .normal)
        self.button.tintColor = UIColor.white
        self.button.backgroundColor = UIColor.systemBlue
        self.button.layer.cornerRadius = 30
        self.button.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.button.layer.shadowOpacity = 0.4
        self.button.layer.shadowColor = UIColor.systemBlue.cgColor
        self.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
