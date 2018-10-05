//
//  CardController.swift
//  DevMtn-StripHiLo
//
//  Created by John Tate on 10/4/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class CardController {
    
    static let shared = CardController()
    private init() {}
    
    private let baseURLString = "https://deckofcardsapi.com/api/deck"
    
    func fetchCard(count: Int, completion: @escaping ([Card]?)->Void) {
        guard let baseURL = URL(string: baseURLString) else {
            fatalError("Bad base URL")
        }
        
        let newURL = baseURL.appendingPathComponent("new").appendingPathComponent("draw")
        var components = URLComponents(url: newURL, resolvingAgainstBaseURL: true)
        let queryItems = URLQueryItem(name: "count", value: "\(count)")
        components?.queryItems = [queryItems]
        guard let url = components?.url else { completion([]); return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("There was an error fetching from dataTask \(#function) \(error) \(error.localizedDescription)")
                completion([]); return
            }
            guard let dataThatCameBack = data else { print("no data returned"); completion([]); return }
            do {
                let cards = try JSONDecoder().decode(DeckDictionary.self, from: dataThatCameBack).cards
                completion(cards)
            } catch let error {
                print("There was an error decoding our object \(error) \(error.localizedDescription)")
                completion([]); return
            }
            }.resume()
    }
    
    func fetchCardImage(card: Card, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: card.image) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in

            if let error = error {
                print("Error with fetching image data task \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            guard let data = data else { completion(nil); return }
            guard let image = UIImage(data: data) else { completion(nil); return }
            completion(image)
            }.resume()
    }
}

