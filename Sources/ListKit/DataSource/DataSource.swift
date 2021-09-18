//
//  DataSource.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

public protocol DataSource {
    /// UICollectionView's current compose layout
    var layout: ComposeLayout? { get set }
    /// UICollectionView that uses this DataSource
    var collectionView: UICollectionView? { get set }
    /// Configure UICollectionViewCell if needed
    func configure(cell: UICollectionViewCell)
    /// Query the component at IndexPath and casting it to T type if there is.
    func component<T>(at indexPath: IndexPath, to: T.Type) -> T?
}

extension DataSource {
    public func component<T>(at indexPath: IndexPath, to type: T.Type) -> T? {
        return self.layout?.sections[indexPath.section].components[indexPath.item].component.to(type)
    }
}