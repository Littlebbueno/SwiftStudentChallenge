//
//  ContactsManager.swift
//  Toxapex
//
//  Created by Marco Bueno on 15/02/26.
//

import SwiftUI
import Contacts
import ContactsUI

@MainActor
@Observable
class ContactManager {
    
    enum Error: Swift.Error {
        case requestAccessError(String)
        case fetchRequestError(String)

    }
    
    var error: Error? {
        didSet {
            if let error {
                print("Error: \(error)")
            }
        }
    }
    var authorizationStatus: CNAuthorizationStatus = .notDetermined
    
    let store = CNContactStore()
  
    init() {
        getAuthorizationStatus()
    }

}

extension ContactManager {
    private func getAuthorizationStatus() {
        self.authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    }
    
    func requestAccess() async {
        guard authorizationStatus == .notDetermined else { return }
        do {
            try await store.requestAccess(for: .contacts)
            getAuthorizationStatus()
        } catch {
            getAuthorizationStatus()
            self.error = .requestAccessError("Requesting Contacts access failed: \(error)")
        }
    }
}

