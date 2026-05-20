//
//  MenuViewController.swift
//  MovieTracker
//
//  PHASE 2 — REQ 1: a UITableView listing the menu options.
//  Shown as a slide-in panel (REQ 6) by HomeViewController.
//

import UIKit

enum MenuItem: String, CaseIterable {
    case cinemas  = "Cinemas Near Me"
    case trailers = "Trailers"
    case logout   = "Log Out"
}

protocol MenuViewControllerDelegate: AnyObject {
    func menuDidSelect(_ item: MenuItem)
}

final class MenuViewController: UIViewController {

    weak var delegate: MenuViewControllerDelegate?

    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private let items = MenuItem.allCases
    private let cellID = "MenuCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        titleLabel.text = "Menu"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // REQ 1: a UITableView.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 54
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // REQ 8: constraints in code.
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                 for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = items[indexPath.row].rawValue
        config.textProperties.font = .systemFont(ofSize: 18, weight: .medium)
        cell.contentConfiguration = config
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.menuDidSelect(items[indexPath.row])
    }
}
