//
//  AppCoordinator.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var session: SessionManager = SessionManager.shared
    
    func showLogin() {
        isLoggedIn = false
    }
    
    func showMain() {
        isLoggedIn = true
    }
    
    func logout() {
        session.logout()
        showLogin()
    }
}
