import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    var user: User?

    private var rowContainers: [UIView] = []
    private var didAnimateRows = false

    private var dimmingView: UIView?
    private var menuViewController: MenuViewController?
    private var isMenuOpen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        scrollView.backgroundColor = .black
        title = "MovieTracker"
        navigationItem.hidesBackButton = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain, target: self, action: #selector(openMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white

        welcomeLabel.text = "Welcome back, \(user?.username ?? "Guest")!"
        welcomeLabel.font = .systemFont(ofSize: 22, weight: .bold)
        welcomeLabel.textColor = .white

        buildMovieRows()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateRowsIn()
    }

    private func buildMovieRows() {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 26
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 18),
            contentStack.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -28),
            contentStack.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        for (index, section) in MovieData.sections.enumerated() {
            let row = makeRow(for: section, tag: index)
            contentStack.addArrangedSubview(row)
            rowContainers.append(row)
        }
    }

    private func makeRow(for section: MovieSection, tag: Int) -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = section.title
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let labelHolder = UIView()
        labelHolder.backgroundColor = .clear
        labelHolder.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: labelHolder.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: labelHolder.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: labelHolder.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: labelHolder.bottomAnchor)
        ])

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 210)
        layout.minimumLineSpacing = 14
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.tag = tag
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self,
                                forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 210).isActive = true

        let rowStack = UIStackView(arrangedSubviews: [labelHolder, collectionView])
        rowStack.axis = .vertical
        rowStack.spacing = 10
        rowStack.backgroundColor = .clear
        return rowStack
    }

    private func animateRowsIn() {
        guard !didAnimateRows else { return }
        didAnimateRows = true

        for (index, row) in rowContainers.enumerated() {
            row.alpha = 0
            row.transform = CGAffineTransform(translationX: 0, y: 40)
            UIView.animate(withDuration: 0.55,
                           delay: Double(index) * 0.12,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.6,
                           options: [.curveEaseOut]) {
                row.alpha = 1
                row.transform = .identity
            }
        }
    }

    @objc private func openMenu() {
        guard !isMenuOpen else { return }
        isMenuOpen = true

        let dimming = UIView(frame: view.bounds)
        dimming.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimming.alpha = 0
        dimming.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimming.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(closeMenu)))
        view.addSubview(dimming)
        dimmingView = dimming

        let menu = MenuViewController()
        menu.delegate = self
        addChild(menu)

        let menuWidth = view.bounds.width * 0.7
        menu.view.frame = CGRect(x: -menuWidth, y: 0,
                                 width: menuWidth, height: view.bounds.height)
        view.addSubview(menu.view)
        menu.didMove(toParent: self)
        menuViewController = menu

        UIView.animate(withDuration: 0.3) {
            dimming.alpha = 1
            menu.view.frame.origin.x = 0
        }
    }

    @objc private func closeMenu() {
        hideMenu(then: nil)
    }

    private func hideMenu(then action: (() -> Void)?) {
        guard isMenuOpen, let menu = menuViewController else {
            action?()
            return
        }
        isMenuOpen = false
        let offScreenX = -menu.view.bounds.width

        UIView.animate(withDuration: 0.3, animations: {
            self.dimmingView?.alpha = 0
            menu.view.frame.origin.x = offScreenX
        }, completion: { _ in
            menu.willMove(toParent: nil)
            menu.view.removeFromSuperview()
            menu.removeFromParent()
            self.menuViewController = nil
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
            action?()
        })
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        MovieData.sections[collectionView.tag].movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        let movie = MovieData.sections[collectionView.tag].movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}

extension HomeViewController: MenuViewControllerDelegate {
    func menuDidSelect(_ item: MenuItem) {
        hideMenu { [weak self] in
            guard let self else { return }
            switch item {
            case .cinemas:
                self.navigationController?.pushViewController(
                    CinemasMapViewController(), animated: true)
            case .trailers:
                self.navigationController?.pushViewController(
                    WebViewController(), animated: true)
            case .logout:
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
