//
//  NetworkManager.swift
//  Hummingbird
//
//  Created by Donny Kurniawan on 22/2/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

// Get the API key: https://trello.com/app-key
// Authorize the client: https://trello.com/1/authorize?expiration=never&name=Macrello&key=ba83985c6001257105749696518aca16&response_type=token
// Make calls: https://api.trello.com/1/members/me/boards?key=ba83985c6001257105749696518aca16&token=1c70dd9e8d41f3a47bdc38b7f91e46fe8601048a004c882eedd22c654a98e09c

import Foundation

class NetworkManager {
    private let session: URLSession
    private let baseURL = URL(string: "https://api.trello.com/1")
    private let trelloAppKey = "ba83985c6001257105749696518aca16"
    private let trelloUserToken = "1c70dd9e8d41f3a47bdc38b7f91e46fe8601048a004c882eedd22c654a98e09c"
    
    enum FetchResult {
        case success(Data)
        case failure(Error)
    }
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    private func performNetworkRequest(_ path: String, queryItems: [URLQueryItem] = [], completionHandler: @escaping (FetchResult) -> Void) {
        var resourceURLComponents = URLComponents()
        resourceURLComponents.scheme = "https";
        resourceURLComponents.host = "api.trello.com";
        resourceURLComponents.path = "/1" + path;
        let keyQuery = URLQueryItem(name: "key", value: trelloAppKey)
        let tokenQuery = URLQueryItem(name: "token", value: trelloUserToken)
        resourceURLComponents.queryItems = [keyQuery, tokenQuery] + queryItems
        
        if let resourceURL = resourceURLComponents.url {
            let request = URLRequest(url: resourceURL)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                var result: FetchResult
                
                if let error = error {
                    result = .failure(error)
                } else if let data = data {
                    result = .success(data)
                } else {
                    result = .failure(NSError(domain: "HummingbirdErrorDomain", code: 0, userInfo: nil))
                }
                
                OperationQueue.main.addOperation({ () -> Void in
                    completionHandler(result)
                })
            })
            task.resume()
        }
    }
    
    func fetchBoards(_ completionHandler: @escaping ([Board]?) -> Void) {
        performNetworkRequest("/members/me/boards") { fetchResult in
            switch fetchResult {
            case .failure(let error):
                print("Error: \(error)")
                completionHandler(nil)
            case .success(let data):
                guard let
                    array = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<AnyObject>,
                    let results = array
                    else {
                        return completionHandler(nil)
                }
                
                completionHandler(results.flatMap({ board in
                    guard let boardDictionary = board as? Dictionary<String, AnyObject> else {
                        return nil
                    }
                    return Board(dictionary: boardDictionary)
                }))
            }
        }
    }
    
    func fetchBoard(_ board: Board, completionHandler: @escaping (Board?) -> Void) {
        let queryItems = [URLQueryItem(name: "labels", value: "all"),
                          URLQueryItem(name: "members", value: "all"),
                          URLQueryItem(name: "lists", value: "open"),
                          URLQueryItem(name: "cards", value: "open"),
                          URLQueryItem(name: "card_stickers", value: "true")]
        performNetworkRequest("/boards/\(board.id)", queryItems: queryItems) { fetchResult in
            switch fetchResult {
            case .failure(let error):
                print("Error: \(error)")
                completionHandler(nil)
            case .success(let data):
                guard let
                    dictionary = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>,
                    let result = dictionary,
                    let labels = result["labels"] as? Array<AnyObject>,
                    let members = result["members"] as? Array<AnyObject>,
                    let lists = result["lists"] as? Array<AnyObject>,
                    let cards = result["cards"] as? Array<AnyObject>
                    else {
                        return completionHandler(nil)
                }
                
                var boardCopy = board
                
                var labelsDictionary: [String: Label] = [:]
                boardCopy.labels = labels.flatMap({ label in
                    guard let
                        labelDictionary = label as? Dictionary<String, AnyObject>,
                        let labelInstance = Label(dictionary: labelDictionary)
                        else {
                            return nil
                    }
                    labelsDictionary[labelInstance.id] = labelInstance
                    return labelInstance
                })
                boardCopy.labelsDictionary = labelsDictionary
                
                var membersDictionary: [String: Member] = [:]
                boardCopy.members = members.flatMap({ member in
                    guard let
                        memberDictionary = member as? Dictionary<String, AnyObject>,
                        let memberInstance = Member(dictionary: memberDictionary)
                        else {
                            return nil
                    }
                    membersDictionary[memberInstance.id] = memberInstance
                    return memberInstance
                })
                boardCopy.membersDictionary = membersDictionary
                
                var listsDictionary: [String: List] = [:]
                boardCopy.lists = lists.flatMap({ list in
                    guard let
                        listDictionary = list as? Dictionary<String, AnyObject>,
                        let listInstance = List(dictionary: listDictionary)
                        else {
                            return nil
                    }
                    listsDictionary[listInstance.id] = listInstance
                    return listInstance
                })
                boardCopy.listsDictionary = listsDictionary
                
                var cardsDictionary: [String: Card] = [:]
                boardCopy.cards = cards.flatMap({ card in
                    guard let
                        cardDictionary = card as? Dictionary<String, AnyObject>,
                        let cardInstance = Card(dictionary: cardDictionary)
                        else {
                            return nil
                    }
                    cardsDictionary[cardInstance.id] = cardInstance
                    return cardInstance
                })
                boardCopy.cardsDictionary = cardsDictionary
                
                completionHandler(boardCopy)
            }
        }
    }
    
    func fetchBoardLists(_ board: Board, completionHandler: @escaping (Board?) -> Void) {
        let queryItems = [URLQueryItem(name: "cards", value: "all")]
        performNetworkRequest("/boards/\(board.id)/lists", queryItems: queryItems) { fetchResult in
            switch fetchResult {
            case .failure(let error):
                print("Error: \(error)")
                completionHandler(nil)
            case .success(let data):
                guard let
                    array = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<AnyObject>,
                    let results = array
                    else {
                        return completionHandler(nil)
                }
                
                var boardCopy = board
                boardCopy.lists = results.flatMap({ list in
                    guard let listDictionary = list as? Dictionary<String, AnyObject> else {
                        return nil
                    }
                    return List(dictionary: listDictionary)
                })
                
                completionHandler(boardCopy)
            }
        }
    }
}
