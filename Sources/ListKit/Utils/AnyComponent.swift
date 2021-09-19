//
//  ComponentWrapper.swift
//  ListKit
//
//  Created by burt on 2021/09/12.
//

import UIKit

public struct AnyComponent: Component, Equatable {
    
    public static func == (lhs: AnyComponent, rhs: AnyComponent) -> Bool {
        return lhs.id == rhs.id
    }
    
    let box: AnyComponentBox
    
    public var id: AnyHashable {
        return box.id
    }
    
    public init<Base: Component>(_ base: Base) {
        if let anyComponent = base as? AnyComponent {
            self = anyComponent
        } else {
            box = ComponentBox(base)
        }
    }
    
    public func contentView() -> Any {
        return box.contentView()
    }
    
    public func layoutSize() -> NSCollectionLayoutSize {
        return box.layoutSize()
    }
    
    public func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return box.edgeSpacing()
    }
    
    public func contentInsets() -> NSDirectionalEdgeInsets {
        return box.contentInsets()
    }
    
    public func supplementComponents() -> [AnySupplementaryComponent] {
        return box.supplementComponents()
    }
    
    public func willDisplay(content: Any) {
        box.willDisplay(content: content)
    }
    
    public func didEndDisplay(content: Any) {
        box.didEndDisplay(content: content)
    }
    
    public func render(in content: Any) {
        box.render(in: content)
    }
    
    public func to<T>(_: T.Type) -> T? {
        return box.base as? T
    }
}

internal protocol AnyComponentBox {
    var base: Any { get }
    var id: AnyHashable { get }
    func contentView() -> Any
    func layoutSize() -> NSCollectionLayoutSize
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    func contentInsets() -> NSDirectionalEdgeInsets
    func supplementComponents() -> [AnySupplementaryComponent]
    func willDisplay(content: Any)
    func didEndDisplay(content: Any)
    func render(in content: Any)
}

internal struct ComponentBox<Base: Component>: AnyComponentBox {
    let baseComponent: Base
    
    var base: Any {
        return baseComponent
    }
    
    var id: AnyHashable {
        return baseComponent.id
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
    
    func layoutSize() -> NSCollectionLayoutSize {
        return baseComponent.layoutSize()
    }
    
    func edgeSpacing() -> NSCollectionLayoutEdgeSpacing? {
        return baseComponent.edgeSpacing()
    }
    
    func contentInsets() -> NSDirectionalEdgeInsets {
        return baseComponent.contentInsets()
    }
    
    func supplementComponents() -> [AnySupplementaryComponent] {
        return baseComponent.supplementComponents()
    }
    
    func willDisplay(content: Any) {
        guard let content = content as? Base.Content else { return }
        baseComponent.willDisplay(content: content)
    }
    
    func didEndDisplay(content: Any) {
        guard let content = content as? Base.Content else { return }
        baseComponent.didEndDisplay(content: content)
    }
    
    func render(in content: Any) {
        guard let content = content as? Base.Content else { return }
        baseComponent.render(in: content)
    }
}

internal class AnyComponentWrapper: NSObject {
    let component: AnyComponent
    init(component: AnyComponent) {
        self.component = component
    }
}
