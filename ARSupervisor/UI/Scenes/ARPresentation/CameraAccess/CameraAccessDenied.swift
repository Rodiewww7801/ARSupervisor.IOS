//
//  CameraAccessDenied.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 04.11.2024.
//

import SwiftUI

struct CameraAccessDenied: View {
    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .opacity(0.2)
            Text("Allow camera access to use ARSupervisor")
        }
    }
}

#Preview {
    CameraAccessDenied()
}
