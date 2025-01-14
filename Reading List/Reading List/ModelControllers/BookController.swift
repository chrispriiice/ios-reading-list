//
//  BookController.swift
//  Reading List
//
//  Created by Chris Price on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("books.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
     func loadFromPersistentStore() {
           let fileManager = FileManager.default
           guard let url = readingListURL,
               fileManager.fileExists(atPath: url.path) else {return}
           
           do {
               let booksData = try Data(contentsOf: url)
               let decoder = PropertyListDecoder()
               books = try decoder.decode([Book].self, from: booksData)
           } catch {
               print("Error loading books data: \(error)")
           }
       }}
