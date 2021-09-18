//
//  DataSource.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

public protocol DataSource {
    var layout: ComposeLayout? { get set }
    var collectionView: UICollectionView? { get set }
    func configure(cell: UICollectionViewCell)
}
