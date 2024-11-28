//
//  MapDisplayable.swift
//  Location
//
//  Created by yoomin on 11/11/24.
//
import Foundation

// MARK: - Map Display Protocol
public protocol MapDisplayable {
    var coordinate: (latitude: Double, longitude: Double)? { get }
    var markerType: MarkerType { get }
}

public enum MarkerType {
    case hub(availableBikes: Int)
    case hiBike(homeHubName: String)
}
