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
                .frame(width: 200, height: 300)
            
            Text(bookName)
            Text(bookAuthor)
            Text(bookYear)
            Text(bookPageCount)
        }
        .padding(.horizontal, 20)
        .foregroundColor(Color.black)
    }
}
