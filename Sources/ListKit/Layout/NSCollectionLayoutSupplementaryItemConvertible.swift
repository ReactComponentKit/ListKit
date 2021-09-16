//
//  NSCollectionLayoutSupplementaryItemConvertible.swift
//  ListKit
//
//  Created by burt on 2021/09/15.
//

import UIKit

public protocol NSCollectionLayoutSupplementaryItemConvertible {
    func toNSCollectionLayoutSupplementaryItem() -> NSCollectionLayoutSupplementaryItem
}

public protocol NSCollectionLayoutBoundarySupplementaryItemConvertible {
    func toNSCollectionLayoutBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem
}

public protocol NSCollectionLayoutDecorationItemConvertible {
    func toNSCollectionLayoutDecorationItem() -> NSCollectionLayoutDecorationItem
}
