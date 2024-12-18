//
//  EmptyView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("No City Selected")
                .font(.title)
            Text("Please Search For a City")
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
        }
    }
}
