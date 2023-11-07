//
//  NewGameView.swift
//  SwiftDataDemo
//
//  Created by Leonard McCook-Carr on 11/7/23.
//

import SwiftUI

struct NewGameView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var developer = ""
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewGameView()
}
