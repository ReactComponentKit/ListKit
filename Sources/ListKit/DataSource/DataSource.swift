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
    func component<T>(at indexPath: IndexPath, to: T.Type) -> T?
}

extension DataSource {
    public func component<T>(at indexPath: IndexPath, to type: T.Type) -> T? {
        return self.layout?.sections[indexPath.section].components[indexPath.item].component.to(type)
    }
}