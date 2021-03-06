//
//  UsersListShowModels.swift
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

// MARK: - Data models
enum UsersListShowModels {
    // MARK: - Use cases
    enum Users {
        struct RequestModel {
            let sortIndex: Int
        }
        
        struct ResponseModel {
            let dataSource: [User]?
        }
        
        struct ViewModel {
            let dataSource: [User]?
        }
    }
}
