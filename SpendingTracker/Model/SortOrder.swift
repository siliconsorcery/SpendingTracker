//
//  SortOrder.swift
//  SpendingTracker
//
//  Created by Alfian Losari on 11/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

enum SortFilter: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case date = "date"
    case amount = "amount"
}

enum SortOrder: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case descending = "descending"
    case ascending = "ascending"
}
