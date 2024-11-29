//
//  AuthView.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

import SwiftUI

import SwiftUI
import Combine

struct AuthView: View {
    @State var email: String = ""
    @State var password: String = ""
    @Binding var viewState: LoginView.ViewState
    @StateObject var viewModel: LoginViewModel
    
    var loginDisabled: Bool {
        return email.isEmpty  || password.isEmpty
    }
    
    var body: some View {
        VStack {            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
            
            Divider()
            
            SecureField("Password", text: $password)
            
            Divider()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Log in") {
                hideKeyboard()
                Task {
                    await viewModel.login(email: self.email, password: self.password)
                }
            }.disabled(self.loginDisabled)
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
    }
}


#Preview {
    
}
