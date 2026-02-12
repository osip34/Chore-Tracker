//
//  User.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 12.02.2026.
//

import Foundation

public struct User: Identifiable, Equatable, Sendable {
    public let id: String
    public var name: String
    public var teamId: String?
    public var points: Int
    
    public init(
        id: String,
        name: String,
        teamId: String?,
        points: Int
    ) {
        self.id = id
        self.name = name
        self.teamId = teamId
        self.points = points
    }
}
