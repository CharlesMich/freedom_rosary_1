//
//  TopicModel.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

struct Topic: Identifiable, Codable {
    let name: String
    let jsonFileName: String
    let whoShouldMeditate: String
    let keywords: [String]

    var id: String { name }
}


