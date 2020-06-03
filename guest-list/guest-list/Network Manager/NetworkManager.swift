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
    private lazy var uid = Auth.auth().currentUser!.uid //Shall always be initialized, force crash if not.
    private lazy var eventCollection = Firestore.firestore().collection("event").document(uid).collection("guestList")
    
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    func getGuestList(handler: @escaping (Error?) -> ()) {
        eventCollection.getDocuments { (querySnapshot, error) in
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
        
        eventCollection.document(guest.id).setData(data, merge: true) { (error) in
            if let error = error {
                print("Error adding guest to Firestore: \(error)")
                handler(error)
            } else {
                GuestList.shared.setGuest(to: guest)
                handler(nil)
            }
        }
    }
    
    func remove(_ guest: Guest, handler: @escaping (Error?) -> ()) {
        eventCollection.document(guest.id).delete { (error) in
            if let error = error {
                print("Error deleting guest with id \(guest.id): \(error)")
                handler(error)
                return
            }
            
            GuestList.shared.remove(guest)
            handler(nil)
        }
    }
}


// MARK: Auth

extension NetworkManager {
    func isAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
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
    
    func signIn(withEmail email: String, password: String, handler: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Error creating user: \(error)")
                handler(error)
                return
            }
            
            handler(nil)
        }
    }
    
    func signOut(handler: @escaping (Error?) -> ()) {
        do {
            try Auth.auth().signOut()
            GuestList.shared.removeAllGuests()
            handler(nil)
        } catch (let error) {
            print("Error signing out: \(error)")
            handler(error)
        }
    }
}


enum RSVP: Int, Codable, CaseIterable {
    case noResponse
    case attending
    case maybe
    case declined
        
    var description: String {
        switch self {
            case .noResponse: return "No Response"
            case .attending: return "Attending"
            case .maybe: return "Maybe"
            case .declined: return "Declined"
        }
    }
}
    
enum List: Int, Codable, CaseIterable {
    case guestList
    case waitingList
        
    var description: String {
        switch self {
            case .guestList: return "Guest List"
            case .waitingList: return "Waiting List"
        }
    }
}
    
enum Role: Int, Codable, CaseIterable {
    case guest
    case toastmaster
    case bestman
    case honoraryBridesmaid
    case bridesmaid
    case flowergirl
    case weddingCouple
        
    var description: String {
        switch self {
            case .guest: return "Guest"
            case .toastmaster: return "Toastmaster/Tostmadame"
            case .bestman: return "Bestman/Bestwoman"
            case .honoraryBridesmaid: return "Honorary Bridesmaid"
            case .bridesmaid: return "Bridesmaid"
            case .flowergirl: return "Flower Girl/Flower Boy"
        case .weddingCouple: return "Wedding Couple"
        }
    }
}
    
enum Relation: Int, Codable, CaseIterable {
    case family
    case relatives
    case friend
        
    var description: String {
        switch self {
            case .family: return "Family"
            case .relatives: return "Relatives"
            case .friend: return "Friend"
        }
    }
}
    
enum FamilyStatus: Int, Codable, CaseIterable {
    case single
    case relationship
    case family
    
    var description: String {
        switch self {
            case .single: return "Single"
            case .relationship: return "Relationship/Married"
            case .family: return "Family/Household"
        }
    }
}
    
enum Gender: Int, Codable, CaseIterable {
    case female
    case male
    case other
    
    var description: String {
        switch self {
            case .female: return "Female"
            case .male: return "Male"
            case .other: return "Other"
        }
    }
}
