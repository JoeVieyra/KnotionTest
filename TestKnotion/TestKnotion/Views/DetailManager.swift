//
//  DetailManager.swift
//  TestKnotion
//
//  Created by user264681 on 7/5/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var people: [Person]
    var person: Person
    @StateObject private var imageLoader = ImageLoader()
    @State private var avatar: URL?
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .clipped()
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                }
                
                
                Text(person.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 2)
                
                Text("\(person.job) \(person.description) ")
                    .padding(.top, 2.0)
                
                HStack(){
                    Text("Edad: ")
                        .fontWeight(.bold)
                        .padding(.top, 2.0)
                    Text("\(person.age)")
                }
                
                HStack(){
                    Text("Telefono: ")
                        .fontWeight(.bold)
                        .padding(.top, 2.0)
                    Text("\(person.phone)")
                }
                
                HStack(){
                    Text("Direccion: ")
                        .fontWeight(.bold)
                        .padding(.top, 2.0)
                    Text("\(person.address)")
                }
 
            }
           
        }
        
        .onAppear {
            if let url = URL(string: person.avatar) {
                imageLoader.loadImage(from: url)
            }
        }
       // .navigationTitle("\(person.name)")
        .navigationBarItems(trailing: Button(action: {
            showAlert = true        }) {
                Text("\(person.name)")
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.horizontal, 80.0)
                    .colorMultiply(.black)
                    
                Image(systemName: "trash")
                    .foregroundColor(.red)
            })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Eliminar contacto"),
                message: Text("¿Estás seguro de que quieres eliminar este contacto?"),
                primaryButton: .destructive(Text("Eliminar")) {
                    deletePerson()
                    DataManager.shared.deletePerson(person: person, from: &people)
                },
                secondaryButton: .cancel()
            )
        }
    }
    func deletePerson() {
        guard let index = people.firstIndex(where: { $0.id == person.id }) else { return }
        
            people.remove(at: index)
            DataManager.savePeople(people)
            
    }
    
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(people: .constant(DataManager.loadPeople()), person: DataManager.loadPeople().first!)
    }
}
