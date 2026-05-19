import UIKit

final class HomeViewController: UIViewController {
    private let titleLabel = UILabel()
    private let menuButton = UIButton(type: .system)
    private let collectionView: UICollectionView
    private let movies = Movie.sample

    private var menuViewController: MenuViewController?
    private var dimmingView: UIView?
    private var isMenuVisible = false

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(false, animated: false)
        configureHeader()
        configureCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.bounds.width
            let inset = layout.sectionInset.left + layout.sectionInset.right
            let spacing = layout.minimumInteritemSpacing
            let itemWidth = (width - inset - spacing) / 2
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        }
    }

    private func configureHeader() {
        titleLabel.text = "MovieTracker"
        titleLabel.textColor = .systemRed
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        menuButton.setTitle("☰", for: .normal)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor)
        ])
    }

    private func configureCollectionView() {
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func showMenu() {
        guard !isMenuVisible else { return }
        isMenuVisible = true

        let dimming = UIView(frame: view.bounds)
        dimming.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        dimming.alpha = 0
        dimming.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimming.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideMenu)))
        view.addSubview(dimming)
        dimmingView = dimming

        let menuVC = MenuViewController()
        menuVC.delegate = self
        addChild(menuVC)
        let menuView = menuVC.view
        menuView?.frame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(menuView ?? UIView())
        menuVC.didMove(toParent: self)
        menuViewController = menuVC

        UIView.animate(withDuration: 0.25) {
            dimming.alpha = 1
            menuView?.frame.origin.x = 0
        }
    }

    @objc private func hideMenu() {
        hideMenu(completion: nil)
    }

    private func hideMenu(completion: (() -> Void)?) {
        guard isMenuVisible else { completion?(); return }
        isMenuVisible = false
        let menuView = menuViewController?.view
        UIView.animate(withDuration: 0.25, animations: {
            self.dimmingView?.alpha = 0
            menuView?.frame.origin.x = -self.view.bounds.width
        }, completion: { _ in
            self.menuViewController?.willMove(toParent: nil)
            menuView?.removeFromSuperview()
            self.menuViewController?.removeFromParent()
            self.menuViewController = nil
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
            completion?()
        })
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.configure(with: movies[indexPath.item])
        return cell
    }
}

extension HomeViewController: MenuViewControllerDelegate {
    func menuViewController(_ menu: MenuViewController, didSelect item: MenuItem) {
        hideMenu { [weak self] in
            guard let self else { return }
            switch item {
            case .theaters:
                self.navigationController?.pushViewController(MapViewController(), animated: true)
            case .imdb:
                self.navigationController?.pushViewController(WebViewController(), animated: true)
            case .logout:
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
