//
//  User+CoreDataClass.swift
//  LovePlanetDemo
//
//  Created by msm72 on 21.09.17.
//  Copyright © 2017 RemoteJob. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    // MARK: - Class Initialization
    func setup(codeID: String, firstName: String, lastName: String, isMale: Bool, birthday: NSDate) {
        self.codeID = codeID
        self.firstName = firstName
        self.lastName = lastName
        self.isMale = isMale
        self.birthday = birthday
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
}
