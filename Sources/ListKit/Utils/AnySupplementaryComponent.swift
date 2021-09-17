//
//  AnySupplementaryComponent.swift
//  ListKit
//
//  Created by burt on 2021/09/15.
//

import UIKit

public struct AnySupplementaryComponent: SupplementaryComponent, Equatable {
    
    public var id: AnyHashable = UUID()
    
    public static func == (lhs: AnySupplementaryComponent, rhs: AnySupplementaryComponent) -> Bool {
        return lhs.kindValue == rhs.kindValue
    }
    
    private let box: AnySupplementaryComponentBox
    
    public init<Base: SupplementaryComponent>(_ base: Base) {
        if let anySupplementaryComponent = base as? AnySupplementaryComponent {
            self = anySupplementaryComponent
        } else {
            box = SupplementaryComponentBox(base)
        }
    }
    
    public func contentView() -> Any {
        return box.contentView()
    }
    
    public func layoutSize() -> NSCollectionLayoutSize {
        return box.layoutSize()
    }
    
    public func containerAnchor() -> NSCollectionLayoutAnchor {
        return box.containerAnchor()
    }
    
    public func itemAnchor() -> NSCollectionLayoutAnchor {
        return box.itemAnchor()
    }
    
    public func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return box.edgeSpacing()
    }
    
    public func contentInsets() -> NSDirectionalEdgeInsets {
        return box.contentInsets()
    }
    
    public func render(in content: Any) {
        box.render(in: content)
    }
    
    public func pinToVisibleBounds() -> Bool {
        return box.pinToVisibleBounds()
    }
    
    public func offset() -> CGPoint {
        return box.offset()
    }
    
    public func alignment() -> NSRectAlignment {
        return box.alignment()
    }
    
    public func extendsBoundary() -> Bool {
        return box.extendsBoundary()
    }
}

internal protocol AnySupplementaryComponentBox {
    var base: Any { get }
    var reuseIdentifier: String { get }
    func contentView() -> Any
    func layoutSize() -> NSCollectionLayoutSize
    func containerAnchor() -> NSCollectionLayoutAnchor
    func itemAnchor() -> NSCollectionLayoutAnchor
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    func contentInsets() -> NSDirectionalEdgeInsets
    func render(in content: Any)
    func pinToVisibleBounds() -> Bool
    func offset() -> CGPoint
    func alignment() -> NSRectAlignment
    func extendsBoundary() -> Bool
}

internal struct SupplementaryComponentBox<Base: SupplementaryComponent>: AnySupplementaryComponentBox {
    let baseComponent: Base
    
    var base: Any {
        return baseComponent
    }
    
    var reuseIdentifier: String {
        return baseComponent.reuseIdentifier
    }
    
    init(_ base: Base) {
        baseComponent = base
    }
    
    func contentView() -> Any {
        return baseComponent.contentView()
    }
    
    func containerAnchor() -> NSCollectionLayoutAnchor {
        return baseComponent.containerAnchor()
    }
    
    func itemAnchor() -> NSCollectionLayoutAnchor {
        return baseComponent.itemAnchor()
    }

    func layoutSize() -> NSCollectionLayoutSize {
        return baseComponent.layoutSize()
    }

    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return baseComponent.edgeSpacing()
    }

    func contentInsets() -> NSDirectionalEdgeInsets {
        return baseComponent.contentInsets()
    }

    func render(in content: Any) {
        guard let content = content as? Base.Content else { return }
        baseComponent.render(in: content)
    }
    
    func pinToVisibleBounds() -> Bool {
        return baseComponent.pinToVisibleBounds()
    }
    
    func offset() -> CGPoint {
        return baseComponent.offset()
    }
    
    func alignment() -> NSRectAlignment {
        return baseComponent.alignment()
    }
    
    func extendsBoundary() -> Bool {
        return baseComponent.extendsBoundary()
    }
}

internal class AnySupplementaryComponentWrapper: NSObject {
    let component: AnySupplementaryComponent
    init(component: AnySupplementaryComponent) {
        self.component = component
    }
}
