//
//  DetailVCDataSourse.swift
//  TODOIT
//
//  Created by alekseienko on 27.03.2023.
//

import UIKit

class DetailVCDataSourse: NSObject {
    
    // MARK: - Property
    private weak var viewController: DetailVC!
    private var textViewHeight: CGFloat = 62
    
    init(viewController: DetailVC) {
        self.viewController = viewController
    }
}

    // MARK: - UITableViewDataSource

extension DetailVCDataSourse: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.viewController.isDedline ? CellType.allCases.count : 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = CellType(rawValue: indexPath.row) else { fatalError() }
        
        if indexPath.section == 0 {
            return createTextViewTableViewCell(tableView: tableView)
        } else if indexPath.section == 1 {
            switch cellType {
            case .segmented: return createSegmentedTableViewCell(tableView: tableView)
            case .switcher: return createSwitcherTableViewCell(tableView: tableView)
            case .date: return createDatePikerTableViewCell(tableView: tableView)
            }
        } else {
            return createButtonTableViewCell(tableView: tableView)
        }
    }
}

// MARK: - Create cells

extension DetailVCDataSourse {
    
    private func createTextViewTableViewCell(tableView: UITableView) -> UITableViewCell {
        let id = String(describing: type(of: TextViewTableViewCell.self))
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? TextViewTableViewCell
        if cell == nil {
            cell = TextViewTableViewCell(style: .default, reuseIdentifier: id)
            cell?.textView.delegate = self
        }
        if let name = self.viewController.task.name, !name.isEmpty {
            cell?.textView.text = self.viewController.task.name
            cell?.textView.textColor = UIColor.label
        } else {
            cell?.textView.textColor = UIColor.lightGray
            cell?.textView.text = "Що треба зробити?"
        }
        addDoneButtonOnKeyboard(textView: (cell?.textView)!)
        return cell!
    }
    
    func addDoneButtonOnKeyboard(textView: UITextView){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        textView.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.viewController.detailView.tableView.endEditing(true)
    }
    
    private func createSegmentedTableViewCell(tableView: UITableView) -> UITableViewCell {
        let id = String(describing: type(of: SegmentedTableViewCell.self))
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? SegmentedTableViewCell
        if cell == nil {
            cell = SegmentedTableViewCell(style: .default, reuseIdentifier: id)
            cell?.segment.addTarget(self, action: #selector(setPriority), for: .valueChanged)
        }
        cell?.segment.selectedSegmentIndex = Int(self.viewController.task.priority)
        return cell!
    }
    
    @objc private func setPriority(sender: UISegmentedControl) {
        self.viewController.task.priority = Int16(sender.selectedSegmentIndex)
    }
    
    private func createSwitcherTableViewCell(tableView: UITableView) -> UITableViewCell {
        let id = String(describing: type(of: SwitcherTableViewCell.self))
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? SwitcherTableViewCell
        if cell == nil {
            cell = SwitcherTableViewCell(style: .default, reuseIdentifier: id)
            cell?.switcher.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        }
        cell?.switcher.isOn = self.viewController.isDedline
        return cell!
    }
    
    private func createDatePikerTableViewCell(tableView: UITableView) -> UITableViewCell {
        let id = String(describing: type(of: DatePikerTableViewCell.self))
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? DatePikerTableViewCell
        if cell == nil {
            cell = DatePikerTableViewCell(style: .default, reuseIdentifier: id)
            cell?.datePiker.addTarget(self, action: #selector(setUpDate), for: .valueChanged)
        }
        if let date = self.viewController.task.date {
            cell?.datePiker.date = date
        }
        return cell!
    }
    
    @objc private func setUpDate(sender: UIDatePicker) {
        
        if sender.date < Date() {
                sender.tintColor = .red
            let alert = UIAlertController(title: "Увага!", message: "Неможливо обрати минулу дату!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Зрозуміло", style: .default) { action in
                sender.tintColor = .tintColor
                sender.setDate(Date(), animated: true)
            }
            alert.addAction(okAction)
            self.viewController.present(alert, animated: true)
        } else {
            sender.tintColor = .tintColor
        }
    }
    
    private func createButtonTableViewCell(tableView: UITableView) -> UITableViewCell {
        let id = String(describing: type(of: ButtonTableViewCell.self))
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? ButtonTableViewCell
        if cell == nil {
            cell = ButtonTableViewCell(style: .default, reuseIdentifier: id)
        }
        cell?.button.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
        return cell!
    }
    
    @objc private func deleteTask() {
        NotificationManager.shared.deletekNotification(for: self.viewController.task)
        CoreDataManager.shared.deleteObject(object: self.viewController.task)
        self.viewController.dismiss(animated: true)
    }
    
    @objc private func valueChanged(sender: UISwitch) {
    
        self.viewController.isDedline = sender.isOn
        
        if self.viewController.isDedline == false {
            NotificationManager.shared.deletekNotification(for: self.viewController.task)
            UIView.transition(with: self.viewController.detailView.tableView,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: { self.viewController.detailView.tableView.reloadData() })
        } else {
            UIView.transition(with: self.viewController.detailView.tableView,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: { self.viewController.detailView.tableView.reloadData() })
        }
    }
}

// MARK: - UITextViewDelegate

extension DetailVCDataSourse: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
                
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            textViewHeight = newSize.height
            UIView.setAnimationsEnabled(false)
            self.viewController.detailView.tableView.beginUpdates()
            self.viewController.detailView.tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
        
        if textView.text.isEmpty {
            self.viewController.saveButton.isEnabled = false
            self.viewController.saveButton.style = .plain
        } else {
            self.viewController.saveButton.isEnabled = true
            self.viewController.saveButton.style = .done
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Що треба зробити?"
            textView.textColor = UIColor.lightGray
           // saveButton.isEnabled = false
        } else {
           // saveButton.style = .done
            //saveButton.isEnabled = true
            self.viewController.task.name = textView.text
        }
    }
}
