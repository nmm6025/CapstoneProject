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
            ("Budget Bot", "gearshape.fill", AnyView(BudgetBotView())),
            ("Cut Costs", "scissors", AnyView(CutCostsView()))
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
    var body: some View {
        Text("Budgeting View")
    }
}

struct CutCostsView: View {
    var body: some View {
        Text("Cut Costs View")
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
