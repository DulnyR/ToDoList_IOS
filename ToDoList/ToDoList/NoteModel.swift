//
//  NoteModel.swift
//  Tareas
//
//  Created by alumno on 18/10/24.
//

import Foundation

struct NoteModel: Codable, Identifiable {
    let id: String
    var isFavorited: Bool
    let description: String
    
    init(id: String = UUID().uuidString, isFavorited: Bool = false, description: String) {
        self.id = id
        self.isFavorited = isFavorited
        self.description = description
    }
}
