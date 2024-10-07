//
//  ContentView.swift
//  FloatingTabBar
//
//  Created by Muhammet Emin Ayhan on 6.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: TabModel = .home
    @State private var isTabBarHidden: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if #available(iOS 18.1, *) {
                    TabView(selection: $activeTab) {
                        Tab.init(value: .home) {
                            HomeView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .search) {
                            Text("Search")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .notifications) {
                            Text("Notifications")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .settings) {
                            Text("Settings")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                } else {
                    TabView(selection: $activeTab) {
                        HomeView()
                            .tag(TabModel.home)
                            .background {
                                if !isTabBarHidden {
                                    HideTabBar {
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        Text("Search")
                            .tag(TabModel.search)
                        
                        Text("Notifications")
                            .tag(TabModel.notifications)
                        
                        Text("Settings")
                            .tag(TabModel.settings)
                    }
                }
            }
            CustomTabBar(activeTab: $activeTab)
        }
    }
}
struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    ForEach(1...50, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.background)
                            .frame(height: 50)
                    }
                }
                .padding(15)
            }
            .navigationTitle("Floating Tab Bar")
            .background(Color.primary.opacity(0.07))
            .safeAreaPadding(.bottom, 60)
        }
    }
}

struct HideTabBar: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let tabController = view.tabController {
                tabController.tabBar.isHidden = true
                result()
            }
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

extension UIView {
    var tabController: UITabBarController? {
        if let controller = sequence(first: self, next: {
            $0.next
        }).first(where: { $0 is UITabBarController }) as? UITabBarController {
            return controller
        }
        return nil
    }
}

#Preview {
    ContentView()
}
