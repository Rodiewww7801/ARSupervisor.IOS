//
//  LoginViewModel.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

import Combine
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var showProgressView: Bool = false
    @Published var errorMessage: String?
    @Published var onSuccessLogin: Bool = false
    private var userCredentials: UserCredentials?
    
    private let userManager: UserManagerProtocol = dependency.domainDependency.userManager
    
    func login(email: String, password: String) async {
        let credentials = UserCredentials(email: email, password: password)
        showProgressView = true
        do {
            defer { self.showProgressView = false }
            try await userManager.authUser(credentials)
            onSuccessLogin = true
        } catch let error as ARSAuthError {
            onSuccessLogin = false
            self.errorMessage = error.customDescription
        } catch {
            onSuccessLogin = false
            return
        }
    }
    
    func register(email: String, password: String) async {
        let credentials = UserCredentials(email: email, password: password)
        self.userCredentials = credentials
        showProgressView = true
        do {
            defer { self.showProgressView = false }
            try await userManager.registerUser(credentials)
        } catch let error as ARSAuthError {
            self.errorMessage = error.customDescription
        } catch {
            return
        }
        
        await login(email: credentials.email, password: credentials.password)
    }
}
