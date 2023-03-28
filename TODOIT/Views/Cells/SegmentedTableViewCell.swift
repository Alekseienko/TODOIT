//
//  SegmentedTableViewCell.swift
//  TODOIT
//
//  Created by alekseienko on 17.03.2023.
//

import UIKit

class SegmentedTableViewCell: UITableViewCell {

    var label: UILabel!
    var segment: UISegmentedControl!
    static let height: CGFloat = 50

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configLabel()
        configSegment()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLabel() {
        self.label = UILabel()
        self.label.text = "Важливо"
        self.label.font = UIFont.preferredFont(forTextStyle: .headline)
        self.contentView.addSubview(self.label)
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
    }
    
    private func configSegment() {
        let items = ["Ні","!","!!","!!!"]
        self.segment = UISegmentedControl(items: items)
        self.segment.selectedSegmentIndex = 0
        self.segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        self.contentView.addSubview(self.segment)
        
        self.segment.translatesAutoresizingMaskIntoConstraints = false
        self.segment.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.segment.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20).isActive = true
    }
}
