//
//  Untitled.swift
//  Rent
//
//  Created by 고재보 on 11/5/24.
//

import SwiftUI
import CodeScanner
import AVFoundation

public struct RentView: View {
    @StateObject private var viewModel: RentViewModel
   
   public init(viewModel: RentViewModel) {
       _viewModel = StateObject(wrappedValue: viewModel)
   }
   
   public var body: some View {
       ZStack {
           // 카메라 뷰
           CodeScannerView(
               codeTypes: [.qr],
               simulatedData: "BIKE-123",
               isTorchOn: viewModel.isTorchOn,
               completion: viewModel.handleScan
           )
           
           // 반투명한 오버레이와 구멍
           GeometryReader { geometry in
               let boxWidth: CGFloat = 280
               let boxHeight: CGFloat = 280
               let cornerRadius: CGFloat = 16
               let cornerLength: CGFloat = 50
               
               let rect = CGRect(
                   x: (geometry.size.width - boxWidth) / 2,
                   y: (geometry.size.height - boxHeight) / 2,
                   width: boxWidth,
                   height: boxHeight
               )
               
               Path { path in
                   // 전체 화면 사각형
                   path.addRect(CGRect(origin: .zero, size: geometry.size))
                   // 중앙 사각형을 잘라내기 (둥근 모서리로)
                   path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
               }
               .fill(style: FillStyle(eoFill: true))
               .foregroundColor(Color.black.opacity(0.5))
               
               // 모서리 표시
               // Top Left Corner
               Path { path in
                   let point = CGPoint(x: rect.minX, y: rect.minY)
                   path.move(to: CGPoint(x: point.x + cornerLength, y: point.y))
                   path.addArc(
                       center: CGPoint(x: point.x + cornerRadius, y: point.y + cornerRadius),
                       radius: cornerRadius,
                       startAngle: .degrees(270),
                       endAngle: .degrees(180),
                       clockwise: true
                   )
                   path.addLine(to: CGPoint(x: point.x, y: point.y + cornerLength))
               }
               .stroke(Color.blue, lineWidth: 10)
               
               // Top Right Corner
               Path { path in
                   let point = CGPoint(x: rect.maxX, y: rect.minY)
                   path.move(to: CGPoint(x: point.x - cornerLength, y: point.y))
                   path.addArc(
                       center: CGPoint(x: point.x - cornerRadius, y: point.y + cornerRadius),
                       radius: cornerRadius,
                       startAngle: .degrees(270),
                       endAngle: .degrees(0),
                       clockwise: false
                   )
                   path.addLine(to: CGPoint(x: point.x, y: point.y + cornerLength))
               }
               .stroke(Color.blue, lineWidth: 10)
               
               // Bottom Left Corner
               Path { path in
                   let point = CGPoint(x: rect.minX, y: rect.maxY)
                   path.move(to: CGPoint(x: point.x + cornerLength, y: point.y))
                   path.addArc(
                       center: CGPoint(x: point.x + cornerRadius, y: point.y - cornerRadius),
                       radius: cornerRadius,
                       startAngle: .degrees(90),
                       endAngle: .degrees(180),
                       clockwise: false
                   )
                   path.addLine(to: CGPoint(x: point.x, y: point.y - cornerLength))
               }
               .stroke(Color.blue, lineWidth: 10)
               
               // Bottom Right Corner
               Path { path in
                   let point = CGPoint(x: rect.maxX, y: rect.maxY)
                   path.move(to: CGPoint(x: point.x - cornerLength, y: point.y))
                   path.addArc(
                       center: CGPoint(x: point.x - cornerRadius, y: point.y - cornerRadius),
                       radius: cornerRadius,
                       startAngle: .degrees(90),
                       endAngle: .degrees(0),
                       clockwise: true
                   )
                   path.addLine(to: CGPoint(x: point.x, y: point.y - cornerLength))
               }
               .stroke(Color.blue, lineWidth: 10)
           }
           .ignoresSafeArea()
           
           VStack(spacing: 15) {
               // 상단 닫기 버튼
               HStack {
                   Spacer()
                   Button {
                       viewModel.dismiss()
                   } label: {
                       Image(systemName: "xmark")
                           .font(.system(size: 21))
                           .foregroundColor(.blue)
                           .padding(8)
                   }
                   .padding(.trailing, 15)
                   .padding(.top, 15)
               }
               
               Spacer()
               
               // QR 스캔 안내 텍스트
               VStack(alignment: .leading, spacing: 8) {
                   Text("QR코드 찍어주세요")
                       .font(.title.bold())
                       .foregroundColor(.white)
                   
                   Text("QR을 찍고 하이파이브!\n이제 멋진 라이딩을 시작할 시간이에요")
                       .font(.subheadline)
                       .foregroundColor(.white.opacity(0.9))
                       .multilineTextAlignment(.leading)
               }
               .padding(.bottom, 20)
               
               // QR 스캔 프레임 공간
               Spacer().frame(height: 280)
               
               Spacer()
               
               // 하단 버튼들
               HStack(alignment: .top ,spacing: 100) {
                   Button {
                       // 코드 입력 동작
                   } label: {
                       VStack(spacing: 10) {
                           Circle()
                               .fill(Color.blue)
                               .frame(width: 56, height: 56)
                               .overlay(
                                   Image(systemName: "qrcode")
                                       .font(.system(size: 24))
                                       .foregroundColor(.white)
                               )
                           Text("코드 번호\n직접 입력하기")
                               .font(.caption)
                               .multilineTextAlignment(.center)
                               .foregroundColor(.white)
                       }
                   }
                   
                   Button {
                       viewModel.isTorchOn.toggle()
                   } label: {
                       VStack(spacing: 10) {
                           Circle()
                               .fill(Color.blue)
                               .frame(width: 56, height: 56)
                               
                               .overlay(
                                Image(systemName: viewModel.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                                       .font(.system(size: 24))
                                       .foregroundColor(.white)
                               )
                           Text("손전등")
                               .font(.caption)
                               .foregroundColor(.white)
                       }
                   }
               }
               .padding(.bottom, 50)
           }
           .padding(.top, 20)
       }
       .ignoresSafeArea()
       .alert("스캔 결과", isPresented: $viewModel.showAlert) {
           Button("확인") { viewModel.dismissAlert() }
       } message: {
           Text(viewModel.alertMessage)
       }
   }
   
}

