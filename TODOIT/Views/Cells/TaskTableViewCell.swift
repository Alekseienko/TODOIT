//
//  TaskTableViewCell.swift
//  TODOIT
//
//  Created by alekseienko on 22.03.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var button: UIButton!
    var taskLabel: UILabel!
    var dateLabel: UILabel!
    var stackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configButton()
        configTaskLabel()
        configDateLabel()
        configStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButton() {
        self.button = UIButton()
        self.button.backgroundColor = .systemBackground
        self.button.layer.borderWidth = 1
        self.button.layer.cornerRadius = 15
        self.contentView.addSubview(self.button)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func configTaskLabel() {
        self.taskLabel = UILabel()
    }
    
    private func configDateLabel() {
        self.dateLabel = UILabel()
        self.dateLabel.font = UIFont.preferredFont(forTextStyle: .headline).withSize(12)
        self.dateLabel.textColor = UIColor.systemBlue
    }
    
    private func configStackView() {
        self.stackView = UIStackView(arrangedSubviews: [taskLabel,dateLabel])
        self.stackView.spacing = 4
        self.stackView.axis = .vertical
        self.stackView.distribution = .fill
        self.stackView.alignment = .leading
        self.contentView.addSubview(self.stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.button.rightAnchor,constant: 20).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -30).isActive = true
    }
}

extension TaskTableViewCell {
    
    public func config(with task: Task) {
        configDate(with: task)
        var exclamationMark = ""
        if task.isDone {
            setIsDone()
        } else {
            exclamationMark = getPriority(with: task)
        }
        setAttributedString(with: task, exclamationMark: exclamationMark)
    }
    
    private func configDate(with task: Task) {
        if let date = task.date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .autoupdatingCurrent
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = nil
        }
    }
    
    private func setIsDone() {
        button.layer.borderWidth = 0
        button.backgroundColor = .systemGreen
        let iconImage = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(iconImage, for: .normal)
    }
    
    private func getPriority(with task: Task) -> String {
        
        var exclamationMark = ""
        button.setImage(nil, for: .normal)
        button.layer.borderWidth = 1
        
        switch task.priority {
        case 0:
            button.backgroundColor = UIColor.systemBackground
            button.layer.borderColor = UIColor.systemGray3.cgColor
        case 1:
            exclamationMark = "! "
            button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
            button.layer.borderColor = UIColor.systemRed.cgColor
        case 2:
            exclamationMark = "!! "
            button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.3)
            button.layer.borderColor = UIColor.systemRed.cgColor
        case 3: exclamationMark = "!!! "
            button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
            button.layer.borderColor = UIColor.systemRed.cgColor
        default:
            break
        }
        return exclamationMark
    }
    
    private func setAttributedString(with task: Task, exclamationMark: String) {
        let fullText = exclamationMark + (task.name ?? "")
        let range = (fullText as NSString).range(of: exclamationMark)
        let mutableAttributedString = NSMutableAttributedString.init(string: fullText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        let myAttribute = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ]
        mutableAttributedString.addAttributes(myAttribute, range: range)
        taskLabel.attributedText = mutableAttributedString
    }
}
