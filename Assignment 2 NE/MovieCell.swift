import UIKit

final class MovieCell: UICollectionViewCell {

    static let reuseID = "MovieCell"

    private let posterView = UIView()
    private let initialLabel = UILabel()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        posterView.layer.cornerRadius = 10
        posterView.clipsToBounds = true
        posterView.translatesAutoresizingMaskIntoConstraints = false

        initialLabel.font = .systemFont(ofSize: 44, weight: .bold)
        initialLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        initialLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        ratingLabel.font = .systemFont(ofSize: 12, weight: .regular)
        ratingLabel.textColor = .secondaryLabel
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        posterView.addSubview(initialLabel)
        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)

        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 150),

            initialLabel.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
            initialLabel.centerYAnchor.constraint(equalTo: posterView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ \(movie.rating)  •  \(movie.year)"
        initialLabel.text = String(movie.title.prefix(1))
        posterView.backgroundColor = Self.posterColor(for: movie.title)
    }

    private static func posterColor(for title: String) -> UIColor {
        let palette: [UIColor] = [
            .systemIndigo, .systemTeal, .systemPink, .systemOrange,
            .systemPurple, .systemBlue, .systemGreen, .systemRed
        ]
        let sum = title.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return palette[sum % palette.count]
    }
}
