//
//  MessageBubbleShape.swift
//  MessengerApp
//
//  Created by Родион Холодов on 24.11.2025.
//

import SwiftUI

struct MessageBubbleShape: Shape {
    let isFromCurrentUser: Bool
    let cornerRadius: CGFloat = 20

    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height

        let path = UIBezierPath()

        if isFromCurrentUser {
            path.move(to: CGPoint(x: width - cornerRadius, y: height))
            path.addLine(to: CGPoint(x: cornerRadius, y: height))
            path.addCurve(to: CGPoint(x: 0, y: height - cornerRadius), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8))
            path.addLine(to: CGPoint(x: 0, y: cornerRadius))
            path.addCurve(to: CGPoint(x: cornerRadius, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0))
            path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
            path.addCurve(to: CGPoint(x: width - 4, y: cornerRadius), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 4, y: 8))
            path.addLine(to: CGPoint(x: width - 4, y: height - 11))

            // Tail
            path.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            path.addCurve(to: CGPoint(x: width - 11.0, y: height - 4.0), controlPoint1: CGPoint(x: width - 4.0, y: height + 0.5), controlPoint2: CGPoint(x: width - 8, y: height - 1))
            path.addCurve(to: CGPoint(x: width - cornerRadius + 5, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - cornerRadius, y: height))
        } else {
            path.move(to: CGPoint(x: cornerRadius, y: height))
            path.addLine(to: CGPoint(x: width - cornerRadius, y: height))
            path.addCurve(to: CGPoint(x: width, y: height - 20), controlPoint1: CGPoint(x: width - 8, y: height), controlPoint2: CGPoint(x: width, y: height - 8))
            path.addLine(to: CGPoint(x: width, y: cornerRadius))
            path.addCurve(to: CGPoint(x: width - cornerRadius, y: 0), controlPoint1: CGPoint(x: width, y: 8), controlPoint2: CGPoint(x: width - 8, y: 0))
            path.addLine(to: CGPoint(x: cornerRadius, y: 0))
            path.addCurve(to: CGPoint(x: 4, y: cornerRadius), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 4, y: 8))
            path.addLine(to: CGPoint(x: 4, y: height - 11))

            // Tail
            path.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
            path.addCurve(to: CGPoint(x: 11.0, y: height - 4.0), controlPoint1: CGPoint(x: 4.0, y: height + 0.5), controlPoint2: CGPoint(x: 8, y: height - 1))
            path.addCurve(to: CGPoint(x: cornerRadius + 5, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: cornerRadius, y: height))
        }

        return Path(path.cgPath)
    }
}
