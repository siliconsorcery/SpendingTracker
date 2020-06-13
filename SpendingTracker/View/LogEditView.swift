//
//  LogEditView.swift
//  SpendingTracker
//
//  Created by Alfian Losari on 11/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct LogEditView: View {
    
    @Environment(\.presentationMode) var presentationMode    
    
    @State var name = ""
    @State var category: Category = .personal
    @State var amount: Double = 0.0
    @State var date = Date()

    var isValid: Bool {
        return !name.isEmpty && amount > 0
    }
    
    var amountFix: Binding<String> {
        Binding<String>(
            get: { String(format: "%.02f", self.amount) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.amount = value.doubleValue
                }
            }
        )
    }
    
    let editedSpending: SpendingLog?
    let saveAction: (SpendingLog) -> Void
    
    init(editedSpending: SpendingLog?, saveAction: @escaping (SpendingLog) -> Void) {
        self.editedSpending = editedSpending
        self.saveAction = saveAction
        
        if let editedSpending = editedSpending {
            _name = State(initialValue: editedSpending.name)
            _category = State(initialValue: editedSpending.category)
            _amount = State(initialValue: editedSpending.amount)
            _date = State(initialValue: editedSpending.date)
        }
        
    }
    
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let filters = Array(Category.allCases)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Name")
                        TextField("Name", text: $name)
                            .textContentType(.name)
                    }
                    HStack {
                        Text("Amount")
                        TextField("Amount", text: amountFix)
                    }
                }
                
                Section {
                    DatePicker(selection: $date) {
                        Text("Date")
                    }
                }
                
                Section {
                    Picker(selection: $category, label: Text("Category")) {
                        ForEach(Category.allCases) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
            }
            .navigationBarTitle(self.editedSpending == nil ? "Create Spending" : "Edit Spending")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        self.saveTapped()
                    }
                    ,label: {
                        Text("Save")
                    }
                )
                .disabled(!self.isValid)
            )
        }
    }
    
    private func saveTapped() {
        let log: SpendingLog
        if let editedLog = editedSpending {
            log = SpendingLog(id: editedLog.id, name: self.name, category: self.category, amount: self.amount, date: self.date)

        } else {
            log = SpendingLog(id: UUID().uuidString, name: self.name, category: self.category, amount: self.amount, date: self.date)
        }
        
        self.saveAction(log)
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct LogEditView_Previews: PreviewProvider {
    static var previews: some View {
        LogEditView(editedSpending: nil) { _ in
            
        }
    }
}
