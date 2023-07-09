//
//  Vault.swift
//
//
//  Created by Thomas Rademaker on 1/24/21.
//

import Foundation

public protocol KeychainConfiguration {
    var serviceName: String { get set }
    var accessGroup: String? { get set }
    var accountName: String { get set }
}

public enum VaultError: Error {
    case noKeychainConfiguration
}

extension VaultError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noKeychainConfiguration:
            "Vault error: A KeychainConfiguration object is needed to complete action. Please provide one by either passing it to this method or by using the Vault configure method"
        }
    }
}

public struct Vault {
    static var keychainConfiguration: KeychainConfiguration?
    
    public static func configure(_ keychainConfiguration: KeychainConfiguration) {
        Vault.keychainConfiguration = keychainConfiguration
    }
    
    private static func getKeychainConfiguration(passedInParameterValue value: KeychainConfiguration?) throws -> KeychainConfiguration {
        if let value {
            return value
        } else if let keychainConfiguration {
            return keychainConfiguration
        } else {
            throw VaultError.noKeychainConfiguration
        }
    }
    
    public static func savePrivateKey(_ privateKey: String, keychainConfiguration: KeychainConfiguration? = nil) throws {
        let keychainConfiguration = try getKeychainConfiguration(passedInParameterValue: keychainConfiguration)
        try KeychainItem(service: keychainConfiguration.serviceName, account: keychainConfiguration.accountName, accessGroup: keychainConfiguration.accessGroup).saveItem(privateKey)
    }
    
    public static func getPrivateKey(keychainConfiguration: KeychainConfiguration? = nil) throws -> String {
        let keychainConfiguration = try getKeychainConfiguration(passedInParameterValue: keychainConfiguration)
        return try KeychainItem(service: keychainConfiguration.serviceName, account: keychainConfiguration.accountName, accessGroup: keychainConfiguration.accessGroup).readItem()
    }
    
    public static func deletePrivateKey(keychainConfiguration: KeychainConfiguration? = nil) throws {
        let keychainConfiguration = try getKeychainConfiguration(passedInParameterValue: keychainConfiguration)
        try KeychainItem(service: keychainConfiguration.serviceName, account: keychainConfiguration.accountName, accessGroup: keychainConfiguration.accessGroup).deleteItem()
    }
}
