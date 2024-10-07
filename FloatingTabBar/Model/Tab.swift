//
//  Tab.swift
//  FloatingTabBar
//
//  Created by Muhammet Emin Ayhan on 6.10.2024.
//

import SwiftUI

enum TabModel: String, CaseIterable {
    case home = "house"
    case search = "magnifyingglass"
    case notifications = "bell"
    case settings = "gearshape"
    
    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .notifications: "Notifications"
        case .settings: "Settings"
        }
    }
}
