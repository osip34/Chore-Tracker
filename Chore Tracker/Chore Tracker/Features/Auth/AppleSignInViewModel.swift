//
//  AppleSignInViewModel.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 27.02.2026.
//

import Foundation
import CryptoKit
import AuthenticationServices
import FirebaseAuth

protocol AppleSignInViewModelProtocol {
    var isLoading: Bool { get }
    
    func prepareSignInRequest(_ request: ASAuthorizationAppleIDRequest)
    func handleSignInCompletion(_ result: Result<ASAuthorization, Error>)
}

@MainActor
@Observable
class AppleSignInViewModel: AppleSignInViewModelProtocol {
    private var currentNonce: String?
    private(set) var isLoading = false
    
    func prepareSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }
    
    func handleSignInCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            handleAuthorization(authResults)
        case .failure(let error):
            print("Apple sign in error:", error)
        }
    }
    
    private func handleAuthorization(_ authResults: ASAuthorization) {
        guard
            let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential,
            let nonce = currentNonce,
            let appleIDToken = appleIDCredential.identityToken,
            let idTokenString = String(data: appleIDToken, encoding: .utf8)
        else {
            print("Unable to fetch identity token")
            return
        }
        
        let credential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )
        
        signInWithFirebase(credential: credential)
    }
    
    private func signInWithFirebase(credential: AuthCredential) {
        isLoading = true
        
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            Task { @MainActor in
                self?.isLoading = false
                
                if let error = error {
                    print("Firebase auth error:", error)
                    return
                }
                
                print("User signed in:", result?.user.uid ?? "")
            }
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms = (0..<16).map { _ in UInt8.random(in: 0...255) }
            randoms.forEach { random in
                if remainingLength == 0 { return }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let data = Data(input.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
