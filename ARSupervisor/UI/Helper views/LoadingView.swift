//
//  LoadingView.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 05.11.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(UIColor.white).opacity(0.7))
            .transition(.opacity)
    }
}
