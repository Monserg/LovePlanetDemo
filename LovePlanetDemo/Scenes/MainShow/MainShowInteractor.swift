//
//  MainShowInteractor.swift
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
protocol MainShowBusinessLogic {
    func doSomething(request: MainShowModels.Something.RequestModel)
}

protocol MainShowDataStore {
    //var name: String { get set }
}

class MainShowInteractor: MainShowBusinessLogic, MainShowDataStore {
    // MARK: - Properties
    var presenter: MainShowPresentationLogic?
    var worker: MainShowWorker?
    //var name: String = ""
    
    
    // MARK: - Business logic implementation
    func doSomething(request: MainShowModels.Something.RequestModel) {
        worker = MainShowWorker()
        worker?.doSomeWork()
        
        let responseModel = MainShowModels.Something.ResponseModel()
        presenter?.presentSomething(response: responseModel)
    }
}