//
//  SearchModel.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import Foundation
import RxSwift

struct SearchModel {
  let localNetwork: LocalNetwork
  let coreDataManager: CoreDataManager
  init(localNetwork: LocalNetwork = LocalNetwork(), coreDataManager: CoreDataManager = CoreDataManager()) {
    self.localNetwork = localNetwork
    self.coreDataManager = coreDataManager
  }
  
  func getChannelData(by key: String) -> Single<Result<YoutubeChannelData, URLError>> {
    print("SearchModel : key : \(key)")
    return localNetwork.getChannelData(by: key)
  }
  
  func channelDataToCellData(_ data: YoutubeChannelItem) -> SearchResultListCellData {
    return SearchResultListCellData(
      channelID: data.channelId,
      profileImg: data.thumbnail,
      channelTitle: data.title,
      isSubscribe: false,
      subData: [SubscriptionListCellData]()
    )
  }
  func getContentsData(by key: String) -> Single<Result<YoutubeContentsData, URLError>> {
    print("SearchModel : key : \(key)")
    return localNetwork.getContentsData(by: key)
  }
  
  func contentsDataToCellData(_ data: YoutubeContentsItem) -> SubscriptionListCellData {
    return SubscriptionListCellData(
      videoID: data.videoId,
      thumbnailImg: data.thumbnail,
      channelID: data.channelID
    )
  }
  func mergeCoreDataAndApiData( core: [SearchResultListCellData], api:[YoutubeChannelItem] ) -> [SearchResultListCellData] {
    let convert = api.map(channelDataToCellData)
    var resultList = [SearchResultListCellData]()
    convert.forEach { conv in
      if !core.isEmpty {
        core.forEach { core in
          let comp = conv.channelID == core.channelID ? core : conv
          resultList.last?.channelID == comp.channelID ? () : resultList.append(comp)
        }
      } else {
        resultList.append(conv)
      }
    }
    print("resultList66 \(resultList)")
    return resultList
  }
  func channelDataInCoreData(cell: SearchResultListCellData) -> [SearchResultListCellData] {
    if cell.isSubscribe {
      _ = channelDataDelete(key: cell.channelID)
    } else {
      let result = channelDataInsert(data: cell)
      print("Insert !\(result)")
    }
    
    let a = channelDataFetch()
    print("TEST 55 \(a)")
    return a
  }
  
  func channelDataInsert(data: SearchResultListCellData) -> Bool {
    print("SearchModel : channelDataInsert : \(data)")
    return coreDataManager.channelDataInsert(data)
  }
  func channelDataFetch() -> [SearchResultListCellData] {
    return coreDataManager.channelDataFetchAll()
  }
  func channelDataFetch(key: String) -> SearchResultListCellData? {
    print("SearchModel : channelDataFetch : \(key)")
    return coreDataManager.channelDataFetchIndex(forCellKey: key)
  }
  func channelDataDelete(key: String) -> Bool {
    print("SearchModel : channelDataDelete : \(key)")
    return  coreDataManager.channelDataDelete(channelID: key)
  }
  
  func contentsDataInsert(data: SubscriptionListCellData) -> Bool {
    print("SearchModel : contentsDataInsert : \(data)")
    return coreDataManager.contentsDataInsert(data)
  }
  func contentsDataFetch() -> [SubscriptionListCellData] {
    return coreDataManager.contentsDataFetchAll()
  }
  func contentsDataFetch(key: String) -> [SubscriptionListCellData] {
    print("SearchModel : contentsDataFetch : \(key)")
    return coreDataManager.contentsDataFetchChannelID(forCellDatakey: key)
  }
  func contentsDataDelete(key: String) -> Bool {
    print("SearchModel : contentsDataDelete : \(key)")
    return  coreDataManager.contentsDataDelete(channelID: key)
  }
  
}
