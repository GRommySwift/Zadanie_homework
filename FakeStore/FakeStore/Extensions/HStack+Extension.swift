//
//  HStack+Extension.swift
//  FakeStore
//
//  Created by Roman on 19/10/2024.
//

import SwiftUI

extension HStack {
    init(spacing theme: Padding, @ViewBuilder content: () -> Content) {
        self.init(spacing: theme.rawValue, content: content)
    }
}
