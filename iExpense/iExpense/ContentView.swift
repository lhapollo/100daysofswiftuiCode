//
//  ContentView.swift
//  iExpense
//
//  Created by Lexi Han on 2024-05-03.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct BusinessExpense: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
    }
}

struct PersonalExpense: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.green)
    }
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}



struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    if (item.type == "Personal") {
                        HStack {
                            VStack(alignment: .leading){
                                if (item.type == "Personal") {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .personalModifier()
                                }
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                    }
                }
                .onDelete(perform: removeItems)
                
                ForEach(expenses.items) { item in
                    if (item.type == "Business") {
                        HStack {
                            VStack(alignment: .leading){
                                if (item.type == "Business") {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .businessModifier()
                                }
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

extension View {
    func personalModifier() -> some View {
        modifier(PersonalExpense())
    }
    func businessModifier() -> some View {
        modifier(BusinessExpense())
    }
}

#Preview {
    ContentView()
}
