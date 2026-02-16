//
//  ChoreDataService.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 16.02.2026.
//

import Foundation

protocol ChoreDataService {
    
    // MARK: - ChoreTask Operations
    
    func createTask(title: String, points: Int, teamId: String, createdBy: String) async throws -> ChoreTask
    func fetchTasks(teamId: String) async throws -> [ChoreTask]
    func updateTask(taskId: String, task: ChoreTask) async throws
    func deleteTask(taskId: String) async throws
    
    // MARK: - User Operations
    
    func createUser(id: String, name: String, teamId: String?) async throws -> User
    func fetchUser(id: String) async throws -> User?
    func updateUser(userId: String, user: User) async throws
    func fetchTeamMembers(teamId: String) async throws -> [User]
    
    // MARK: - Team Operations
    
    func createTeam(name: String, inviteCode: String) async throws -> Team
    func fetchTeam(id: String) async throws -> Team?
    func fetchTeamByInviteCode(inviteCode: String) async throws -> Team?
    func updateTeam(teamId: String, team: Team) async throws
}
