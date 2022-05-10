//
//  ChannelData.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import Foundation

struct YoutubeChannelSnippet: Decodable {
  let channelId: String
  let title: String
  let thumbnails: Thumbnails

  struct Thumbnails: Decodable {
    let defaultThumbnails: DefaultThumbnails
    
    enum CodingKeys: String, CodingKey {
      case defaultThumbnails = "default"
    }
    struct DefaultThumbnails: Decodable {
      let url: String
    }
  }
}
