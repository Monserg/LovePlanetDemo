//
//  UsersListShowWorker.swift
//  LovePlanetDemo
//
//  Created by msm72 on 21.09.17.
//  Copyright (c) 2017 RemoteJob. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class UsersListShowWorker {
    // MARK: - Business Logic
    func usersListClear() {
        CoreDataManager.instance.entitiesRemove(byName: "User", andPredicateParameters: nil)
    }

    func userDelete(withCodeID codeID: String) {
        CoreDataManager.instance.entitiesRemove(byName: "User", andPredicateParameters: NSPredicate.init(format: "codeID = %@", codeID))
    }
}
