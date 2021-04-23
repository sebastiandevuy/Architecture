//
//  Observable.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation


/// Observable to be used on ViewState only. Dispatches updates to the main queue.
class ViewObservable<T> {
    private var value: T?
    var bind: ((T?) -> Void)?
    
    init(_ initialValue: T?) {
        value = initialValue
    }
    
    func set(newValue: T?) {
        value = newValue
        if Thread.isMainThread {
            bind?(value)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.bind?(self?.value)
            }
        }
    }
    
    func get() -> T? {
        return value
    }
}
