//
//  DatePikerTableViewCell.swift
//  TODOIT
//
//  Created by alekseienko on 18.03.2023.
//

import UIKit

class DatePikerTableViewCell: UITableViewCell {
    
    var datePiker: UIDatePicker!
    static let height: CGFloat = 400

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configDatePiker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configDatePiker() {
        self.datePiker = UIDatePicker()
        self.datePiker.calendar = .autoupdatingCurrent
        self.datePiker.preferredDatePickerStyle = .inline
        self.contentView.addSubview(self.datePiker)
        
        self.datePiker.translatesAutoresizingMaskIntoConstraints = false
        self.datePiker.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        self.datePiker.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.datePiker.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        self.datePiker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }
}
