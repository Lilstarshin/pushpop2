//
//  SearchResultListCellData.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import Foundation

struct SearchResultListCellData {
  let channelID: String
  let profileImg: String
  let channelTitle: String
  var isSubscribe: Bool
  var subData: [SubscriptionListCellData]
}
