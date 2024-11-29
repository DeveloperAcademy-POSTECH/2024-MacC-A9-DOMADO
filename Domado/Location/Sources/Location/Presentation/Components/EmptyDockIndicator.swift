//
//  File.swift
//  Location
//
//  Created by 이종선 on 11/29/24.
//

import SwiftUI

struct EmptyDockIndicator: View {
    var body: some View {
        Circle()
            .stroke(Color.grayScaleLightHover, lineWidth: 2)
            .frame(width: 54, height: 54)
    }
}
