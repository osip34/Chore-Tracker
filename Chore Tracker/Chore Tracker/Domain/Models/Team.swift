//
//  Team.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 12.02.2026.
//

import Foundation

public struct Team: Identifiable, Equatable, Sendable {
    public let id: String
    public var name: String
    public var inviteCode: String
    
    public init(
        id: String,
        name: String,
        inviteCode: String
    ) {
        self.id = id
        self.name = name
        self.inviteCode = inviteCode
    }
}
