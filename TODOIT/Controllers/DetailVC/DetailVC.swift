//
//  DetailVC.swift
//  TODOIT
//
//  Created by alekseienko on 16.03.2023.
//

import UIKit



class DetailVC: UIViewController {
    
    var detailView: DetailView!
    var saveButton: UIBarButtonItem!
    var isDedline = false
    weak var delegate: DetailVCDelegateDelegate!
    var detailVCDataSourse: DetailVCDataSourse!
    var detailVCDelegate: DetailVCDelegate!
    var task: Task!
    
}

// MARK: - LifeCircle

extension DetailVC {
    
    override func loadView() {
        super.loadView()
        self.detailView = DetailView(frame: self.view.bounds)
        self.view = self.detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        self.detailView.tableView.estimatedRowHeight = UITableView.automaticDimension
        if self.task.date != nil {
            isDedline = true
        } else {
            isDedline = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    
        if let name = task.name {
            if !name.isEmpty {
                return
            }
        }
        CoreDataManager.shared.deleteObject(object: task)
        delegate.reloadTable()
    }
}

// MARK: - Configuration UI

extension DetailVC {
    
    private func config() {
        self.title = "Задача"
        self.isModalInPresentation = true
        configNavItems()
        configSaveButton()
        detailVCDataSourse = DetailVCDataSourse(viewController: self)
        detailView.tableView.dataSource = detailVCDataSourse
        detailVCDelegate = DetailVCDelegate()
        detailView.tableView.delegate = detailVCDelegate
    }
    
    private func configNavItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Відмінити", style: .plain, target: self, action: #selector(cancel))
    }
    
    private func configSaveButton() {
        saveButton = UIBarButtonItem(title: "Зберегти", style: .plain, target: self, action: #selector(save))
        
        if let name = task.name  {
            if !name.isEmpty {
                saveButton.isEnabled = true
                saveButton.style = .plain
            } else {
                saveButton.isEnabled = false
                saveButton.style = .done
            }
        } else {
            saveButton.isEnabled = false
            saveButton.style = .done
        }
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true)
    }
    
    @objc private func save(sender: UIBarButtonItem) {
        
        if isDedline {
            let indexPath = IndexPath(row: 2, section: 1)
            if let cell = detailView.tableView.cellForRow(at: indexPath) as? DatePikerTableViewCell {
                
                if cell.datePiker.date < Date() {
                    let alert = UIAlertController(title: "Увага!", message: "Неможливо обрати минулу дату!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Зберегти без дати", style: .default) { action in
                        self.task.date = nil
                        CoreDataManager.shared.saveContext()
                        NotificationManager.shared.createNotification(for: self.task)
                        self.delegate.reloadTable()
                        self.dismiss(animated: true)
                    }
                    let cancleAction = UIAlertAction(title: "Встановлю дату", style: .cancel)
                    alert.addAction(okAction)
                    alert.addAction(cancleAction)
                    self.present(alert, animated: true)
                    return
                } else {
                    task.date = cell.datePiker.date
                    CoreDataManager.shared.saveContext()
                    NotificationManager.shared.createNotification(for: task)
                    delegate.reloadTable()
                    self.dismiss(animated: true)
                    return
                }
            }
        }
        self.detailView.tableView.endEditing(true)
        CoreDataManager.shared.saveContext()
        delegate.reloadTable()
        self.dismiss(animated: true)
    }
}
