//
//  User+CoreDataProperties.swift
//  LovePlanetDemo
//
//  Created by msm72 on 22.09.17.
//  Copyright © 2017 RemoteJob. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var birthday: NSDate
    @NSManaged public var codeID: Int16
    @NSManaged public var firstName: String
    @NSManaged public var isFemale: Bool
    @NSManaged public var lastName: String

}
