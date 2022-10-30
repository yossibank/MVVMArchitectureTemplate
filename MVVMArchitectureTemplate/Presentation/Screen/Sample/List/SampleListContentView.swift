import Combine
import SnapKit
import UIKit

// MARK: - section & item

enum SampleListSection {
    case main
}

enum SampleListItem: Hashable {
    case main(SampleModelObject)
}

// MARK: - stored properties & init

final class SampleListContentView: UIView {
    var modelObject: [SampleModelObject] = [] {
        didSet {
            apply()
        }
    }

    lazy var didSelectContentPublisher = didSelectContentSubject.eraseToAnyPublisher()

    private var dataSource: UITableViewDiffableDataSource<SampleListSection, SampleListItem>!

    private let didSelectContentSubject = PassthroughSubject<IndexPath, Never>()
    private let tableView = UITableView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - private methods

private extension SampleListContentView {
    func setupTableView() {
        dataSource = configureDataSource()

        tableView.register(
            SampleCell.self,
            forCellReuseIdentifier: SampleCell.className
        )

        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    func apply() {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<SampleListSection, SampleListItem>()
        dataSourceSnapshot.appendSections([.main])

        modelObject.forEach { object in
            dataSourceSnapshot.appendItems([.main(object)])
        }

        dataSource.apply(
            dataSourceSnapshot,
            animatingDifferences: false
        )
    }

    func configureDataSource() -> UITableViewDiffableDataSource<
        SampleListSection,
        SampleListItem
    > {
        .init(tableView: tableView) { [weak self] tableView, indexPath, item in
            guard let self else {
                return .init()
            }

            return self.makeCell(
                tableView: tableView,
                indexPath: indexPath,
                item: item
            )
        }
    }

    func makeCell(
        tableView: UITableView,
        indexPath: IndexPath,
        item: SampleListItem
    ) -> UITableViewCell? {
        switch item {
        case let .main(modelObject):
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SampleCell.className,
                    for: indexPath
                ) as? SampleCell
            else {
                return .init()
            }

            cell.configure(modelObject)

            return cell
        }
    }
}

// MARK: - delegate

extension SampleListContentView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        100
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath,
            animated: false
        )

        didSelectContentSubject.send(indexPath)
    }
}

// MARK: - protocol

extension SampleListContentView: ContentView {
    func setupViews() {
        apply(.background)
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
