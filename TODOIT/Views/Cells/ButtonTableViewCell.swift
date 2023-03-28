//
//  ButtonTableViewCell.swift
//  TODOIT
//
//  Created by alekseienko on 20.03.2023.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var button: UIButton!
    static let height: CGFloat = 50

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButton() {
        self.button = UIButton()
        self.button.setTitle("Видалити", for: .normal)
        self.button.setTitleColor(UIColor.systemRed, for: .normal)
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.button.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
    }
}
