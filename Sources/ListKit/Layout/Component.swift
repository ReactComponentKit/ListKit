//
//  Component.swift
//  ListKit
//
//  Created by burt on 2021/09/10.
//

import UIKit

public protocol Component: NSCollectionLayoutItemsConvertible, Hashable {
    // 컴포넌트와 연결된 컨텐트 뷰
    associatedtype Content
    var id: AnyHashable { get }
    func contentView() -> Content
    func layoutSize() -> NSCollectionLayoutSize
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    func contentInsets() -> NSDirectionalEdgeInsets
    func supplementComponents() -> [AnySupplementaryComponent]
    func render(in content: Content)
}

extension Component {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    var reuseIdentifier: String {
        return String(reflecting: Self.self)
    }
    
    public func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return nil
    }
    
    public func contentInsets() -> NSDirectionalEdgeInsets {
        return .zero
    }
    
    public func supplementComponents() -> [AnySupplementaryComponent] {
        return []
    }
    
    public func toNSCollectionLayoutItems() -> [NSCollectionLayoutItem] {
        let registerable = supplementComponents()
        registerable.forEach { SupplementaryComponentManager.shared.append($0) }
        let supplementaryItems = registerable.map { $0.toNSCollectionLayoutSupplementaryItem() }
        let item = NSCollectionLayoutItem(layoutSize: layoutSize(), supplementaryItems: supplementaryItems)
        item.contentInsets = self.contentInsets()
        item.edgeSpacing = self.edgeSpacing()
        item.anyComponent = AnyComponentWrapper(component: AnyComponent(self))
        return [item]
    }
}
