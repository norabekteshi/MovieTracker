import UIKit

final class ForgotPasswordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        wireButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func wireButtons() {
        findButton(title: "Reset")?.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        findButton(title: "Back")?.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }

    @objc private func handleReset() {
        let alert = UIAlertController(title: "Password Reset", message: "Your password has been reset.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    private func findButton(title: String) -> UIButton? {
        return view.findSubview(ofType: UIButton.self) { $0.currentTitle == title }
    }
}
