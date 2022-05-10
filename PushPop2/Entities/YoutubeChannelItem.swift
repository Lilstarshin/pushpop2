//
//  ChannelItem.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import Foundation

struct YoutubeChannelItem: Decodable {
  let snippet: YoutubeChannelSnippet
  var channelId: String {
    snippet.channelId
  }
  var title: String {
    snippet.title
  }
  var thumbnail: String {
    snippet.thumbnails.defaultThumbnails.url
  }
}
