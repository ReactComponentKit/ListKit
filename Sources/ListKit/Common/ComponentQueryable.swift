//
//  ComponentQueryable.swift
//  ListKit
//
//  Created by burt on 2021/09/19.
//
import UIKit

public protocol ComponentQueryable: ComposeLayoutProvider {
    /// Query AnyComponent at IndexPath
    func anyComponent(at indexPath: IndexPath) -> AnyComponent?
    /// Query AnyComponent at IndexPath and casting it to T type if exists
    func component<T>(at indexPath: IndexPath, to: T.Type) -> T?
}

extension ComponentQueryable {
    public func anyComponent(at indexPath: IndexPath) -> AnyComponent? {
        return self.layout?.sections[indexPath.section].components[indexPath.item].component
    }

    public func component<T>(at indexPath: IndexPath, to type: T.Type) -> T? {
        return self.layout?.sections[indexPath.section].components[indexPath.item].component.to(type)
    }
}
