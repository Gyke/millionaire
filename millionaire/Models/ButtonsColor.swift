//
//  ButtonsColor.swift
//  millionaire
//
//  Created by Sergey on 08.02.2023.
//

import Foundation
import UIKit

enum ButtonColor {
    case red
    case green
    case grey
    case blue
}
extension ButtonColor {
    public var image: UIImage? {
        switch self {
        case .red:
            return UIImage(named: "Rectangle yellow")
        case .green:
            return UIImage(named: "Rectangle green")
        case .grey:
            return UIImage(named: "Rectangle white")
        case .blue:
            return UIImage(named: "Rectangle blue")
        }
    }
}

