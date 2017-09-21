//
//  UsersListShowInteractor.swift
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

// MARK: - Business Logic protocols
protocol UsersListShowBusinessLogic {
    func doSomething(request: UsersListShowModels.Something.RequestModel)
}

protocol UsersListShowDataStore {
    //var name: String { get set }
}

class UsersListShowInteractor: UsersListShowBusinessLogic, UsersListShowDataStore {
    // MARK: - Properties
    var presenter: UsersListShowPresentationLogic?
    var worker: UsersListShowWorker?
    //var name: String = ""
    
    
    // MARK: - Business logic implementation
    func doSomething(request: UsersListShowModels.Something.RequestModel) {
        worker = UsersListShowWorker()
        worker?.doSomeWork()
        
        let responseModel = UsersListShowModels.Something.ResponseModel()
        presenter?.presentSomething(response: responseModel)
    }
}
