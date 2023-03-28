//
//  MainVCDelegate.swift
//  TODOIT
//
//  Created by alekseienko on 27.03.2023.
//

import UIKit

class MainVCDelegate: NSObject {
    
    weak var delegate: MainDelegateDelegate!
    
}
// MARK: - UITableViewDelegate

extension MainVCDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectTask(indexPath: indexPath)
    }
}


