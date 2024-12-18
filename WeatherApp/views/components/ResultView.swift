//
//  ResultView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct ResultView: View {

    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.city)
                        .font(.subheadline)
                    Text(viewModel.temperature)
                        .font(.title)
                }
                Spacer()
                AsyncImage(url: viewModel.iconUrl) { data in
                    data.image?.resizable()
                        .scaledToFill()
                        .frame(width: 83, height: 67)
                }
            }
            .padding(16)
            .frame(width: 320, height: 117)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0)
            )
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(hex: "#F2F2F2")))
            .onTapGesture {
                viewModel.state = .cached
            }
        }.padding(.top, 32)
        Spacer()
    }
}
