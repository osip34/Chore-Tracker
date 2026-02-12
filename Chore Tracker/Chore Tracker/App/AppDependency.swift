//
//  AppDependency.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 12.02.2026.
//

import Foundation

final class AppDependencies {
    let userRepository: UserRepository
    let teamRepository: TeamRepository
    let taskRepository: TaskRepository
    
    init(
        userRepository: UserRepository,
        teamRepository: TeamRepository,
        taskRepository: TaskRepository
    ) {
        self.userRepository = userRepository
        self.teamRepository = teamRepository
        self.taskRepository = taskRepository
    }
}
