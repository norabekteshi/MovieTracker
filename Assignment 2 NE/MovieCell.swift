import UIKit

final class MovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        contentView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 2

        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 12)
        ])
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        subtitleLabel.text = movie.subtitle
    }
}
