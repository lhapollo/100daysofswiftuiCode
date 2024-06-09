//
//  ContentView.swift
//  BucketList
//
//  Created by Lexi Han on 2024-06-04.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion (
            center: CLLocationCoordinate2D(latitude: 43, longitude: -79),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewModel.isHybrid ? .hybrid : .standard)
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                        }
                    }
                }
                .overlay(alignment: .topTrailing){
                   VStack {
                        Text("Toggle Map")
                           .foregroundStyle(viewModel.isHybrid ? .white : .black)
                        Toggle("Toggle Map", isOn: $viewModel.isHybrid)
                            .labelsHidden()
                    }
                   .padding()
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
