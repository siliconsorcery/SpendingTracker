//
//  Category.swift
//  SpendingTracker
//
//  Created by Alfian Losari on 11/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable, Identifiable, Hashable {
    
    var id: String {
        rawValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    case housing = "housing"
    case food = "food"
    case transportation = "transportation"
    case utilities = "utilities"
    case insurance = "insurance"
    case medical = "medical"
    case saving = "saving"
    case investing = "investing"
    case payment = "payment"
    case personal = "personal"
}
