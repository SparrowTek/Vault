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

public struct Vault {
    
    public static func savePrivateKey(_ privateKey: String, keychainConfiguration: KeychainConfiguration) throws {
        try KeychainItem(service: keychainConfiguration.serviceName, account: keychainConfiguration.accountName, accessGroup: keychainConfiguration.accessGroup).saveItem(privateKey)
    }
    
    public static func getPrivateKey(keychainConfiguration: KeychainConfiguration) throws -> String {
        return try KeychainItem(service: keychainConfiguration.serviceName, account: keychainConfiguration.accountName, accessGroup: keychainConfiguration.accessGroup).readItem()
    }
    
    public static func deletePrivateKey(keychainConfiguration: KeychainConfiguration) throws {
        try KeychainItem(service: keychainConfiguration.serviceName, account: keychainConfiguration.accountName, accessGroup: keychainConfiguration.accessGroup).deleteItem()
    }
}
