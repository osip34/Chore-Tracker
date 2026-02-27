//
//  ContentView.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 10.02.2026.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        Text("Chore Tracker")
            .font(.largeTitle)
        AppleSignInButtonView()
        
    }
}

#Preview {
    ContentView()
}


//func randomNonceString(length: Int = 32) -> String {
//    let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//    var result = ""
//    var remainingLength = length
//
//    while remainingLength > 0 {
//        let randoms = (0..<16).map { _ in UInt8.random(in: 0...255) }
//        randoms.forEach { random in
//            if remainingLength == 0 { return }
//            if random < charset.count {
//                result.append(charset[Int(random)])
//                remainingLength -= 1
//            }
//        }
//    }
//    return result
//}
//
//func sha256(_ input: String) -> String {
//    let data = Data(input.utf8)
//    let hashed = SHA256.hash(data: data)
//    return hashed.compactMap { String(format: "%02x", $0) }.joined()
//}
//
//
//struct AppleSignInButtonView: View {
//
//    @State private var currentNonce: String?
//
//    var body: some View {
//        SignInWithAppleButton(.signIn) { request in
//
//            let nonce = randomNonceString()
//            currentNonce = nonce
//
//            request.requestedScopes = [.fullName, .email]
//            request.nonce = sha256(nonce)
//
//        } onCompletion: { result in
//
//            switch result {
//            case .success(let authResults):
//                handle(authResults)
//            case .failure(let error):
//                print("Apple sign in error:", error)
//            }
//        }
//        .signInWithAppleButtonStyle(.black)
//        .frame(height: 50)
//    }
//
//    private func handle(_ authResults: ASAuthorization) {
//        guard
//            let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential,
//            let nonce = currentNonce,
//            let appleIDToken = appleIDCredential.identityToken,
//            let idTokenString = String(data: appleIDToken, encoding: .utf8)
//        else {
//            print("Unable to fetch identity token")
//            return
//        }
//
//        let credential = OAuthProvider.appleCredential(
//            withIDToken: idTokenString,
//            rawNonce: nonce,
//            fullName: appleIDCredential.fullName
//        )
//
//        Auth.auth().signIn(with: credential) { result, error in
//            if let error = error {
//                print("Firebase auth error:", error)
//                return
//            }
//
//            print("User signed in:", result?.user.uid ?? "")
//        }
//    }
//}
