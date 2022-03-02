//
//  ContentView.swift
//  Book-App
//
//  Created by Furkan Yıldırım on 28.02.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.name, ascending: true)],
        animation: .default
    )
    
    private var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        Text("WIP \(book.name!)")
                        Image(uiImage: UIImage(data: book.image!)!)
                            .resizable()
                            .frame(width: 50, height: 50)
                    } label: {
                        Text(book.name!)
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNewBookView()) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    func deleteBook(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
