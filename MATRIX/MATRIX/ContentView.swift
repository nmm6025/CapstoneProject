import SwiftUI

struct HomePageView: View {
    @StateObject var userManager = UserManager()
    @State private var selection: Int? = 0
    
    var body: some View {
        NavigationView {
            VStack {
                WalletView(selection: $selection)
                    .environmentObject(userManager)
            }
            .background(Image("wallet_background").resizable().ignoresSafeArea())
            .navigationViewStyle(.stack)
            .navigationTitle("Matrix Wallet")
        }
    }
}

struct WalletView: View {
    @Binding var selection: Int?
    @EnvironmentObject var userManager: UserManager
    
    private let cardInfos: [(text: String, image: String, destination: AnyView)]
    
    init(selection: Binding<Int?>) {
        self._selection = selection
        self.cardInfos = [
            ("Budgeting", "creditcard", AnyView(BudgetingView())),
            ("Financial Goals", "chart.bar", AnyView(FinancialGoalsView())),
            ("Cut Costs", "scissors", AnyView(CutCostsView())),
            ("Budget Planning", "dollarsign.circle", AnyView(BudgetPlanningView()))
        ]
    }
    
    var body: some View {
        List {
            ForEach(cardInfos.indices, id: \.self) { index in
                NavigationLink(
                    destination: cardInfos[index].destination,
                    tag: index,
                    selection: $selection
                ) {
                    CardView(text: cardInfos[index].text, image: cardInfos[index].image)
                }
                .listRowInsets(EdgeInsets())
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listStyle(.plain)
        .navigationTitle("Wallet")
    }
}

struct BudgetingView: View {
    @State private var foodExpense: Double = 0
    @State private var rentExpense: Double = 0
    @State private var utilitiesExpense: Double = 0
    @State private var spendingExpense: Double = 0
    @State private var otherExpense: Double = 0
    
    var totalExpense: Double {
        foodExpense + rentExpense + utilitiesExpense + spendingExpense + otherExpense
    }
    
    var body: some View {
        Form {
            Section(header: Text("Expenses")) {
                TextField("Food", value: $foodExpense, formatter: NumberFormatter.currency)
                TextField("Rent", value: $rentExpense, formatter: NumberFormatter.currency)
                TextField("Utilities", value: $utilitiesExpense, formatter: NumberFormatter.currency)
                TextField("Spending Money", value: $spendingExpense, formatter: NumberFormatter.currency)
                TextField("Other", value: $otherExpense, formatter: NumberFormatter.currency)
            }
            
            Section(header: Text("Total Expense")) {
                Text("\(totalExpense, specifier: "%.2f")")
            }
        }
        .navigationTitle("Budgeting")
    }
}

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

struct BudgetingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetingView()
    }
}



struct CardView: View {
    let text: String
    let image: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text(text)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
    }
}
