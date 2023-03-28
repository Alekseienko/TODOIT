//
//  MainVC.swift
//  TODOIT
//
//  Created by alekseienko on 16.03.2023.
//

import UIKit

class MainVC: UIViewController {
    
// MARK: - Property
    var mainView: MainView!
    var mainVCDataSource: MainVCDataSource!
    var mainDelegate: MainVCDelegate!
    var tasks: [[Task]] = []
    
}

// MARK: - LifeCircle

extension MainVC {
    
    override func loadView() {
        super.loadView()
        self.mainView = MainView(frame: self.view.bounds)
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        reloadTable()
    }
}

// MARK: - Configuration

extension MainVC {
    
    private func config() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Moї задачі"
        self.mainView.button.addTarget(self, action: #selector(self.addTask), for: .touchUpInside)
        self.mainVCDataSource = MainVCDataSource(viewController: self)
        self.mainView.tableView.dataSource = self.mainVCDataSource
        self.mainDelegate = MainVCDelegate()
        self.mainDelegate.delegate = self
        self.mainView.tableView.delegate = self.mainDelegate
    }
    
    @objc private func addTask() {
        let vc = DetailVC()
        let task = CoreDataManager.shared.createTask()
        vc.delegate = self
        vc.task = task
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }
}

// MARK: - MainDelegateDelegate

extension MainVC: MainDelegateDelegate {
    
    func didSelectTask(indexPath: IndexPath) {
        let vc = DetailVC()
        vc.delegate = self
        let task = self.tasks[indexPath.section][indexPath.row]
        vc.task = task
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }
}

// MARK: - DetailVCDelegate

extension MainVC: DetailVCDelegateDelegate {
    
    func reloadTable() {
        self.tasks = CoreDataManager.shared.getAllTasks()
        self.mainView.tableView.reloadData()
    }
}
