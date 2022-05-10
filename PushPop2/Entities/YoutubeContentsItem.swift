//
//  YoutubeContentsItem.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/09.
//

import Foundation

struct YoutubeContentsItem: Decodable {
  
  let id : ContentsID
  let snippet: YoutubeContentsSnippet
  
  var videoId: String {
    id.videoId
  }
  var title: String {
    snippet.title
  }
  var channelID: String {
    snippet.channelId
  }
  var thumbnail: String {
    snippet.thumbnails.defaultThumbnails.url
  }
  
  struct ContentsID: Decodable {
    let videoId: String
  }
}
