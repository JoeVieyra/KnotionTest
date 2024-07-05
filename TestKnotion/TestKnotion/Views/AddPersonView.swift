//
//  AddPersonView.swift
//  TestKnotion
//
//  Created by user264681 on 7/5/24.
//

import SwiftUI

struct AddPersonView: View {
    @Binding var people: [Person]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var avatar: String = ""
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var age: String = ""
    @State private var job: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información Personal")) {
                    TextField("Avatar URL", text: $avatar)
                    TextField("Nombre", text: $name)
                    TextField("Descripción", text: $description)
                    TextField("Edad", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Trabajo", text: $job)
                    TextField("Teléfono", text: $phone)
                    TextField("Dirección", text: $address)
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancelar")
                },
                trailing: Button(action: {
                    savePerson()
                }) {
                    Text("Guardar")
                }
                .disabled(!isValidInput())
            )
            .navigationTitle("Agregar Perfil")
        }
    }
    
    func savePerson() {
        guard let ageInt = Int(age) else {
            return
        }
        let newPerson = Person(avatar: avatar, name: name, description: description, age: ageInt, job: job, phone: phone, address: address)
        people.append(newPerson)
        saveToJSON()
        presentationMode.wrappedValue.dismiss()
    }
    
    func saveToJSON() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(people)
            let url = getDocumentsDirectory().appendingPathComponent("example.json")
            try data.write(to: url)
        } catch {
            print("Error al guardar los datos: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func isValidInput() -> Bool {
        // Validate input fields as needed
        return !name.isEmpty && !age.isEmpty
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(people: .constant(Person.allPeople))
    }
}
