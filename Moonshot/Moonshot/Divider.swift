//
//  Divider.swift
//  Moonshot
//
//  Created by Lexi Han on 2024-05-09.
//

import Foundation
import SwiftUI

struct Divider: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.lightBackground)
                .padding(.vertical)
        }
    }
}
