//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Sharmin Khan on 31.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

//Detail screen
struct CharacterDetailView: View {
    
    //variables to get the data from tableView rows
    var name: String
    var description: String
    var image: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            KFImage(URL(string: image)!).resizable().frame(width: 250, height: 250).scaledToFit()
            Text(name)
                .font(.title)
            Text(description)
                .font(.subheadline).multilineTextAlignment(.center)
        }.padding()
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(name: "", description: "", image: "")
    }
}
