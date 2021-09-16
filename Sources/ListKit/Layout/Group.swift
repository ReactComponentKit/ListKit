//
//  Group.swift
//  ListKit
//
//  Created by burt on 2021/09/10.
//

import UIKit

public protocol Group: NSCollectionLayoutItemsConvertible, NSCollectionLayoutGroupConvertible {
    var width: NSCollectionLayoutDimension { get }
    var height: NSCollectionLayoutDimension { get }
    var items: [NSCollectionLayoutItem] { get }
    var group: NSCollectionLayoutGroup { get }
}

extension Group {
    /// mapping Component Info to the Group's item
    internal func mappingAnyComponent(_ itemsInGroup0: [NSCollectionLayoutItem], _ itemsInGroup1: [NSCollectionLayoutItem]) {
        zip(itemsInGroup0, itemsInGroup1).forEach {
            if let g0 = $0 as? NSCollectionLayoutGroup, let g1 = $1 as? NSCollectionLayoutGroup {
                mappingAnyComponent(g0.subitems, g1.subitems)
            } else {
                $1.anyComponent = $0.anyComponent
            }
        }
    }
    
    /// The amount of space between the items in the group.
    public func interItemSpacing(_ value: NSCollectionLayoutSpacing) -> Group {
        self.group.interItemSpacing = value
        return self
    }
    
    /// The supplementary item that is anchored to the group.
    public func supplementaryItem<S: SupplementaryComponent>(_ value: S) -> Group {
        SupplementaryComponentManager.shared.append(value)
        let item = value.toNSCollectionLayoutSupplementaryItem()
        self.group.supplementaryItems.append(item)
        return self
    }

    /// The amount of space added around the boundaries of the item between other items and this item's container.
    public func edgeSpacing(top: NSCollectionLayoutSpacing = .fixed(0),
                            leading: NSCollectionLayoutSpacing = .fixed(0),
                            bottom: NSCollectionLayoutSpacing = .fixed(0),
                            trailing: NSCollectionLayoutSpacing = .fixed(0)) -> Group {
        self.group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        return self
    }
    
    /// The amount of space added around the content of the item to adjust its final size after its position is computed.
    public func contentInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Group {
        self.group.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        return self
    }
}

public struct HGroup: Group {
    public let width: NSCollectionLayoutDimension
    public let height: NSCollectionLayoutDimension
    public let items: [NSCollectionLayoutItem]
    public let group: NSCollectionLayoutGroup

    public init(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, @ItemBuilder items: () -> [NSCollectionLayoutItem]) {
        self.width = width
        self.height = height
        self.items = items()
        
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        self.group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: self.items)
        mappingAnyComponent(self.items, self.group.subitems)
    }
    
    public init<T>(of items: [T], width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, builder: (T) -> NSCollectionLayoutItemsConvertible) {
        self.init(width: width, height: height) {
            for item in items {
                builder(item)
            }
        }
    }
    
    public func toNSCollectionLayoutItems() -> [NSCollectionLayoutItem] {
        return [self.group]
    }
    
    public func toNSCollectionLayoutGroup() -> NSCollectionLayoutGroup {
        return self.group
    }
}

public struct VGroup: Group {
    public var width: NSCollectionLayoutDimension
    public var height: NSCollectionLayoutDimension
    public let items: [NSCollectionLayoutItem]
    public let group: NSCollectionLayoutGroup
    
    public init(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, @ItemBuilder items: () -> [NSCollectionLayoutItem]) {
        self.width = width
        self.height = height
        self.items = items()
        
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        self.group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: self.items)
        mappingAnyComponent(self.items, self.group.subitems)
    }
    
    public init<T>(of items: [T], width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension, builder: (T) -> NSCollectionLayoutItemsConvertible) {
        self.init(width: width, height: height) {
            for item in items {
                builder(item)
            }
        }
    }
    
    public func toNSCollectionLayoutItems() -> [NSCollectionLayoutItem] {
        return [self.group]
    }
    
    public func toNSCollectionLayoutGroup() -> NSCollectionLayoutGroup {
        return self.group
    }
}



