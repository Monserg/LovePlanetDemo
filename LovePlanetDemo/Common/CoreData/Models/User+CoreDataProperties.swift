//
//  User+CoreDataProperties.swift
//  LovePlanetDemo
//
//  Created by msm72 on 21.09.17.
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
    @NSManaged public var codeID: String
    @NSManaged public var firstName: String
    @NSManaged public var isMale: Bool
    @NSManaged public var lastName: String

}
