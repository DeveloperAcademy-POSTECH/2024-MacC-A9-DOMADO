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
//        RentView(viewModel: RentViewModel(
//                 onComplete: vm.handleScanResult,
//                 onDismiss: vm.dismissQRScanner
//             ))
        
        VStack{
            HStack{
                Spacer()
                
                Button {
                    vm.dismissQRScanner()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            Spacer()
            Button {
                vm.handleScanResult()
            } label: {
                Text("자전거 스캔")
            }

        }
    }
}
