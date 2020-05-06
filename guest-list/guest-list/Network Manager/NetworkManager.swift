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
import CodableFirebase

class NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    private let mockedEventId = "78fbkFIbkjFoCPzEwj73"
    private let eventCollection = Firestore.firestore().collection("event")
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    let mockedGuest = Guest("2", "Erik2", "Eriksson", "mattias@tilert.com", "Bake 23", "12345", "snuva", "studid", "car", "hejsam", .noResponse, .guestList, .guest, .family, .family, .female, false, false)
    let mockedGuestList = [
        Guest("1", "Erik1", "Eriksson", "mattias@tilert.com", "Bake 23", "12345", "snuva", "studid", "car", "hejsam", .noResponse, .guestList, .guest, .family, .family, .female, false, false)
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
                    GuestList.shared.setGuests(to: guests)
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
        
        // Test case
//            eventCollection.document(mockedEventId).collection("guestList").getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error querying guest list from Firestore: \(error)")
//                    handler(error)
//                }
//
//                guard let documents = querySnapshot?.documents else { return }
//
//                do {
//                    var guests = [Guest]()
//                    for document in documents {
//                        guests.append(try FirebaseDecoder().decode(Guest.self, from: document))
//                    }
//                    handler(nil)
//                } catch let error {
//                    print("Error decoding guest: \(error)")
//                    handler(error)
//                }
//            }
    }
    
    /// Add new guest and update existing
    func updateGuestList(with guest: Guest, handler: @escaping (Error?) -> ()) {
        guard let data = try? FirebaseEncoder().encode(guest) as? [String:Any] else {
            print("Error encoding guest")
            handler(NetworkError.failedEncoding)
            return
        }
        
        eventCollection.document(mockedEventId).collection("guestList").document(guest.id).setData(data, merge: true) { (error) in
            if let error = error {
                print("Error adding guest to Firestore: \(error)")
                handler(error)
            } else {
                GuestList.shared.setGuest(to: guest)
                handler(nil)
            }
        }
    }
    
    // Removing guests also has to be done in linked guests
//    func removeGuest(with id: String) {
//
//    }
}
