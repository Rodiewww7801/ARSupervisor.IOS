//
//  RegisterView.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @Binding var viewState: LoginView.ViewState
    @StateObject var viewModel: LoginViewModel
    
    var registerDisabled: Bool {
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
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Register account") {
                hideKeyboard()
                viewModel.register(email: self.email, password: self.password)
            }.disabled(self.registerDisabled)
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
    }
}
