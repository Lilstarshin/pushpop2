//
//  ChannelDataDAO.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/09.
//

import Foundation
import CoreData
import UIKit


class SubscriptionInfoDAO {
  private lazy var context: NSManagedObjectContext = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    return appDelegate.persistentContainer.viewContext
  }()
  
  // MARK: - Data fetch
  func fetch(channelId q: String? = nil) -> [YoutubeChannelItem] {
    var subscriptionlist: [YoutubeChannelItem] = []

    let fetchRequest: NSFetchRequest<SubscriptionInfoMO> =  SubscriptionInfoMO.fetchRequest()
    if let q = q, q.isEmpty == false {
      fetchRequest.predicate = NSPredicate(format: "channelId == %@", q)
    }
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      
      for record in resultSet {
        subscriptionlist.append( SubscriptionInfoVO(
          channelId          : record.channelId  ?? "",
          title              : record.title      ?? "",
          channelDescription : record.channelId  ?? "",
          thumbnail          : record.thumbnail  ?? "",
          contents           : nil,
          objectID           : record.objectID
        ))
        
      }
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
    }
    print("subscriptionlist: \(subscriptionlist)")
    return subscriptionlist
  }
  
  // MARK: - Data insert
  func insert (_ data: SubscriptionInfoVO) -> Bool {
    
    guard let object = NSEntityDescription.insertNewObject(
      forEntityName: "SubscriptionInfo",
      into: context
    ) as? SubscriptionInfoMO else { return false }
    
    object.channelId          = data.channelId
    object.title              = data.title
    object.channelDescription = data.channelDescription
    object.thumbnail          = data.thumbnail
    object.lastUpdate         = data.lastUpdate
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
  func delete(_ objectID: NSManagedObjectID) -> Bool {
    
    let object = context.object(with: objectID)
    context.delete(object)
    
    do {
      try context.save()
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return false
    }
    return true
  }
}
