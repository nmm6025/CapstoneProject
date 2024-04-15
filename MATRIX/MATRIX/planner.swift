import SwiftUI

struct BudgetPlanningView: View {
    @State private var weeklyBudget: Double = 0
    @State private var expenses: [Expense] = []

    var body: some View {
        NavigationView {
            VStack {
                TextField("Weekly Budget", value: $weeklyBudget, formatter: NumberFormatter())
                    .padding()
                
                List {
                    ForEach(expenses.indices, id: \.self) { index in
                        ExpenseRow(expense: $expenses[index])
                    }
                    .onDelete(perform: deleteExpense)
                }
                .navigationTitle("Budget Planning")
                .navigationBarItems(trailing: Button(action: addExpense) {
                    Image(systemName: "plus")
                })
                
                Spacer()
            }
        }
    }
    
    private func addExpense() {
        expenses.append(Expense())
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
}

struct ExpenseRow: View {
    @Binding var expense: Expense
    
    var body: some View {
        HStack {
            TextField("Category", text: $expense.category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Amount", value: $expense.amount, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct Expense {
    var category: String = ""
    var amount: Double = 0.0
}

struct BudgetPlanningView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetPlanningView()
    }
}
