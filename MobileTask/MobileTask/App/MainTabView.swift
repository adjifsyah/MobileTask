//
//  MainTabView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        PagerTabStripWrapper(childViewControllers: [home, profile])
        
    }
    
    var home: SwiftUIChildController<HomeView> {
        SwiftUIChildController(title: "Home", rootView: HomeView())
    }
    
    var profile: UIHostingController<ProfileView> {
        SwiftUIChildController(title: "Profile", rootView: ProfileView())
    }
}
