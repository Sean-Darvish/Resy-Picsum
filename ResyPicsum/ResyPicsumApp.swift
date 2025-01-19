//
//  ResyPicsumApp.swift
//  ResyPicsum
//
//  Created by Shahab Darvish   on 1/15/25.
//

import SwiftUI

@main
struct ResyPicsumApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoListView(viewModel: .init(photoService: PhotoService()))
        }
    }
}
