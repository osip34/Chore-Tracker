//
//  FirestoreService.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 16.02.2026.
//

import FirebaseFirestore

final class FirestoreService: ChoreDataService {
    
    private let db = Firestore.firestore()
    
    // MARK: - ChoreTask Operations
    
    func createTask(title: String, points: Int, teamId: String, createdBy: String) async throws -> ChoreTask {
        let taskData: [String: Any] = [
            "title": title,
            "points": points,
            "teamId": teamId,
            "createdBy": createdBy,
            "completedBy": NSNull(),
            "isCompleted": false,
            "createdAt": Timestamp()
        ]
        
        let docRef = try await db.collection("tasks").addDocument(data: taskData)
        
        return ChoreTask(
            id: docRef.documentID,
            title: title,
            points: points,
            teamId: teamId,
            createdBy: createdBy,
            completedBy: nil,
            isCompleted: false
        )
    }
    
    func fetchTasks(teamId: String) async throws -> [ChoreTask] {
        let snapshot = try await db.collection("tasks")
            .whereField("teamId", isEqualTo: teamId)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard let title = data["title"] as? String,
                  let points = data["points"] as? Int,
                  let teamId = data["teamId"] as? String,
                  let createdBy = data["createdBy"] as? String,
                  let isCompleted = data["isCompleted"] as? Bool else {
                return nil
            }
            
            return ChoreTask(
                id: doc.documentID,
                title: title,
                points: points,
                teamId: teamId,
                createdBy: createdBy,
                completedBy: data["completedBy"] as? String,
                isCompleted: isCompleted
            )
        }
    }
    
    func updateTask(taskId: String, task: ChoreTask) async throws {
        let taskData: [String: Any] = [
            "title": task.title,
            "points": task.points,
            "teamId": task.teamId,
            "createdBy": task.createdBy,
            "completedBy": task.completedBy as Any,
            "isCompleted": task.isCompleted
        ]
        
        try await db.collection("tasks").document(taskId).updateData(taskData)
    }
    
    func deleteTask(taskId: String) async throws {
        try await db.collection("tasks").document(taskId).delete()
    }
    
    // MARK: - User Operations
    
    func createUser(id: String, name: String, teamId: String?) async throws -> User {
        let userData: [String: Any] = [
            "name": name,
            "teamId": teamId as Any,
            "points": 0,
            "createdAt": Timestamp()
        ]
        
        try await db.collection("users").document(id).setData(userData)
        
        return User(id: id, name: name, teamId: teamId, points: 0)
    }
    
    func fetchUser(id: String) async throws -> User? {
        let doc = try await db.collection("users").document(id).getDocument()
        
        guard let data = doc.data(),
              let name = data["name"] as? String,
              let points = data["points"] as? Int else {
            return nil
        }
        
        return User(
            id: doc.documentID,
            name: name,
            teamId: data["teamId"] as? String,
            points: points
        )
    }
    
    func updateUser(userId: String, user: User) async throws {
        let userData: [String: Any] = [
            "name": user.name,
            "teamId": user.teamId as Any,
            "points": user.points
        ]
        
        try await db.collection("users").document(userId).updateData(userData)
    }
    
    func fetchTeamMembers(teamId: String) async throws -> [User] {
        let snapshot = try await db.collection("users")
            .whereField("teamId", isEqualTo: teamId)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard let name = data["name"] as? String,
                  let points = data["points"] as? Int else {
                return nil
            }
            
            return User(
                id: doc.documentID,
                name: name,
                teamId: data["teamId"] as? String,
                points: points
            )
        }
    }
    
    // MARK: - Team Operations
    
    func createTeam(name: String, inviteCode: String) async throws -> Team {
        let teamData: [String: Any] = [
            "name": name,
            "inviteCode": inviteCode,
            "createdAt": Timestamp()
        ]
        
        let docRef = try await db.collection("teams").addDocument(data: teamData)
        
        return Team(id: docRef.documentID, name: name, inviteCode: inviteCode)
    }
    
    func fetchTeam(id: String) async throws -> Team? {
        let doc = try await db.collection("teams").document(id).getDocument()
        
        guard let data = doc.data(),
              let name = data["name"] as? String,
              let inviteCode = data["inviteCode"] as? String else {
            return nil
        }
        
        return Team(id: doc.documentID, name: name, inviteCode: inviteCode)
    }
    
    func fetchTeamByInviteCode(inviteCode: String) async throws -> Team? {
        let snapshot = try await db.collection("teams")
            .whereField("inviteCode", isEqualTo: inviteCode)
            .limit(to: 1)
            .getDocuments()
        
        guard let doc = snapshot.documents.first else {
            return nil
        }
        
        let data = doc.data()
        guard let name = data["name"] as? String,
              let code = data["inviteCode"] as? String else {
            return nil
        }
        
        return Team(id: doc.documentID, name: name, inviteCode: code)
    }
    
    func updateTeam(teamId: String, team: Team) async throws {
        let teamData: [String: Any] = [
            "name": team.name,
            "inviteCode": team.inviteCode
        ]
        
        try await db.collection("teams").document(teamId).updateData(teamData)
    }
}
