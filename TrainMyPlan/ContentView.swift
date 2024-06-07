//
//  ContentView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                EditView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Edit")
                    }
                
                GoView()
                    .tabItem {
                        Image(systemName: "play.tv")
                        Text("Go")
                    }
            }
        }
}

#Preview {
    ContentView()
}
