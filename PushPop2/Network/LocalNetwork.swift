//
//  LocalNetwork.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import RxSwift
import Foundation

class LocalNetwork {
  private let session: URLSession
  let api = LocalAPI()
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  func getChannelData(by key: String) -> Single<Result<YoutubeChannelData, URLError>> {
    print("LocalNetwrok: key : \(key)")
    guard let url = api.getChannelData(by: key).url else {
      return .just(.failure(URLError(.badURL)))
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    return session.rx.data(request: request as URLRequest)
      .map { data in
        do {
          let channelData = try JSONDecoder().decode(YoutubeChannelData.self, from: data)
          print("LocalNetwrok: channel Data : \(channelData) ")
          return .success(channelData)
        } catch {
          return .failure(URLError(.cannotParseResponse))
        }
      }
      .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork))) }
      .asSingle()
  }
  
  
  func getContentsData(by key: String) -> Single<Result<YoutubeContentsData, URLError>> {
    print("getContents: key : \(key)")
    guard let url = api.getContentsData(by: key).url else {
      return .just(.failure(URLError(.badURL)))
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    return session.rx.data(request: request as URLRequest)
      .map { data in
        do {
          let contentsData = try JSONDecoder().decode(YoutubeContentsData.self, from: data)
          print("getContents: channel Data : \(contentsData) ")
          return .success(contentsData)
        } catch {
          return .failure(URLError(.cannotParseResponse))
        }
      }
      .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork))) }
      .asSingle()
  }
}

