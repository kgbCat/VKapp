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
            URLQueryItem(name: "v", value: "5.132"),
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
//            URLQueryItem(name: "count", value: "50"),
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
//                        print(vkUsers)
                        DispatchQueue.main.async {
                            completion(vkUsers)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }

    }

    func getGroup(completion: @escaping ([Groups]?) -> Void) {
        urlComponents.path = "/method/\(K.NetworkPaths.getGroups)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
//            URLQueryItem(name: "count", value: "50"),

                ])
        if let url = urlComponents.url {
            AF
                .request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkGroups = usersJSONs.map { Groups($0) }
                        DispatchQueue.main.async {
                            completion(vkGroups)
                        }
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
    }
    }

    func searchGroups(search q: String, completion: @escaping ([SearchAllGroups]?) -> Void) {
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
                        let json = JSON(data)
                        let usersJSONs = json["response"]["items"].arrayValue
                        let vkGroups = usersJSONs.map { SearchAllGroups($0) }
                        DispatchQueue.main.async {
                            completion(vkGroups)
                            print(vkGroups)
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
                        let json = JSON(data)
                        let photoJSONs = json["response"]["items"].arrayValue
                        let vkUserPhoto = photoJSONs.map { VkPhoto($0) }
                        completion(vkUserPhoto)
//                        print(vkUserPhoto)
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
        }
    }
}
    
