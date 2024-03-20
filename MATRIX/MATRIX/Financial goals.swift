import SwiftUI

class GoalStore: ObservableObject {
    @Published var goals: [FinancialGoal] {
        didSet {
            let data = try? JSONEncoder().encode(goals)
            UserDefaults.standard.set(data, forKey: "Goals")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Goals"),
           let savedGoals = try? JSONDecoder().decode([FinancialGoal].self, from: data) {
            goals = savedGoals
        } else {
            goals = []
        }
    }
}

struct FinancialGoalsView: View {
    @StateObject private var goalStore = GoalStore()
    @State private var showingAddGoal = false

    var body: some View {
        NavigationView {
            List {
                ForEach(goalStore.goals.indices, id: \.self) { index in
                    NavigationLink(destination: GoalDetailView(index: index).environmentObject(goalStore)) {
                        GoalRowView(goal: goalStore.goals[index])
                    }
                }
                .onDelete(perform: deleteGoals)
            }
            .navigationTitle("Financial Goals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddGoal = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView { newGoal in
                    goalStore.goals.append(newGoal)
                    showingAddGoal = false
                }
            }
        }
    }

    private func deleteGoals(at offsets: IndexSet) {
        goalStore.goals.remove(atOffsets: offsets)
    }
}

struct FinancialGoal: Identifiable, Codable {
    var id = UUID()
    var name: String
    var currentValue: Double
    var targetValue: Double
}

struct GoalRowView: View {
    var goal: FinancialGoal

    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.name)
                .font(.headline)
            ProgressView(value: goal.currentValue, total: goal.targetValue)
        }
    }
}

struct GoalDetailView: View {
    @EnvironmentObject var goalStore: GoalStore
    let index: Int
    @State private var depositAmount = ""

    var body: some View {
        Form {
            Section {
                Text(goalStore.goals[index].name)
                ProgressView(value: goalStore.goals[index].currentValue, total: goalStore.goals[index].targetValue)
            }
            Section {
                TextField("Deposit Amount", text: $depositAmount)
                    .keyboardType(.decimalPad)
                Button("Add Deposit") {
                    if let deposit = Double(depositAmount),
                       goalStore.goals[index].currentValue + deposit <= goalStore.goals[index].targetValue {
                        goalStore.goals[index].currentValue += deposit
                        depositAmount = ""
                    }
                }
                .disabled(depositAmount.isEmpty || Double(depositAmount) == nil)
            }
        }
    }
}

struct AddGoalView: View {
    @State private var name = ""
    @State private var targetValue = ""
    var didAddGoal: (FinancialGoal) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Target Value", text: $targetValue)
                        .keyboardType(.decimalPad)
                }
                Section {
                    Button("Add Goal") {
                        if let targetValue = Double(targetValue) {
                            didAddGoal(FinancialGoal(name: name, currentValue: 0, targetValue: targetValue))
                        }
                    }
                }
            }
            .navigationTitle("Add Goal")
        }
    }
}
