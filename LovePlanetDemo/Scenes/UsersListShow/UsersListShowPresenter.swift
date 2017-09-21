//
//  UsersListShowPresenter.swift
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

// MARK: - Presentation Logic protocols
protocol UsersListShowPresentationLogic {
    func presentSomething(response: UsersListShowModels.Something.ResponseModel)
}

class UsersListShowPresenter: UsersListShowPresentationLogic {
    // MARK: - Properties
    weak var viewController: UsersListShowDisplayLogic?
    
    
    // MARK: - Presentation Logic implementation
    func presentSomething(response: UsersListShowModels.Something.ResponseModel) {
        let viewModel = UsersListShowModels.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}