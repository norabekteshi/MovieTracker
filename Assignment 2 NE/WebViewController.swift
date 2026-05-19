import UIKit
import WebKit

final class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let imdbURL = URL(string: "https://www.imdb.com/chart/top/")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "IMDb Ratings"
        view.backgroundColor = .systemBackground
        configureWebView()
        loadPage()
    }

    private func configureWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadPage() {
        guard let imdbURL else { return }
        webView.load(URLRequest(url: imdbURL))
    }
}
