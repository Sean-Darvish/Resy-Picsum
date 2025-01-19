//
//  PhotoListViewModel.swift
//  ResyPicsum
//
//  Created by Shahab Darvish   on 1/15/25.
//

import Foundation

protocol PhotoServiceProtocol {
    func fetchPhotos() async throws -> [Photo]
}

class PhotoService: PhotoServiceProtocol {
    func fetchPhotos() async throws -> [Photo] {
        guard let url = URL(string: "https://picsum.photos/v2/list") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let values = try decoder.decode([Photo].self, from: data)
        print(" \(Self.self) successfully returns with \(values)")
        return values
    }
}

@MainActor
class PhotoListViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private let photoService: PhotoServiceProtocol
        
    init(photoService: PhotoServiceProtocol) {
        self.photoService = photoService
    }
    
    func onTask() async {
        do {
            self.photos = try await photoService.fetchPhotos()
        } catch {
            print("Failed to fetch photos: \(error)")
        }
    }
}

class MockPhotoService: PhotoServiceProtocol {
    func fetchPhotos() async throws -> [Photo] {
        return [
            Photo(
                id: "1",
                author: "Alejandro Escamilla",
                width: 5000,
                height: 3333,
                url: URL(string:"https://unsplash.com/photos/yC-Yzbqy7PY")!,
                downloadUrl: URL(string: "https://picsum.photos/id/0/5000/3333")!
            ),
            Photo(
                id: "23",
                author: "Alejandro Escamilla",
                width: 3887,
                height: 4899,
                url: URL(string: "https://unsplash.com/photos/8yqds_91OLw")!,
                downloadUrl: URL(string: "https://picsum.photos/id/23/3887/4899")!
            )
        ]
    }
}
