//
//  VStack + Extension.swift
//  FakeStore
//
//  Created by Roman on 19/10/2024.
//

import SwiftUI

extension VStack {
    init(spacing theme: Theme, @ViewBuilder content: () -> Content) {
        self.init(spacing: theme.rawValue, content: content)
    }
}
