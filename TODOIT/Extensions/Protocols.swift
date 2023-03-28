//
//  Protocols.swift
//  TODOIT
//
//  Created by alekseienko on 23.03.2023.
//

import Foundation

protocol DetailVCDelegateDelegate: AnyObject {
     func reloadTable()
}

protocol MainDelegateDelegate: AnyObject {
    func didSelectTask(indexPath: IndexPath)
}
