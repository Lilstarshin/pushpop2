//
//  ContentsData+CoreDataProperties.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/09.
//
//

import Foundation
import CoreData


extension ContentsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContentsData> {
        return NSFetchRequest<ContentsData>(entityName: "ContentsData")
    }

    @NSManaged public var videoID: String?
    @NSManaged public var thumbnailImg: String?
    @NSManaged public var channelID: String?
    @NSManaged public var channelData: ChannelData?

}

extension ContentsData : Identifiable {

}
