//
//  Color.swift
//  DailyTale
//
//  Created by Hugo de Groot on 12/08/2023.
//

import Foundation
import SwiftUI
import UIKit

extension Color: RawRepresentable {
    static let backgroundColor = Color("BackgroundColor")
    static let primaryColor = Color("PrimaryColor")
    static let secondaryColor = Color("SecondaryColor")
    static let highlightColor: Color = Color("HighlightColor")
    static let textColor: Color = Color("GridTextColor")
    
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .black
            return
        }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) ?? .black
            self = Color(color)
        } catch {
            self = .black
        }
    }
    
    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}
