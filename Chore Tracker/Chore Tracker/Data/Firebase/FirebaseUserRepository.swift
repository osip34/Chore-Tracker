//
//  FirebaseUserRepository.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 11.02.2026.
//

import Foundation

public protocol UserRepository: Sendable {
    func fetchCurrentUser() async throws -> User
    func updateUser(_ user: User) async throws
    func fetchUsers(teamId: String) async throws -> [User]
}
