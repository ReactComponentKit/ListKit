//
//  DiffableDataSource.swift
//  ListKit
//
//  Created by burt on 2021/09/16.
//

import UIKit

open class DiffableDataSource: DataSource {
    public var layout: ComposeLayout?
    public weak var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyComponent>?
    
    public init() {
    }
    
    func applySnapshot(animated: Bool) {
        guard let collectionView = collectionView else { return }
        if self.dataSource == nil {
            self.dataSource = UICollectionViewDiffableDataSource<Section, AnyComponent>(collectionView: collectionView) { [weak self] collectionView, indexPath, section in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListKitCell.className, for: indexPath)
                self?.configure(cell: cell)
                if let wrapper = self?.layout?.sections[indexPath.section].components[indexPath.item], let contentView = wrapper.component.contentView() as? UIView {
                    cell.contentView.viewWithTag(Int.max)?.removeFromSuperview()
                    contentView.tag = Int.max
                    cell.contentView.addSubview(contentView)

                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    let constraints = [
                        cell.contentView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        cell.contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                        cell.contentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cell.contentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                    ]
                    NSLayoutConstraint.activate(constraints)

                    wrapper.component.render(in: contentView)

                }
                return cell
            }
            
            self.dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: ListKitReusableView.className, withReuseIdentifier: ListKitReusableView.className, for: indexPath)
                if let anySupplementaryComponent = SupplementaryComponentManager.shared[kind], let contentView = anySupplementaryComponent.contentView() as? UIView {
                    
                    view.viewWithTag(Int.max)?.removeFromSuperview()
                    contentView.tag = Int.max
                    view.addSubview(contentView)
                    
                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    let constraints = [
                        view.topAnchor.constraint(equalTo: contentView.topAnchor),
                        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                    ]
                    NSLayoutConstraint.activate(constraints)
                    
                    anySupplementaryComponent.render(in: contentView)
                }
                return view
            }
            collectionView.dataSource = dataSource
        }
        updateSnapshot(animated: animated)
    }
    
    func updateSnapshot(animated: Bool) {
        guard let layout = layout else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyComponent>()
        snapshot.appendSections(layout.sections)
        for section in layout.sections {
            snapshot.appendItems(section.components.map { $0.component }, toSection: section)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    open func configure(cell: UICollectionViewCell) {
    }
}
