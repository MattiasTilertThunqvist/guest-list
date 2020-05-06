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
import FirebaseAuth
import CodableFirebase

class NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    private lazy var uid = Auth.auth().currentUser!.uid
    private let eventCollection = Firestore.firestore().collection("event")
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    let mockedGuest = Guest("2", "Erik2", "Eriksson", "mattias@tilert.com", "Bake 23", "12345", "snuva", "studid", "car", "hejsam", .noResponse, .guestList, .guest, .family, .family, .female, false, false)
    let mockedGuestList = [
        Guest("1", "Erik1", "Eriksson", "mattias@tilert.com", "Bake 23", "12345", "snuva", "studid", "car", "hejsam", .noResponse, .guestList, .guest, .family, .family, .female, false, false)
    ]
    
    func getGuestList(handler: @escaping (Error?) -> ()) {
        eventCollection.document(uid).collection("guestList").getDocuments { (querySnapshot, error) in
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
    }
    
    /// Add new guest and update existing
    func updateGuestList(with guest: Guest, handler: @escaping (Error?) -> ()) {
        guard let data = try? FirebaseEncoder().encode(guest) as? [String:Any] else {
            print("Error encoding guest")
            handler(NetworkError.failedEncoding)
            return
        }
        
        eventCollection.document(uid).collection("guestList").document(guest.id).setData(data, merge: true) { (error) in
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


// MARK: Auth

extension NetworkManager {
    func isAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func createUser(withEmail email: String, password: String, handler: @escaping (User?, Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Error creating user: \(error)")
                handler(nil, error)
                return
            }
        
            let user = authResult?.user
            handler(user, nil)
        }
    }
    
    func signOut(handler: @escaping (Error?) -> ()) {
        do {
            try Auth.auth().signOut()
            handler(nil)
        } catch (let error) {
            print("Error signing out: \(error)")
            handler(error)
        }
    }
}
