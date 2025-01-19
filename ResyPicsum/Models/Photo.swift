//
//  Photo.swift
//  ResyPicsum
//
//  Created by Shahab Darvish   on 1/15/25.
//

import Foundation

struct Photo: Identifiable, Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let downloadUrl: URL
    
    var fileName: String {
        "\(id).jpeg"
    }
    
    var isLandscape: Bool {
        width > height
    }
}
