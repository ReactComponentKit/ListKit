//
//  SupplementaryComponent.swift
//  ListKit
//
//  Created by burt on 2021/09/15.
//

import UIKit

public enum SupplementaryComponentKind {
    case header
    case footer
    case background
    case custom(name: String)
    
    internal var value: String {
        switch self {
        case .header:
            return "header"
        case .footer:
            return "footer"
        case .background:
            return "background"
        case .custom(let name):
            return "custom-\(name)"
        }
    }
}

public protocol SupplementaryComponent:
    NSCollectionLayoutSupplementaryItemConvertible,
    NSCollectionLayoutBoundarySupplementaryItemConvertible {
    /// Component's content view which is inherited from UIView.
    associatedtype Content
    
    /// Component's unique ID
    var id: AnyHashable { get set }
    
    /// A string that identifies the type of supplementary item.
    var kind: SupplementaryComponentKind { get }
    
    /// return component's content view instance
    func contentView() -> Content
    
    /// The component's size expressed in width and height dimensions.
    func layoutSize() -> NSCollectionLayoutSize
    
    /// The anchor between the supplementary component and the container it's attached to.
    func containerAnchor() -> NSCollectionLayoutAnchor
    
    /// The anchor between the supplementary component and the component it's attached to.
    func itemAnchor() -> NSCollectionLayoutAnchor
    
    /// he amount of space added around the boundaries of the item between other components and this component's container.
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    
    /// The amount of space added around the content of the component to adjust its final size after its position is computed.
    func contentInsets() -> NSDirectionalEdgeInsets
    
    /// Render data to component's content view
    func render(in content: Content)
    
    /// The vertical stacking order of the supplementary item in relation to other items in the section.
    func zIndex() -> Int

    /// used for boundarySupplementary type
    /// A Boolean value that indicates whether a header or footer is pinned to the top or bottom visible boundary of
    /// the section or layout it's attached to.
    func pinToVisibleBounds() -> Bool
    
    /// The floating-point value of the boundary supplementary item's offset from the section or layout it's attached to.
    func offset() -> CGPoint
    
    /// The alignment of the boundary supplementary item relative to the section or layout it's attached to.
    func alignment() -> NSRectAlignment
    
    /// A Boolean value that indicates whether a boundary supplementary item extends the content area of the section or layout it's attached to.
    func extendsBoundary() -> Bool
}

extension SupplementaryComponent {
    var reuseIdentifier: String {
        return String(reflecting: Self.self)
    }
    
    var kindValue: String {
        return "\(reuseIdentifier)-\(kind.value)-\(id)"
    }
    
    public var kind: SupplementaryComponentKind {
        return .header
    }
    
    public func containerAnchor() -> NSCollectionLayoutAnchor {
        return NSCollectionLayoutAnchor(edges: [.top], absoluteOffset: .zero)
    }
    
    public func itemAnchor() -> NSCollectionLayoutAnchor {
        return NSCollectionLayoutAnchor(edges: [.top], absoluteOffset: .zero)
    }
    
    public func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return nil
    }
    
    public func contentInsets() -> NSDirectionalEdgeInsets {
        return .zero
    }
    
    public func zIndex() -> Int {
        return 0
    }
    
    public func pinToVisibleBounds() -> Bool {
        return false
    }
    
    public func offset() -> CGPoint {
        return .zero
    }
    
    public func alignment() -> NSRectAlignment {
        return .top
    }
    
    public func extendsBoundary() -> Bool {
        return true
    }
    
    public func toNSCollectionLayoutSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        let item = NSCollectionLayoutSupplementaryItem(layoutSize: layoutSize(), elementKind: kindValue, containerAnchor: containerAnchor(), itemAnchor: itemAnchor())
        item.edgeSpacing = edgeSpacing()
        item.contentInsets = contentInsets()
        item.zIndex = zIndex()
        return item
    }
    
    public func toNSCollectionLayoutBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize(),
                                                               elementKind: kindValue,
                                                               alignment: alignment(),
                                                               absoluteOffset: offset())
        item.extendsBoundary = extendsBoundary()
        item.pinToVisibleBounds = pinToVisibleBounds()
        item.zIndex = zIndex()
        return item
    }
}
