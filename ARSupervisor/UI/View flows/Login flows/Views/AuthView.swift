//
//  AuthView.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 25.09.2024.
//

import SwiftUI

import SwiftUI
import Combine


//struct AuthView: View {
//    @State var email: String = ""
//    @State var password: String = ""
//    @StateObject var viewModel = LoginViewModel()
//    var loginDisabled: Bool {
//        return email.isEmpty  || password.isEmpty
//    }
//    //@EnvironmentObject var router: Router
//
//    var body: some View {
//        VStack {
//            Image("logo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 250)
//
//            TextField("Email", text: $email)
//                .keyboardType(.emailAddress)
//
//            Divider()
//
//            SecureField("Password", text: $password)
//
//            Divider()
//
//            if viewModel.showProgressView {
//                ProgressView()
//            }
//
//            if viewModel.isNotValidShown {
//                Text("Incorrect email or password.\nTry again")
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            Button("Log in") {
//                hideKeyboard()
//                viewModel.login(completion: { success in
//                    if success {
//                        withAnimation {
//                            //router.currentView = .main
//                        }
//                    }
//                })
//            }.disabled(self.loginDisabled)
//                .padding()
//        }.textFieldStyle(.plain)
//            .autocapitalization(.none)
//            .padding()
//        .disabled(viewModel.showProgressView)
//    }
//}

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
            
            if viewModel.showProgressView {
                ProgressView()
            }
            
            if viewModel.isNotValidShown {
                Text("Incorrect email or password.\nTry again")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Log in") {
                hideKeyboard()
                viewModel.login(completion: { success in
                    if success {
                        withAnimation {
                            //router.currentView = .main
                        }
                    }
                })
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
            .disabled(viewModel.showProgressView)
    }
}


#Preview {
    
}
