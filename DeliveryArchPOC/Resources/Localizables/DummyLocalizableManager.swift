//
//  DummyLocalizableManager.swift
//  DeliveryArchPOC
//
//  Created by Pablo Gonzalez on 27/3/21.
//

import Foundation

protocol DummyLocalizableManagerProtocol {
    func localizable(forKey key: LocalizableKey) -> String
}

class DummyLocalizableManager: DummyLocalizableManagerProtocol {
    func localizable(forKey key: LocalizableKey) -> String {
        switch key {
        case .userTitle:
            return "Ingresa tu usuario"
        case .passwordTitle:
            return "Ingresa tu contraseña"
        case .userPlaceHolder:
            return "pepito@pepe.com"
        case .passwordPlaceHolder:
            return "12345678"
        case .signIn:
            return "Ingresar"
        }
    }
}

enum LocalizableKey: Equatable {
    case userTitle
    case passwordTitle
    case userPlaceHolder
    case passwordPlaceHolder
    case signIn
}
