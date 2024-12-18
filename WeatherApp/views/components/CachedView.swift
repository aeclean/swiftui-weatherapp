//
//  CachedView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct CachedView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            AsyncImage(url: viewModel.iconUrl) { data in
                data.image?.resizable()
                    .scaledToFit()
                    .frame(width: 123)
            }
            Text(viewModel.city)
                .font(.title2)

            Text(viewModel.temperature)
                .font(.largeTitle)

            Spacer()
                .frame(height: 35)

            HStack {
                VStack {
                    Text("Humidity")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#C4C4C4"))
                    Text(viewModel.humidity)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9A9A9A"))
                }
                Spacer()
                VStack {
                    Text("UV")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#C4C4C4"))
                    Text(viewModel.uv)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9A9A9A"))
                }
                Spacer()
                VStack {
                    Text("Feels Like")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#C4C4C4"))
                    Text(viewModel.feelsLike)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9A9A9A"))
                }
            }
            .frame(width: 270)
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0)
            )
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(hex: "#F2F2F2")))

            Spacer()
        }
    }
}
