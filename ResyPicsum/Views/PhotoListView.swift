//
//  PhotoListView.swift
//  ResyPicsum
//
//  Created by Shahab Darvish   on 1/15/25.
//

import SwiftUI

struct PhotoListView: View {
    @ObservedObject var viewModel: PhotoListViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.photos) { photo in
                NavigationLink(destination: PhotoDetailView(photo: photo)) {
                    VStack(alignment: .leading) {
                        Text("fileName: \(photo.fileName)")
                        Text("imageURL: \(photo.downloadUrl)")
                            .foregroundStyle(.gray)
                        HStack {
                            VStack {
                                Text("photo height: \(photo.height)")
                                Text("photo width: \(photo.width)")
                            }
                            Text(photo.isLandscape ? "Landscape" : "Portrait")
                        }
                    }
                }
            }
            .task {
                await viewModel.onTask()
            }
            .navigationTitle("Photo List")
        }
    }
}

#Preview {
    PhotoListView(viewModel: .init(photoService: MockPhotoService()))
}

