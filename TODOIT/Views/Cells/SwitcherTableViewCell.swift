//
//  SwitcherTableViewCell.swift
//  TODOIT
//
//  Created by alekseienko on 18.03.2023.
//

import UIKit

class SwitcherTableViewCell: UITableViewCell {

    var label: UILabel!
    var switcher: UISwitch!
    static let height: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configLabel()
        configSwitcher()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLabel() {
        self.label = UILabel()
        self.label.text = "Зробити до"
        self.label.font = UIFont.preferredFont(forTextStyle: .headline)
        self.contentView.addSubview(self.label)
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
    }
    
    private func configSwitcher() {
        self.switcher = UISwitch()
        self.contentView.addSubview(self.switcher)
        
        self.switcher.translatesAutoresizingMaskIntoConstraints = false
        self.switcher.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.switcher.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20).isActive = true
    }
}
