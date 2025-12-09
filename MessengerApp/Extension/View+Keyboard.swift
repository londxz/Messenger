//
//  KeyboardExtension.swift
//  MessengerApp
//
//  Created by Родион Холодов on 09.12.2025.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
