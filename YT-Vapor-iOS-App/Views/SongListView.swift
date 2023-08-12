//
//  SongListView.swift
//  YT-Vapor-iOS-App
//
//  Created by Yemi Ajibola on 8/10/23.
//

import SwiftUI

struct SongListView: View {
    @StateObject var viewModel = SongListViewModel()
    @State var modal: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.songs) { song in
                    Button {
                        modal = .update(song)
                    } label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    } // label
                } // for-each
                .onDelete(perform: viewModel.delete)
            } // list
            .navigationTitle(Text("🎵 Songs"))
            .toolbar {
                Button {
                    modal = .add
                } label: {
                    Label("Add Song", systemImage: "plus.circle")

                }
            } // toolbar
        } // navigation view
        .sheet(item: $modal, onDismiss: {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print("🚫 Error: \(error)")
                } // do-catch
            } // task
        }) { modal in
            switch modal {
            case .add:
                AddUpdateSongView(viewModel: AddUpdateSongViewModel())
            case .update(let song):
                AddUpdateSongView(viewModel: AddUpdateSongViewModel(currentSong: song))
            } // switch
            
        } //sheet
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print("🚫 Error: \(error)")
                } // catch
            } // task
        }// on appear
    } // body
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
