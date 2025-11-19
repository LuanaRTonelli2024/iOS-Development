//
//  ContentView.swift
//  Custom Bottom Navigation
//
//  Created by user285344 on 11/19/25.
//

import SwiftUI

struct ContentView: View {
    //step 1
    enum Tab {
        case home, settings, search
    }
    
    //step 2
    @State private var selected: Tab = .home
    @State private var isSearching: Bool = false //for the search box
    @State private var query: String = "" //will be binded ($query) to the textfield
    @FocusState private var searchFocused: Bool //this is will initia

    var body: some View {
        ZStack {
            Group {
                switch selected {
                case .home:
                    Text("🏠 Home")
                        .font(.largeTitle.bold())
                        .background(Color(.systemBackground))
                case .settings:
                    Text("⚙️ Settings")
                        .font(.largeTitle.bold())
                        .background(Color(.systemBackground))
                case .search:
                    VStack(alignment: .leading, spacing: 12){
                        Text("Search")
                            .font(.largeTitle.bold())
                        
                        if query.isEmpty{
                            Text("Type Something to Search...")
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Results for: \(query)")
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemBackground))
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            //Floating Botton Navigation
            VStack{
                Spacer() //push down everything
                HStack(spacing: 12){
                    //Home
                    TabButton(title: "Home", system: "house.fill", active: selected == .home) {
                        withAnimation(.easeInOut) {
                            selected = .home
                            
                            //collapse the search box
                            collapseSearch()
                        }
                    }
                    
                    //Setting
                    TabButton(title: "Settings", system: "gearshape.fill", active: selected == .settings) {
                        withAnimation(.easeInOut) {
                            selected = .settings
                            
                            //collapse the search box
                            collapseSearch()
                        }
                    }
                    
                    //Spacer
                    Spacer(minLength: 0)
                    
                    //Search botton (expanded)
                    if isSearching {
                        HStack(spacing: 8){
                            Image(systemName: "magnifyingglass")
                            TextField("Search...", text: $query)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .focused($searchFocused)
                            Button {
                                withAnimation(.easeInOut) {
                                    //collapse the search
                                    collapseSearch()
                                    selected = .home
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 12)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground)))
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    } else{
                        Button{
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                isSearching = true
                                selected = .search
                                searchFocused = false
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.primary)
                                .padding(10)
                                .background(Circle().fill(Color(.secondarySystemBackground)))
                        }.buttonStyle(.plain)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: 8)
                .padding(.horizontal)
            }.padding(.top, 0)
        }
    }
    
    private func collapseSearch() {
        query = ""
        searchFocused = false
        isSearching = false
    }
}

//custom Tab View
struct TabButton: View {
    let title: String
    let system: String //system image name
    let active: Bool //button is clicked or not
    let action: () -> Void //a null type function
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4){
                Image(systemName: system)
                    .font(.system(size: 18, weight: .semibold))
                
                Text(title)
                    .font(.caption2.bold())
            }
            .foregroundStyle(active ? .blue : .secondary)
            .frame(width: 72)
            .padding(.vertical, 2)
        }.buttonStyle(.plain)
    }
}

#Preview {
    ContentView()
}
