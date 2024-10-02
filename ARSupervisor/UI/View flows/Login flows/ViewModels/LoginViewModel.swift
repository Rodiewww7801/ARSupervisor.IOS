//
//  LoginViewModel.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var showProgressView: Bool = false
    @Published var errorMessage: String?
    @Published var onSuccessLogin: Bool = false
    
    private let userManager: UserManagerProtocol = dependency.domainDependency.userManager
    private var subscriptions = Set<AnyCancellable>()
    
    func login(email: String, password: String) {
        let credentials = UserCredentials(email: email, password: password)
        showProgressView = true
        userManager
            .authUser(credentials)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.onSuccessLogin = true
                case .failure(let failure):
                    self.errorMessage = failure.customDescription
                }
                self.showProgressView = false
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
    
    func register(email: String, password: String) {
        let credentials = UserCredentials(email: email, password: password)
        let user = User(credentials: credentials)
        showProgressView = true
        userManager
            .registerUser(user)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.login(email: email, password: password)
                case .failure(let failure):
                    self.errorMessage = failure.customDescription
                    self.showProgressView = false
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}
