//
//  LocalizableManagerMock.swift
//  DeliveryArchPOCTests
//
//  Created by Pablo Gonzalez on 28/3/21.
//

import Foundation
@testable import DeliveryArchPOC

class LocalizableManagerMock: DummyLocalizableManagerProtocol {
    private var localizables = [LocalizableKey]()
    var dummyReturnValue = ""
    
    func localizable(forKey key: LocalizableKey) -> String {
        localizables.append(key)
        return dummyReturnValue
    }
    
    func didReceiveLocalizableKey(_ localizableKey: LocalizableKey) -> Bool {
        localizables.filter({$0 == localizableKey}).count > 0
    }
}
