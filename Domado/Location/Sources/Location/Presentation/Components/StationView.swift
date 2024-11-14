//
//  StationView.swift
//  Location
//
//  Created by yoomin on 11/15/24.
//

import SwiftUI

struct StationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Station 1")
                .font(.headline)
            HStack {
                Dock(number: 1, batteryLevel: 80)
                Dock(number: 2, batteryLevel: nil)
                Dock(number: 3, batteryLevel: 90)
                Dock(number: 4, batteryLevel: 75)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct Dock: View {
    let number: Int
    let batteryLevel: Int?
    
    var body: some View {
        Text(batteryLevel != nil ? "\(number): \(batteryLevel!)%" : " \(number): 비어있음")
    }
}

#Preview {
    StationView()
}
