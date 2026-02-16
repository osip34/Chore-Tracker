//
//  FirebaseTaskRepository.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 11.02.2026.
//

import Foundation

public protocol TaskRepository: Sendable {
    func fetchTasks(teamId: String) async throws -> [ChoreTask]
    func createTask(
        title: String,
        points: Int,
        teamId: String,
        createdBy: String
    ) async throws -> ChoreTask
    
    func completeTask(
        taskId: String,
        completedBy: String
    ) async throws
}
