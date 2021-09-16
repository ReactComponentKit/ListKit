//
//  SupplementaryComponentManager.swift
//  ListKit
//
//  Created by burt on 2021/09/15.
//

import Foundation

internal class SupplementaryComponentManager {
    static let shared = SupplementaryComponentManager()
    private var supplementaryComponentMap: [String: AnySupplementaryComponent] = [:]
    var decorationComponents: [AnyClass] = []
    
    private init() {
    }
    
    subscript(name: String) -> AnySupplementaryComponent? {
        get {
            return supplementaryComponentMap[name]
        }
        set {
            supplementaryComponentMap[name] = newValue
        }
    }
    
    func append<S: SupplementaryComponent>(_ component: S) {
        supplementaryComponentMap[component.kindValue] = AnySupplementaryComponent(component)
    }
    
    func append<D: DecorationComponent>(_ component: D) {
        if !decorationComponents.contains(where: { $0 == component.contentViewClass() }) {
            decorationComponents.append(component.contentViewClass())
        }
    }
    
    func clear() {
        supplementaryComponentMap.removeAll()
        decorationComponents.removeAll()
    }
}
