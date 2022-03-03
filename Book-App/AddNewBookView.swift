//
//  AddNewBookView.swift
//  Book-App
//
//  Created by Furkan Yıldırım on 28.02.2022.
//

import SwiftUI

struct AddNewBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    @State private var newBookName: String = ""
    @State private var newBookAuthor: String = ""
    @State private var newBookImage: UIImage = UIImage()
    @State private var newBookYear: String = ""
    @State private var newBookTotalPage: String = ""
    
    @State var showSheet: Bool = false
    
    @State var showAlert: Bool = false
    @State var showText: String = ""
    
    var body: some View {
        VStack {
            
            Button(action: {
                self.showSheet.toggle()
            }) {
                Text("Choose Image")
                    .foregroundColor(Color.accentColor)
            }
            HStack {
                Text("Book Name:")
                TextField("Required", text: $newBookName)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: newBookName, perform: { text in
                        self.newBookName = text.onlyLetter(stringLenght: 24)
                    })
            }
            HStack {
                Text("Author Name:")
                TextField("Required", text: $newBookAuthor)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: newBookAuthor, perform: { text in
                        self.newBookAuthor = text.onlyLetter(stringLenght: 24)
                    })
            }
            HStack {
                Text("Year:")
                TextField("Required", text: $newBookYear)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: newBookYear, perform: { text in
                        self.newBookYear = text.onlyNumber(stringLenght: 4)
                    })
            }
            HStack {
                Text("Page Count:")
                TextField("Required", text: $newBookTotalPage)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: newBookTotalPage, perform: { text in
                        self.newBookTotalPage = text.onlyNumber(stringLenght: 5)
                    })
            }
                        
            Button(action: {
                if newBookName.isEmpty {
                    showText = "Please enter book name."
                    showAlert.toggle()
                }
                else if newBookAuthor.isEmpty {
                    showText = "Please enter author name."
                    showAlert.toggle()
                }
                else if newBookYear.isEmpty {
                    showText = "Please enter book year."
                    showAlert.toggle()
                }
                else if newBookTotalPage.isEmpty {
                    showText = "Please enter book page count."
                    showAlert.toggle()
                }
                else if newBookImage.size.width == 0 {
                    showText = "Please enter book image."
                    showAlert.toggle()
                }
                else {
                    addItem()
                }}) {
                Text("Save")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 24))
            }
        }
        .padding(.horizontal, 20)
        .foregroundColor(Color.black)
        .sheet(isPresented: $showSheet) {
            ImagePicker(selectedImage: self.$newBookImage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text(showText))
        }
    }
    
    private func addItem() {
        withAnimation {
            let newBook = Book(context: viewContext)
            newBook.id = UUID()
            newBook.name = newBookName
            newBook.author = newBookAuthor
            newBook.image = newBookImage.jpegData(compressionQuality: 1.0)
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
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
