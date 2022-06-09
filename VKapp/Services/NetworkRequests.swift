//
//  NetworkRequests.swift
//  VKapp
//
//  Created by Anna Delova on 7/6/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


class NetworkRequests {
    
    var urlComponents: URLComponents = {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "user_id", value: String(Session.instance.userId))
        ]
        return url
    }()
    
    func getFriends(completion: @escaping ([Friend]?) -> Void) {
        urlComponents.path = "/method/\(K.NetworkPaths.getFriends)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "offset", value: "5"),
            URLQueryItem(name: "fields", value: "photo_200_orig"),
                ])
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                       
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkUsers = usersJSONs.map { Friend($0) }
                        completion(vkUsers)
                        
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }
    }

    func getGroup(completion: @escaping ([MyGroups]?) -> Void) {
        urlComponents.path = "/method/\(K.NetworkPaths.getGroups)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
                ])
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        DispatchQueue.global().async {
                            let json = JSON(data)
                            let usersJSONs = json["response"]["items"].arrayValue
                            let vkGroups = usersJSONs.map { MyGroups($0) }
                            DispatchQueue.main.async {
                                completion(vkGroups)
                            }
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }
    }

    func searchGroups(search q: String, completion: @escaping ([MyGroups]?) -> Void) {
        urlComponents.path = "/method/\(K.NetworkPaths.searchGroups)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "sort", value: "1"),

                ])

        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        DispatchQueue.global().async {
                            let json = JSON(data)
                            let usersJSONs = json["response"]["items"].arrayValue
                            let vkGroups = usersJSONs.map { MyGroups($0) }
                            DispatchQueue.main.async {
                                completion(vkGroups)
                                print(vkGroups)
                            }
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }
    }
    
    func getPhotos(userID:Int, completion: @escaping ([VkPhoto]?) -> Void) {
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
//            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "owner_id", value: "\(userID)"),
                ])
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        DispatchQueue.global().async {
                            let json = JSON(data)
                            let photoJSONs = json["response"]["items"].arrayValue
                            let vkUserPhoto = photoJSONs.map { VkPhoto($0) }
                            DispatchQueue.main.async {
                                completion(vkUserPhoto)
                            }
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }
    }

    func getNews(completion: @escaping ([Items]?, [Profiles]?) -> Void) {
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "filter", value: "post"),
            URLQueryItem(name: "count", value: "50"),
        ])

        guard let url = urlComponents.url else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                let decoder = JSONDecoder()

                do {
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)

                    let items = newsFeed.response.items
                    let profiles = newsFeed.response.profiles

                    var itemsChecked = [Items]()
                    var profilesChecked = [Profiles]()
                    var ids = [Int]()

                    items.forEach { item in
                        if item.attachments != nil {
                            itemsChecked.append(item)
                            ids.append(item.source_id)
                        }
                    }

                    profiles.forEach { profile in
                        if ids.contains(profile.id) {
                            profilesChecked.append(profile)
                        }
                    }
                     completion(itemsChecked, profilesChecked)
                }
                catch {
                    print("Error in JSON parsing")
                }
            }
        }
        dataTask.resume()
    }
}
    
