//
//  Util+ViewAlign.swift
//  ResyPicsum
//
//  Created by Shahab Darvish   on 1/18/25.
//

import Foundation
import SwiftUICore

extension View {
    func getAlignmentForImage(for photo: Photo) -> Alignment {
        return photo.isLandscape ? .center : .top
    }
}
