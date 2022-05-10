//
//  ChannelData+CoreDataProperties.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/09.
//
//

import Foundation
import CoreData


extension ChannelData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChannelData> {
        return NSFetchRequest<ChannelData>(entityName: "ChannelData")
    }

    @NSManaged public var channelID: String?
    @NSManaged public var channelTitle: String?
    @NSManaged public var profileImg: String?
    @NSManaged public var contents: NSSet?

}

// MARK: Generated accessors for contents
extension ChannelData {

    @objc(addContentsObject:)
    @NSManaged public func addToContents(_ value: ContentsData)

    @objc(removeContentsObject:)
    @NSManaged public func removeFromContents(_ value: ContentsData)

    @objc(addContents:)
    @NSManaged public func addToContents(_ values: NSSet)

    @objc(removeContents:)
    @NSManaged public func removeFromContents(_ values: NSSet)

}

extension ChannelData : Identifiable {

}
