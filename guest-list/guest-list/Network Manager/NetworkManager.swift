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
    let mockedEventId = "78fbkFIbkjFoCPzEwj73"
    private let eventCollection = Firestore.firestore().collection("event")
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    func getGuestList(handler: @escaping (Error?) -> ()) {
        
        Firestore.firestore().collection("event").document().setData(["String" : "Any"]) { (error) in
            print()
        }
        
        
        eventCollection.document(mockedEventId).collection("guestList").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying guest list from Firestore: \(error)")
            }
            
            for document in querySnapshot!.documents {
                let data = document.data()
                
                
                
                print()
            }
        }
        
        print()
    }
}
