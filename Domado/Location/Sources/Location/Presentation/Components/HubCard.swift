//
//  HubDetailCard.swift
//  Location
//
//  Created by yoomin on 11/15/24.
//

import SwiftUI

struct HubCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hub 정보")
                .font(.title2)
            Text("사용 가능한 자전거: 3대")
            StationView()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    HubCard()
}
