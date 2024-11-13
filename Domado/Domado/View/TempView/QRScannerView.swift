//
//  QRScannerView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI
import Rent

struct QRScannerView: View {
    
    @StateObject var vm: QRScannerViewModel
    
    var body: some View {
        RentView(viewModel: RentViewModel(
                 onComplete: vm.handleScanResult,
                 onDismiss: vm.dismissQRScanner
             ))
    }
}
