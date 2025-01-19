//
//  PhotoDetailView.swift
//  ResyPicsum
//
//  Created by Shahab Darvish   on 1/15/25.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if photo.isLandscape {
                Spacer()

                displayImage()
                
                Text(photo.author)
                    .font(.headline)
                    .padding(.horizontal, 8)
                
                Spacer()
                
            } else {
                displayImage(imageAlignment: .top)
                
                Text(photo.author)
                    .font(.headline)
                    .padding(.horizontal, 8)
                
                Spacer()
            }
            
        }
        .navigationTitle("Photo Detail (\(photo.isLandscape ? "Landscape" : "Protrait"))")
        .navigationBarTitleDisplayMode(.inline)
    }

    func displayImage(
        imageAlignment: Alignment = .center
    ) -> some View {
        AsyncImage(url: photo.downloadUrl) { phase in
            switch phase {
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: .infinity,
                        alignment: imageAlignment
                    )
            case .failure:
                Text("Failed to load image.")
                    .foregroundColor(.red)
                    .font(.caption)
            @unknown default:
                EmptyView()
            }
        }
    }
}



