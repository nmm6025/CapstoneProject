import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct CutCostsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("School Supplies")) {
                    NavigationLink(destination: WebView(url: URL(string: "https://www.amazon.com/s?k=discounted+school+supplies&hvadid=365521673247&hvdev=c&hvlocphy=1025354&hvnetw=g&hvqmt=b&hvrand=14391470861134297057&hvtargid=kwd-299011644381&hydadcr=7467_9611909&tag=googhydr-20&ref=pd_sl_35b5551ih5_b")!)) {
                        Text("Buy Cheap School Supplies on Amazon")
                    }
                    // Add more school supplies links here if needed
                }
                
                Section(header: Text("Apartment Supplies")) {
                    NavigationLink(destination: WebView(url: URL(string: "https://www.amazon.com/s?k=apartment+essentials+list&hvadid=557151020805&hvdev=c&hvlocphy=1025354&hvnetw=g&hvqmt=b&hvrand=11793170611064109295&hvtargid=kwd-300721010548&hydadcr=11748_13280618&tag=googhydr-20&ref=pd_sl_4pj3x0i022_b")!)) {
                        Text("Buy Cheap Apartment Supplies on Amazon")
                    }
                    // Add more apartment supplies links here if needed
                }
                
                Section(header: Text("Food")) {
                    NavigationLink(destination: WebView(url: URL(string: "https://www.amazon.com/s?k=amazon+clearance+food+items&hvadid=557209953301&hvdev=c&hvlocphy=1025354&hvnetw=g&hvqmt=b&hvrand=10551936651550296423&hvtargid=kwd-1408947444439&hydadcr=7466_13183999&tag=googhydr-20&ref=pd_sl_b1tltzwqm_b")!)) {
                        Text("Buy Cheap Food on Amazon")
                    }
                    // Add more food links here if needed
                }
            }
            .navigationTitle("Cut Costs")
        }
    }
}
