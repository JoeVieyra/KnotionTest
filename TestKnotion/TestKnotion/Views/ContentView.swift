//
//  ContentView.swift
//  TestKnotion
//
//  Created by user264681 on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var people: [Person] = Person.allPeople
    @State private var showingAddPerson = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(people, id: \.name) { person in
                        NavigationLink(destination: DetailView(people: $people,person: person)) {
                            PersonRow(person: person)
                        }
                        .padding(3)
                    }
                }
            }
            .navigationTitle("Lista de Usuarios")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddPerson.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView(people: $people)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
