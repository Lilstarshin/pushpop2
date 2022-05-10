//
//  LocalAPI.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import Foundation

struct LocalAPI {
  static let scheme = "https"
  static let host = "www.googleapis.com"
  static let path = "/youtube/v3/search"
  private static var systemInfo: NSDictionary = {
    guard let url = Bundle.main.url(forResource: "SystemInfo", withExtension: "plist"),
          let dictionary = NSDictionary(contentsOf: url)
    else { return NSDictionary() }
    return dictionary
  }()
  private static var youtubeKey: String = {
    guard let apiKey = systemInfo["YoutubeKey"] as? String
      else { return "" }
    return apiKey
  }()
  
  func getChannelData(by key: String) -> URLComponents {
    
    var components = URLComponents()
    components.scheme = LocalAPI.scheme
    components.host = LocalAPI.host
    components.path = LocalAPI.path
    
    components.queryItems = [
      URLQueryItem(name: "key", value: LocalAPI.youtubeKey),
      URLQueryItem(name: "maxResults", value: "3"),
      URLQueryItem(name: "part", value: "snippet"),
      URLQueryItem(name: "type", value: "channel"),
      URLQueryItem(name: "q", value: key),
      
    ]
    return components
  }
  func getContentsData(by key: String) -> URLComponents {
    
    var components = URLComponents()
    components.scheme = LocalAPI.scheme
    components.host = LocalAPI.host
    components.path = LocalAPI.path
    
    components.queryItems = [
      URLQueryItem(name: "key"       , value: LocalAPI.youtubeKey),
      URLQueryItem(name: "maxResults", value: "20"),
      URLQueryItem(name: "part"      , value: "snippet"),
      URLQueryItem(name: "channelId" , value: key),
      
    ]
    return components
  }
  
}

