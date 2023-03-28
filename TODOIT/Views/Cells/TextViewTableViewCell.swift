//
//  TextViewTableViewCell.swift
//  TODOIT
//
//  Created by alekseienko on 17.03.2023.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    
    var textView: UITextView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configTextView() {
        self.textView = UITextView()
        self.textView.textAlignment = .left
        self.textView.isScrollEnabled = false
        self.textView.font = UIFont.preferredFont(forTextStyle: .body)
        self.textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.textView.textColor = UIColor.lightGray
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 1
        self.textView.layer.cornerRadius = 12
        self.contentView.addSubview(self.textView)
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }
}
