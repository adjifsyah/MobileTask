//
//  RootView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var networkMonitor = NetworkMonitor()
    @State var height: CGFloat = .zero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationView {
                Group {
                    if coordinator.isLoggedIn {
                        MainTabView()
                            .environmentObject(coordinator)
                    } else {
                        LoginView { user in
                            coordinator.session.login(user: user)
                            coordinator.showMain()
                        }
                    }
                }
                .preferredColorScheme(.light)
            }
            
            if !networkMonitor.isConnected {
                Text("No Internet Connection")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(4)
                    .safeAreaInset(edge: .bottom, spacing: 0, content: {
                        Spacer()
                            .frame(height: 10)
                    })
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.easeInOut, value: networkMonitor.isConnected)
            }
        }
    }
}
