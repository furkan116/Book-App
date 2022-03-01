//
//  AddNewBookView.swift
//  Book-App
//
//  Created by Furkan Yıldırım on 28.02.2022.
//

import SwiftUI

struct AddNewBookView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var newBookName: String = ""
    @State private var newBookAuthor: String = ""
    @State private var newBookImage: String = ""
    @State private var newBookYear: String = ""
    @State private var newBookTotalPage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Book Name", text: $newBookName)
                TextField("Author", text: $newBookAuthor)
                TextField("Image", text: $newBookImage)
                TextField("Year", text: $newBookYear)
                TextField("Total Page", text: $newBookTotalPage)
                
                Button(action: {addItem()}) {
                    Text("Save")
                        .foregroundColor(Color.accentColor)
                }
            }
            .padding(.horizontal, 20)
            .foregroundColor(Color.black)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newBook = Book(context: viewContext)
            newBook.id = UUID()
            newBook.name = newBookName
            newBook.author = newBookAuthor
            newBook.year = Int16(newBookYear) ?? 0
            newBook.totalpage = Int16(newBookTotalPage) ?? 0

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddNewBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBookView()
    }
}
