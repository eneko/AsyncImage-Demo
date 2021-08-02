//
//  ContentView.swift
//  Shared
//
//  Created by Eneko Alonso on 7/27/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct ModalView: View {
    let imageURL: URL?
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color.purple.opacity(0.1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}


@available(iOS 15.0, *)
struct ContentView: View {
    @State var modal: Bool = false
    let imageURL = URL(string: "https://ukmadcat.com/wp-content/uploads/2019/04/sleepy-cat.jpg")
    var body: some View {
        List {
            Text("Hello")
            ForEach(0..<10) { index in
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Color.purple.opacity(0.1)
                    }
                }
                .padding()
                .onTapGesture {
                    modal = true
                }
            }
        }
        .sheet(isPresented: $modal) {
            //
        } content: {
            ModalView(imageURL: imageURL)
        }

    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
