//
//  LoginView.swift
//  ARSupervisor
//
//  Created by Rodion Hladchenko on 28.09.2024.
//

import SwiftUI

struct LoginView: View {
    
    enum ViewState {
        case login
        case register
        case none
    }
    
    @State var viewState: LoginView.ViewState = .none
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(width: 1, height: 220)
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                
                switch viewState {
                case .login:
                    AuthView(viewState: $viewState, viewModel: viewModel)
                        .transition(.slide)
                case .register:
                    RegisterView(viewState: $viewState, viewModel: viewModel)
                        .transition(.slide)
                case .none:
                    Button("Log In", action: {
                        withAnimation {
                            self.viewState = .login
                        }
                    })
                    .padding()
                    
                    LoginOrView()
                    
                    Button("Register new account", action: {
                        withAnimation {
                            self.viewState = .register
                        }
                    })
                    .padding()
                }
                
                Spacer()
                
                Text("by rodiewww7801")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray)
            }
            
            if viewModel.showProgressView {
                LoadingView()
            }
        }.disabled(viewModel.showProgressView)
    }
}

struct LoginOrView: View {
    var body: some View {
        VStack {
            Divider()
                .frame(width: 300)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
