//
//  DataSource.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

public protocol ListKitDataSource: ComponentQueryable {
    /// UICollectionView that uses this DataSource
    var collectionView: UICollectionView? { get set }
    /// Configure UICollectionViewCell if needed
    func configure(cell: UICollectionViewCell)
}
