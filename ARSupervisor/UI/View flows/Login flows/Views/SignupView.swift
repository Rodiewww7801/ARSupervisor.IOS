//
//  SignupView.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI

struct SignupView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @Binding var viewState: LoginView.ViewState
    @StateObject var viewModel: LoginViewModel
    
    var signUpDisabled: Bool {
        return (email.isEmpty  || password.isEmpty) || (password != confirmPassword)
    }
    
    var body: some View {
        VStack {            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
            
            Divider()
            
            SecureField("Password", text: $password)
            
            Divider()
            
            SecureField("Confirm password", text: $confirmPassword)
            
            Divider()
            
            if viewModel.showProgressView {
                ProgressView()
            }
            
            if viewModel.isNotValidShown {
                Text("Incorrect email or password.\nTry again")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Create account") {
                hideKeyboard()
                viewModel.login(completion: { success in
                    if success {
                        withAnimation {
                            //router.currentView = .main
                        }
                    }
                })
            }.disabled(self.signUpDisabled)
                .padding()
            
            LoginOrView()
            
            Button("Go back") {
                hideKeyboard()
                withAnimation {
                    viewState = .none
                }
            }
            .padding()
            
        }.textFieldStyle(.plain)
            .autocapitalization(.none)
            .padding()
            .disabled(viewModel.showProgressView)
    }
}
