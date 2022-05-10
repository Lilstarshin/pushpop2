//
//  CoreDataManager.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/09.
//

import UIKit
import Foundation
import CoreData
import RxSwift
import RxCocoa


class CoreDataManager {
  private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = appDelegate.persistentContainer.viewContext


  
  // MARK: - Data fetch
  func channelDataFetchAll() -> [SearchResultListCellData] {
    
    var subscriptionlist: [SearchResultListCellData] = []
    
    let fetchRequest: NSFetchRequest<ChannelData> =  ChannelData.fetchRequest()
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      
      for record in resultSet {
        subscriptionlist.append( SearchResultListCellData(
          channelID: record.channelID ?? "",
          profileImg: record.profileImg ?? "",
          channelTitle: record.channelTitle ?? "",
          isSubscribe: true,
          //###### TODO: 여기 subscription List data fetch()로 바꿔야함.##################
          subData: contentsDataFetchChannelID(forCellDatakey: record.channelID ?? "")
        ))
        
      }
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
    }
    print("subscriptionlist: \(subscriptionlist)")
    return subscriptionlist
  }
  func channelDataFetchIndex(forCellKey key: String) -> SearchResultListCellData? {
    let fetchRequest: NSFetchRequest<ChannelData> =  ChannelData.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(format: "channelID == %@", key)
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      guard let result = resultSet.first else { return nil }
      
      return SearchResultListCellData(
        channelID: result.channelID ?? "",
        profileImg: result.profileImg ?? "",
        channelTitle: result.channelTitle ?? "",
        isSubscribe: true,
        subData: contentsDataFetchChannelID(forCellDatakey: result.channelID ?? "")
      )
      
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return nil
    }
    
  }
  func channelDataFetchIndex(forCoreDataKey key: String) -> ChannelData? {
    let fetchRequest: NSFetchRequest<ChannelData> =  ChannelData.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(format: "channelID == %@", key)
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      return resultSet.first ?? nil
  
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return nil
    }
  }
  // MARK: - Data insert
  func channelDataInsert (_ data: SearchResultListCellData) -> Bool {
    if channelDataFetchIndex(forCellKey: data.channelID) != nil { return false }
    guard let object = NSEntityDescription.insertNewObject(
      forEntityName: "ChannelData",
      into: context
    ) as? ChannelData else { return false }
    
    object.channelID          = data.channelID
    object.channelTitle       = data.channelTitle
    object.profileImg         = data.profileImg
    //###### TODO: 여기 subscription List data addToContents()로 바꿔야함.##################
    object.addToContents(NSSet(array: contentsDataFetchChannelID(forCoreDatakey: data.channelID)))
    
    do {
      try context.save()
      // TODO: Upload to server
      
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return false
    }
    return true
  }
  // MARK: - Data delete
  func channelDataDelete(channelID q: String) -> Bool {
    let fetchRequest: NSFetchRequest<ChannelData> =  ChannelData.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(format: "channelID == %@", q)
    
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      for record in resultSet {
        let object = context.object(with: record.objectID)
        context.delete(object)
        try context.save()
      }
      return false
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return true
    }
  }
  
  // MARK: - Data fetch
  func contentsDataFetchAll() -> [SubscriptionListCellData] {
    
    var subscriptionlist: [SubscriptionListCellData] = []
    
    let fetchRequest: NSFetchRequest<ContentsData> =  ContentsData.fetchRequest()
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      
      for record in resultSet {
        subscriptionlist.append( SubscriptionListCellData(
          videoID: record.videoID ?? "",
          thumbnailImg: record.thumbnailImg ?? "",
          channelID: record.channelID ?? ""
        ))
        
      }
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
    }
    print("subscriptionlist: \(subscriptionlist)")
    return subscriptionlist
  }
  func contentsDataFetchChannelID(forCellDatakey: String) -> [SubscriptionListCellData] {
    var subscriptionlist: [SubscriptionListCellData] = []
    let fetchRequest: NSFetchRequest<ContentsData> =  ContentsData.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(format: "channelID == %@", forCellDatakey)
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      
      for record in resultSet {
        subscriptionlist.append( SubscriptionListCellData(
          videoID: record.videoID ?? "",
          thumbnailImg: record.thumbnailImg ?? "",
          channelID: record.channelID ?? ""
        ))
      }
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
    }
      return subscriptionlist
    
  }
  func contentsDataFetchChannelID(forCoreDatakey: String) -> [ContentsData] {
    let fetchRequest: NSFetchRequest<ContentsData> =  ContentsData.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(format: "channelID == %@", forCoreDatakey)
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      return resultSet
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return [ContentsData]()
    }
  }
  // MARK: - Data insert
  func contentsDataInsert (_ data: SubscriptionListCellData) -> Bool {
    
    guard let object = NSEntityDescription.insertNewObject(
      forEntityName: "ContentsData",
      into: context
    ) as? ContentsData else { return false }
    object.channelID        = data.channelID
    object.videoID          = data.videoID
    object.thumbnailImg     = data.thumbnailImg
    do {
      try context.save()
      // TODO: Upload to server
      
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return false
    }
    return true
  }
  // MARK: - Data delete
  func contentsDataDelete(channelID q: String) -> Bool {
    let fetchRequest: NSFetchRequest<ContentsData> =  ContentsData.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(format: "channelID == %@", q)
    
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      for record in resultSet {
        let object = context.object(with: record.objectID)
        context.delete(object)
        try context.save()
      }
      return false
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return true
    }
  }
}



