import SwiftUI
import Foundation

struct CityCostData: Codable {
    let city: String
    let country: String
    let x1: Float
    let x2: Float
    let x3: Float
    let x4: Float
    let x5: Float
    let x6: Float
    let x7: Float
    let x8: Float
    let x9: Float
    let x10: Float
    let x11: Float
    let x12: Float
    let x13: Float
    let x14: Float
    let x15: Float
    let x16: Float
    let x17: Float
    let x18: Float
    let x19: Float
    let x20: Float
    let x21: Float
    let x22: Float
    let x23: Float
    let x24: Float
    let x25: Float
    let x26: Float
    let x27: Float
    let x28: Float
    let x29: Float
    let x30: Float
    let x31: Float
    let x32: Float
    let x33: Float
    let x34: Float
    let x35: Float
    let x36: Float
    let x37: Float
    let x38: Float
    let x39: Float
    let x40: Float
    let x41: Float
    let x42: Float
    let x43: Float
    let x44: Float
    let x45: Float
    let x46: Float
    let x47: Float
    let x48: Float
    let x49: Float
    let x50: Float
    let x51: Float
    let x52: Float
    let x53: Float
    let x54: Float
    let x55: Float
    let dataQuality: Int

    var description: String {
        return "\(city), \(country)"
    }
}

class CityDataLoader: ObservableObject {
    @Published var cities = [CityCostData]()
    var countries = [String]()
    var categories = [String]()

    init() {
        load()
    }

    func load() {
        guard let fileURL = Bundle.main.url(forResource: "data", withExtension: "json") else { return }

        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let dataFromJson = try jsonDecoder.decode([CityCostData].self, from: data)
            self.cities = dataFromJson

            // Extract the countries and categories from the data
            countries = Array(Set(dataFromJson.map { $0.country })).sorted()

            if let selectedData = dataFromJson.first {
                let mirror = Mirror(reflecting: selectedData)
                categories = mirror.children.compactMap { $0.label }
            }

        } catch {
            print(error)
        }
    }
}

struct BudgetBotView: View {
    @StateObject private var dataLoader = CityDataLoader()
    @State private var selectedCountryIndex = 0
    @State private var selectedCityIndex = 0
    @State private var selectedCategoryIndex = 0
    @State private var chatInput = ""
    @State private var chatOutput = ""

    var body: some View {
        VStack {
            VStack {
                Picker("Country", selection: $selectedCountryIndex) {
                    ForEach(0..<dataLoader.countries.count, id: \.self) { index in
                        Text(dataLoader.countries[index])
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Picker("City", selection: $selectedCityIndex) {
                    ForEach(0..<dataLoader.cities.count, id: \.self) { index in
                        Text(dataLoader.cities[index].description)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            Divider()

            ScrollView {
                VStack(alignment: .leading) {
                    Text(chatOutput)
                }
            }
            .frame(height: 200)

            Divider()

            HStack {
                TextField("Enter category", text: $chatInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    fetchData()
                }) {
                    Text("Fetch Data")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .onChange(of: selectedCountryIndex) { _ in
            selectedCityIndex = 0
        }
    }
    private func fetchData() {
        guard selectedCountryIndex >= 0 && selectedCountryIndex < dataLoader.countries.count else {
            print("Invalid selectedCountryIndex")
            return
        }

        guard selectedCityIndex >= 0 && selectedCityIndex < dataLoader.cities.count else {
            print("Invalid selectedCityIndex")
            return
        }

        let selectedCountry = dataLoader.countries[selectedCountryIndex]
        let selectedCity = dataLoader.cities[selectedCityIndex].city
        let selectedCategory = dataLoader.categories[selectedCategoryIndex]

        let selectedData = dataLoader.cities[selectedCityIndex]

        let categoryValue: Float
        switch selectedCategory {
        case "x1": categoryValue = selectedData.x1
        case "x2": categoryValue = selectedData.x2
        case "x3": categoryValue = selectedData.x3
        case "x4": categoryValue = selectedData.x4
        case "x5": categoryValue = selectedData.x5
        case "x6": categoryValue = selectedData.x6
        case "x7": categoryValue = selectedData.x7
        case "x8": categoryValue = selectedData.x8
        case "x9": categoryValue = selectedData.x9
        case "x10": categoryValue = selectedData.x10
        case "x11": categoryValue = selectedData.x11
        case "x12": categoryValue = selectedData.x12
        case "x13": categoryValue = selectedData.x13
        case "x14": categoryValue = selectedData.x14
        case "x15": categoryValue = selectedData.x15
        case "x16": categoryValue = selectedData.x16
        case "x17": categoryValue = selectedData.x17
        case "x18": categoryValue = selectedData.x18
        case "x19": categoryValue = selectedData.x19
        case "x20": categoryValue = selectedData.x20
        case "x21": categoryValue = selectedData.x21
        case "x22": categoryValue = selectedData.x22
        case "x23": categoryValue = selectedData.x23
        case "x24": categoryValue = selectedData.x24
        case "x25": categoryValue = selectedData.x25
        case "x26": categoryValue = selectedData.x26
        case "x27": categoryValue = selectedData.x27
        case "x28": categoryValue = selectedData.x28
        case "x29": categoryValue = selectedData.x29
        case "x30": categoryValue = selectedData.x30
        case "x31": categoryValue = selectedData.x31
        case "x32": categoryValue = selectedData.x32
        case "x33": categoryValue = selectedData.x33
        case "x34": categoryValue = selectedData.x34
        case "x35": categoryValue = selectedData.x35
        case "x36": categoryValue = selectedData.x36
        case "x37": categoryValue = selectedData.x37
        case "x38": categoryValue = selectedData.x38
        case "x39": categoryValue = selectedData.x39
        case "x40": categoryValue = selectedData.x40
        case "x41": categoryValue = selectedData.x41
        case "x42": categoryValue = selectedData.x42
        case "x43": categoryValue = selectedData.x43
        case "x44": categoryValue = selectedData.x44
        case "x45": categoryValue = selectedData.x45
        case "x46": categoryValue = selectedData.x46
        case "x47": categoryValue = selectedData.x47
        case "x48": categoryValue = selectedData.x48
        case "x49": categoryValue = selectedData.x49
        case "x50": categoryValue = selectedData.x50
        case "x51": categoryValue = selectedData.x51
        case "x52": categoryValue = selectedData.x52
        case "x53": categoryValue = selectedData.x53
        case "x54": categoryValue = selectedData.x54
        case "x55": categoryValue = selectedData.x55
        default: categoryValue = 0
        }

        let message = "\(selectedCategory) for \(selectedCity) in \(selectedCountry) is \(categoryValue)"

        chatOutput += message + "\n"

        // Reset chat input field
        chatInput = ""
    }
}
struct BudgetBotContentView: View {
    var body: some View {
        BudgetBotView()
    }
}

struct BudgetBotContentView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetBotContentView()
    }
}
