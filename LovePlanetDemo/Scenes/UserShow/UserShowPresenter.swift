//
//  UserShowPresenter.swift
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
protocol UserShowPresentationLogic {
    func userSavePreparePresent(fromResponseModel responseModel: UserShowModels.User.ResponseModel)
    func userCreatePreparePresent(fromResponseModel responseModel: UserShowModels.User.ResponseModel)
}

class UserShowPresenter: UserShowPresentationLogic {
    // MARK: - Properties
    weak var viewController: UserShowDisplayLogic?
    
    
    // MARK: - Presentation Logic implementation
    func userSavePreparePresent(fromResponseModel responseModel: UserShowModels.User.ResponseModel) {
        let viewModel = UserShowModels.User.ViewModel()
        viewController?.userSavePresent(fromViewModel: viewModel)
    }

    func userCreatePreparePresent(fromResponseModel responseModel: UserShowModels.User.ResponseModel) {
        let viewModel = UserShowModels.User.ViewModel()
        viewController?.userCreatePresent(fromViewModel: viewModel)
    }
}