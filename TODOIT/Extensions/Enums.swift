//
//  Enums.swift
//  TODOIT
//
//  Created by alekseienko on 16.03.2023.
//

import Foundation


enum CellType: Int, CaseIterable {
    case segmented
    case switcher
    case date
}

enum SectionType: Int, CaseIterable {
    case priority
    case normal
    case done
}
