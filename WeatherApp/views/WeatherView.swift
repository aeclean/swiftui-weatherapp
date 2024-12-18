//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Aecio Lima on 18/12/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WatherViewModel()
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
                VStack(alignment: .center) {
                    Spacer()
                    Text("No City Selected")
                        .font(.title)
                    Text("Please Search For a City")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Spacer()
                }

            case .success:
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
            case .cached:
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
            case .failure:
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                    Text("Could not find the city.")
                        .font(.headline)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                })
            }

            Spacer()

        }.onAppear {
             viewModel.loadLastWeather()
        }.padding(26)
    }
}
