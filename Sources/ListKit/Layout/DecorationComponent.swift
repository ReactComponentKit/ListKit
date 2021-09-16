//
//  DecorationComponent.swift
//  ListKit
//
//  Created by burt on 2021/09/16.
//

import UIKit

public protocol DecorationComponent: NSCollectionLayoutDecorationItemConvertible {
    func contentViewClass() -> AnyClass
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    func contentInsets() -> NSDirectionalEdgeInsets
    func zIndex() -> Int
}

extension DecorationComponent {
    public func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return nil
    }
    
    public func contentInsets() -> NSDirectionalEdgeInsets {
        return .zero
    }
    
    public func zIndex() -> Int {
        return 0
    }
    
    public func toNSCollectionLayoutDecorationItem() -> NSCollectionLayoutDecorationItem {
        let item = NSCollectionLayoutDecorationItem.background(elementKind: "\(contentViewClass())")
        item.zIndex = zIndex()
        item.edgeSpacing = edgeSpacing()
        item.contentInsets = contentInsets()
        return item
    }
}
