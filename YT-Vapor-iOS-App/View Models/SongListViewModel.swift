//
//  SongListViewModel.swift
//  YT-Vapor-iOS-App
//
//  Created by Yemi Ajibola on 8/11/23.
//

import SwiftUI

class SongListViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songResponse: [Song] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
            guard let songID = songs[i].id else { return }
            
            let urlString = Constants.baseURL + Endpoints.songs + "/\(songID)"
            
            guard let url = URL(string: urlString) else {
                return 
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: songID, url: url)
                } catch {
                    print("❌ error: \(error)")
                } // do-catch
            } // Task
        }// for-each
        
        
    }
}
