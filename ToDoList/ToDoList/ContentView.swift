//
//  ContentView.swift
//  Tareas
//
//  Created by alumno on 18/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        VStack {
            Text("Add a task")
                .underline()
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
            TextEditor(text: $descriptionNote)
                .foregroundColor(.gray)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, lineWidth: 2)
                )
                .padding(.horizontal, 12)
                .cornerRadius(3)
            Button("Create") {
                notesViewModel.saveNote(description: descriptionNote)
                descriptionNote = ""
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            
            Spacer()
            
            List {
                ForEach(Array(zip(notesViewModel.notes.indices, notesViewModel.notes)), id: \.0) { index, note in
                    HStack {
                        Text(note.description)
                        Spacer()
                        if(note.isFavorited) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button (role: .destructive) {
                            notesViewModel.notes.remove(at: index)
                        } label: {
                            Label("delete", systemImage: "trash.fill")
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            notesViewModel.notes[index].isFavorited.toggle()
                        } label: {
                            Label("favorite", systemImage: "star.fill")
                        }
                        .tint(notesViewModel.notes[index].isFavorited ? .yellow : .gray)
                    }
                }.onMove (perform: move)
            }
        }
        .padding()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        notesViewModel.notes.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
