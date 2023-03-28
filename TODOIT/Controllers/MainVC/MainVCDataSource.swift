//
//  MainVCDataSource.swift
//  TODOIT
//
//  Created by alekseienko on 27.03.2023.
//

import UIKit


class MainVCDataSource: NSObject {
    
    private weak var viewController: MainVC!
    
    init(viewController: MainVC!) {
        self.viewController = viewController
    }
}

extension MainVCDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        let tasksArray = self.viewController.tasks[section]
        if tasksArray.count > 0 {
            guard let sectionType = SectionType(rawValue: section) else { return nil }
            switch sectionType {
            case .priority: return "Важливо"
            case .normal: return "Звичайні"
            case .done: return "Готово"
            }
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewController.tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewController.tasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: type(of: TaskTableViewCell.self))
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? TaskTableViewCell
        if cell == nil {
            cell = TaskTableViewCell(style: .default, reuseIdentifier: id)
            cell?.accessoryType = .disclosureIndicator
            cell?.button.addTarget(self, action: #selector(changeStatus), for: .touchUpInside)
        }
        
        let tasksArray = self.viewController.tasks[indexPath.section]
        let task = tasksArray[indexPath.row]
        cell?.config(with: task)
        return cell!
    }
}

// MARK: - Actions

extension MainVCDataSource {
    
    @objc private func changeStatus(sender: UIButton) {
        let contentView = sender.superview
        guard let cell = contentView?.superview as? TaskTableViewCell else { return }
        guard let indexPath = self.viewController.mainView.tableView.indexPath(for: cell) else { return }
        let tasksArray = self.viewController.tasks[indexPath.section]
        let task = tasksArray[indexPath.row]
        
        if task.isDone {
            task.isDone = false
        } else {
            task.isDone = true
        }
        CoreDataManager.shared.saveContext()
        self.viewController.reloadTable()
    }
}
