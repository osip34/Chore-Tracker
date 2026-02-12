//
//  FirebaseTeamRepository.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 11.02.2026.
//

import Foundation

public protocol TeamRepository: Sendable {
    func createTeam(name: String, ownerId: String) async throws -> Team
    func joinTeam(inviteCode: String, userId: String) async throws -> Team
    func fetchTeam(id: String) async throws -> Team
}
