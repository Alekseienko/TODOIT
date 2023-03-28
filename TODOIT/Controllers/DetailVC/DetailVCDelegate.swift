//
//  DetailVCDelegate.swift
//  TODOIT
//
//  Created by alekseienko on 27.03.2023.
//

import UIKit

class DetailVCDelegate: NSObject {}


// MARK: - UITableViewDelegate

extension DetailVCDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = CellType(rawValue: indexPath.row) else { fatalError() }
        
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.section == 1 {
            switch cellType {
            case .segmented: return SegmentedTableViewCell.height
            case .switcher: return SwitcherTableViewCell.height
            case .date: return DatePikerTableViewCell.height
            }
        } else {
            return ButtonTableViewCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
    }
}
