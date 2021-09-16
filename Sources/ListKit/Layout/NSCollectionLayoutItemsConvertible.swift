//
//  NSCollectionLayoutItemConvertible.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

public protocol NSCollectionLayoutItemsConvertible {
    func toNSCollectionLayoutItems() -> [NSCollectionLayoutItem]
}

extension NSCollectionLayoutItem: NSCollectionLayoutItemsConvertible {
    public func toNSCollectionLayoutItems() -> [NSCollectionLayoutItem] {
        return [self]
    }
}

extension Array: NSCollectionLayoutItemsConvertible where Element: NSCollectionLayoutItem {
    public func toNSCollectionLayoutItems() -> [NSCollectionLayoutItem] {
        return self
    }
}
