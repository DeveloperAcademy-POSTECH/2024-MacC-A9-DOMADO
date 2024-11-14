//
//  HiBikeDetailCard.swift
//  Location
//
//  Created by yoomin on 11/15/24.
//

import SwiftUI

struct HiBikeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("자전거 이름: Bike 1")
            Text("반납 위치: Hub A")
            Text("🔋 배터리: 80%")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    HiBikeCard()
}
