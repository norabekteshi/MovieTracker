import UIKit

enum MenuItem: String, CaseIterable {
    case theaters = "Nearest Theaters"
    case imdb = "IMDb Ratings"
    case logout = "Logout"
}

protocol MenuViewControllerDelegate: AnyObject {
    func menuViewController(_ menu: MenuViewController, didSelect item: MenuItem)
}

final class MenuViewController: UIViewController {
    weak var delegate: MenuViewControllerDelegate?

    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let items = MenuItem.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureTitle()
        configureTableView()
    }

    private func configureTitle() {
        titleLabel.text = "Menu"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.rowHeight = 56
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.text = item.rawValue
            config.textProperties.color = .white
            config.textProperties.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = item.rawValue
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menuViewController(self, didSelect: items[indexPath.row])
    }
}
