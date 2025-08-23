//
//  SessionManager.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation

final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var currentUser: UserModel? = nil
    
    private init() {}
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    func login(user: UserModel) {
        currentUser = user
    }
    
    func logout() {
        currentUser = nil
    }
}
