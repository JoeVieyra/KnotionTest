//
//  PersonRow.swift
//  TestKnotion
//
//  Created by user264681 on 7/5/24.
//

import SwiftUI

struct PersonRow: View {
    let person: Person
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        HStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(person.name)
                    .bold()
                Text(person.job)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            if let url = URL(string: person.avatar) {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(person: Person.samplePerson)
    }
}
