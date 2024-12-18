//
//  SearchView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("",
                      text: $searchText,
                      prompt: Text("Search Location").foregroundColor(Color(hex: "#C4C4C4")))
                .font(.caption)
                .padding()
                .foregroundColor(Color(hex: "#2C2C2C"))

            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .padding()
                    .clipShape(.circle)
                    .colorMultiply(Color.black.opacity(0.3))
            }
        }
    }
}
