//
//  ItemBuilder.swift
//  ListKit
//
//  Created by burt on 2021/09/12.
//

import UIKit

@resultBuilder
public struct ItemBuilder {
    public static func buildBlock(_ components: NSCollectionLayoutItemsConvertible...) -> [NSCollectionLayoutItem] {
        return components.flatMap { $0.toNSCollectionLayoutItems() }
    }
    
    public static func buildFinalResult(_ component: [NSCollectionLayoutItem]) -> [NSCollectionLayoutItem] {
        return component
    }
    
    /// support if block
    public static func buildOptional(_ component: [NSCollectionLayoutItemsConvertible]?) -> [NSCollectionLayoutItem] {
        return component?.flatMap { $0.toNSCollectionLayoutItems() } ?? []
    }
    
    /// support if-else block (if)
    public static func buildEither(first component: [NSCollectionLayoutItemsConvertible]) -> [NSCollectionLayoutItem] {
        return component.flatMap { $0.toNSCollectionLayoutItems() }
    }

    /// support if-else block (else)
    public static func buildEither(second component: [NSCollectionLayoutItemsConvertible]) -> [NSCollectionLayoutItem] {
        return component.flatMap { $0.toNSCollectionLayoutItems() }
    }
    
    /// support for-in loop
    public static func buildArray(_ components: [NSCollectionLayoutItemsConvertible]) -> [NSCollectionLayoutItem] {
        return components.flatMap { $0.toNSCollectionLayoutItems() }
    }
}
