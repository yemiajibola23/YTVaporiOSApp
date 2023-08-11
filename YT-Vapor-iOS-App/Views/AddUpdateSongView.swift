//
//  AddUpdateSongView.swift
//  YT-Vapor-iOS-App
//
//  Created by Yemi Ajibola on 8/11/23.
//

import SwiftUI

struct AddUpdateSongView: View {
    @ObservedObject var viewModel: AddUpdateSongViewModel
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            TextField("Song Title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}

struct AddUpdateSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSongView(viewModel: AddUpdateSongViewModel())
    }
}
