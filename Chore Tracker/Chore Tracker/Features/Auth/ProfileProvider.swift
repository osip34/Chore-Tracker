//
//  ProfileProvider.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 28.02.2026.
//

import Foundation
import FirebaseAuth

protocol ProfileProviderProtocol {
    var currentUserId: String? { get }
}

@MainActor
@Observable
class ProfileProvider: ProfileProviderProtocol {
    private(set) var currentUserId: String?
    
    init() {
        currentUserId = Auth.auth().currentUser?.uid
        addStateDidChangeListener()
    }
    
    private func addStateDidChangeListener() {
        _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.currentUserId = user?.uid
            }
        }
    }
}
