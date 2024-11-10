//
//  QRScannerView.swift
//  Domado
//
//  Created by 이종선 on 11/2/24.
//

import SwiftUI

struct QRScannerView: View {
    
    @StateObject var vm: QRScannerViewModel
    
    var body: some View {
        VStack{
            HStack{
                
                Spacer()
                
                Button {
                    vm.dismissQRScanner()
                } label: {
                    Image(systemName: "xmark")
                }

            }
            .padding()
            Spacer()
            
            Text("QR 코드 스캐너")
            
            Spacer()
            
        }
    }
}
