//
//  AppleSignInButtonView.swift
//  Chore Tracker
//
//  Created by Andrii Osipchuk on 27.02.2026.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButtonView: View {
    @State private var viewModel = AppleSignInViewModel()

    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            viewModel.prepareSignInRequest(request)
        } onCompletion: { result in
            viewModel.handleSignInCompletion(result)
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 50)
        .disabled(viewModel.isLoading)
    }
}
