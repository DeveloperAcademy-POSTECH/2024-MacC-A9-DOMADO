//
//  File.swift
//  Core
//
//  Created by 이종선 on 11/19/24.
//

import Foundation

public enum Environment {
    public enum Values {
        public static var baseURL: String {
            // 메인 앱의 번들에서 환경변수 접근
            guard let urlString = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
                fatalError("API_BASE_URL not found in Main App's Info.plist")
            }
            return urlString
        }
    }
}
