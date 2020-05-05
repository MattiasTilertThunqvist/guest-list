//
//  NetworkManager.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-04-20.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    private let mockedEventId = "78fbkFIbkjFoCPzEwj73"
    private let eventCollection = Firestore.firestore().collection("event")
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    let mockedGuest = Guest("2", "Erik2", "Eriksson", "mattias@tilert.com", "Bake 23", "12345", "snuva", "studid", "car", "hejsam", .NoResponse, .GuestList, .Guest, .Family, .Family, .Female, false, false)
    let mockedGuestList = [
        Guest("1", "Erik1", "Eriksson", "mattias@tilert.com", "Bake 23", "12345", "snuva", "studid", "car", "hejsam", .NoResponse, .GuestList, .Guest, .Family, .Family, .Female, false, false)
    ]
    
    func getGuestList(handler: @escaping (Error?) -> ()) {
        eventCollection.document(mockedEventId).collection("guestList").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying guest list from Firestore: \(error)")
                handler(error)
            }
            
            let result = Result {
                try querySnapshot?.documents.compactMap {
                    try $0.data(as: Guest.self)
                }
            }
            
            switch result {
            case .success(let guests):
                if let guests = guests {
                    // Add list to singelton
                    handler(nil)
                } else {
                    print("Error: Guest documents does not exist.")
                    handler(NetworkError.noDocument)
                }
            case .failure(let error):
                print("Error decoding guest: \(error)")
                handler(error)
            }
            
        }
    }
    
    func addGuestToList(_ guest: Guest, handler: @escaping (Error?) -> ()) {
        
    }
}
