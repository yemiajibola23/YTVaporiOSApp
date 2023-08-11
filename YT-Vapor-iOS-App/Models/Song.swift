//
//  Song.swift
//  YT-Vapor-iOS-App
//
//  Created by Yemi Ajibola on 8/11/23.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    var title: String
}
