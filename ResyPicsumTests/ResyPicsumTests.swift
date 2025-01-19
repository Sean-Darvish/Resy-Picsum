//
//  ResyPicsumTests.swift
//  ResyPicsumTests
//
//  Created by Shahab Darvish   on 1/15/25.
//

import XCTest
@testable import ResyPicsum
import SwiftUICore

@MainActor
final class ResyPicsumTests: XCTestCase {
    
    func testImageAlignment() async throws {
        let mockService = MockPhotoService()
        let photos = try await mockService.fetchPhotos()
        
        guard let landscapePhoto = photos.first, let portraitPhoto = photos.last else {
            XCTFail("Failed to retrieve mock photos")
            return
        }
        
        let landscapeView = PhotoDetailView(photo: landscapePhoto)
        let landscapeAlignment = landscapeView.body.getAlignmentForImage(for: landscapePhoto)
        XCTAssertEqual(landscapeAlignment, .center, "The alignment for landscape photo should be center.")
        
        let portraitView = PhotoDetailView(photo: portraitPhoto)
        let portraitAlignment = portraitView.body.getAlignmentForImage(for: portraitPhoto)
        XCTAssertEqual(portraitAlignment, .top, "The alignment for portrait photo should be top.")
    }
    
    func testOnTask_Success() async {
        let mockPhotoService = MockPhotoService()
        let viewModel = PhotoListViewModel(photoService: mockPhotoService)
        let expectedPhotos = try! await mockPhotoService.fetchPhotos()
        
        await viewModel.onTask()
        
        XCTAssertEqual(viewModel.photos.count, expectedPhotos.count)
        XCTAssertEqual(viewModel.photos.first?.id, expectedPhotos.first?.id)
        XCTAssertEqual(viewModel.photos.first?.author, expectedPhotos.first?.author)
    }
    
    func testOnTask_Failure() async {
        class FailingMockPhotoService: PhotoServiceProtocol {
            func fetchPhotos() async throws -> [Photo] {
                throw URLError(.cannotConnectToHost)
            }
        }
        
        let failingService = FailingMockPhotoService()
        let viewModel = PhotoListViewModel(photoService: failingService)
        
        await viewModel.onTask()
        
        XCTAssertTrue(viewModel.photos.isEmpty)
    }
    
}
