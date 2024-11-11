//
//  MapDisplayable.swift
//  Location
//
//  Created by yoomin on 11/11/24.
//
import Foundation

// 지도에 표시될 항목들의 공통 인터페이스를 정의
protocol MapDisplayable {
    var coordinate: (latitude: Double, longitude: Double)? { get }
//    var displayName: String { get }
}
