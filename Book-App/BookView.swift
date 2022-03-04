//
//  BookView.swift
//  Book-App
//
//  Created by Furkan Yıldırım on 3.03.2022.
//

import SwiftUI

struct BookView: View {

    var bookImage: UIImage
    var bookName: String
    var bookAuthor: String
    var bookYear: String
    var bookPageCount: String

    var body: some View {
        VStack {
            
            Image(uiImage: bookImage)
                .resizable()
                .aspectRatio(0.66,  contentMode: .fit)
            
            Text(bookName)
            Text("Author: \(bookAuthor)")
            Text("Year: \(bookYear)")
            Text("Total Page: \(bookPageCount)")
        }
        .navigationBarTitle("", displayMode: .inline)
        .font(.system(size: 24))
        .foregroundColor(Color.black)
    }
}
