//
//  ProfileView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            Text(coordinator.session.currentUser?.name ?? "")
                .font(.system(size: 24, weight: .bold))
            Text(coordinator.session.currentUser?.username ?? "")
                .font(.system(size: 16))
            
            Button {
                viewModel.confirm = true
            } label: {
                Text("Keluar")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
        .alert("Konfirmasi", isPresented: $viewModel.confirm) {
            HStack {
                Button("Kembali", role: .cancel) {
                    viewModel.confirm = false
                }
                Button("Ya, Keluar", role: .destructive) {
                    coordinator.logout()
                }
            }
        } message: {
            Text("Apakah anda yakin ingin keluar?")
        }

        
    }
    
}

#Preview {
    ProfileView()
}
