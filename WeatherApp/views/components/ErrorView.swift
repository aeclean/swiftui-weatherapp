//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Text("Could not find the city.")
                .font(.headline)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        })
    }
}
