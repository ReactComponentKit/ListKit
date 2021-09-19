//
//  Component.swift
//  ListKit
//
//  Created by burt on 2021/09/10.
//

import UIKit

public protocol Component: NSCollectionLayoutItemsConvertible, Hashable {
    /// Component's content view which is inherited from UIView.
    associatedtype Content
    /// Component's unique ID
    var id: AnyHashable { get }
    /// return component's content view instance
    func contentView() -> Content
    /// The component's size expressed in width and height dimensions.
    func layoutSize() -> NSCollectionLayoutSize
    /// The amount of space added around the boundaries of the item between other components and this component's container.
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    /// The amount of space added around the content of the component to adjust its final size after its position is computed.
    func contentInsets() -> NSDirectionalEdgeInsets
    /// An array of the supplementary items attached to the component.
    func supplementComponents() -> [AnySupplementaryComponent]
    /// Component's content is about to be displayed in the collection view.
    func willDisplay(content: Content)
    /// Component's content was removed from the collection view.
    func didEndDisplay(content: Content)
    /// Render data to component's content view
    func render(in content: Content)
}

extension Component {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
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
    
    public func willDisplay(content: Content) {
    }

    public func didEndDisplay(content: Content) {
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
