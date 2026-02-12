//
//  Task.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 12.02.2026.
//

import Foundation

public struct Task: Identifiable, Equatable, Sendable {
    public let id: String
    public var title: String
    public var points: Int
    public var teamId: String
    public var createdBy: String
    public var completedBy: String?
    public var isCompleted: Bool
    
    public init(
        id: String,
        title: String,
        points: Int,
        teamId: String,
        createdBy: String,
        completedBy: String? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.points = points
        self.teamId = teamId
        self.createdBy = createdBy
        self.completedBy = completedBy
        self.isCompleted = isCompleted
    }
}
