//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State var searchQuery: String = ""

    var body: some View {
        VStack(alignment: .center) {

            SearchView(searchText: $searchQuery) {
                viewModel.fetchWeather(searchQuery)
            }
            .frame(height: 46)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0)
            )
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(hex: "#F2F2F2")))

            switch viewModel.state {
            case .idle:
                EmptyView()
            case .success:
                ResultView(viewModel: viewModel)
            case .cached:
                CachedView(viewModel: viewModel)
            case .failure:
                ErrorView()
            }

            Spacer()

        }.onAppear {
             viewModel.loadLastWeather()
        }.padding(26)
    }
}
