//
//  UserShowViewController.swift
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

// MARK: - Input & Output protocols
protocol UserShowDisplayLogic: class {
    func userSavePresent(fromViewModel viewModel: UserShowModels.User.ViewModel)
    func userCreatePresent(fromViewModel viewModel: UserShowModels.User.ViewModel)
}

class UserShowViewController: UIViewController {
    // MARK: - Properties
    var interactor: UserShowBusinessLogic?
    var router: (NSObjectProtocol & UserShowRoutingLogic & UserShowDataPassing)?
    
    
    // MARK: - IBOutlets
    // @IBOutlet weak var nameTextField: UITextField!
    
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    
    // MARK: - Setup
    private func setup() {
        let viewController  =   self
        let interactor      =   UserShowInteractor()
        let presenter       =   UserShowPresenter()
        let router          =   UserShowRouter()
        
        viewController.interactor   =   interactor
        viewController.router       =   router
        interactor.presenter        =   presenter
        presenter.viewController    =   viewController
        router.viewController       =   viewController
        router.dataStore            =   interactor
    }
    
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSettingsDidLoad()
    }
    
    
    // MARK: - Custom Functions
    func viewSettingsDidLoad() {
        // Create main view
        view.backgroundColor = UIColor.white

        // Create title
        self.navigationItem.title = router?.dataStore?.user == nil ?    NSLocalizedString("Create User", comment: "Create User mode title") :
                                                                        NSLocalizedString("Edit User", comment: "Edit User mode title")

        // Create Save button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save,
                                                                      target: self,
                                                                      action: #selector(handlerSaveButtonTap(_:)))
    }
    
    
    // MARK: - Actions
    @objc func handlerSaveButtonTap(_ sender: UIBarButtonItem) {
        if router?.dataStore?.user == nil {
            let requestModel = UserShowModels.User.RequestModel()
            interactor?.userCreate(withRequestModel: requestModel)
        } else {
            let requestModel = UserShowModels.User.RequestModel()
            interactor?.userSave(withRequestModel: requestModel)
        }
    }
}


// MARK: - UserShowDisplayLogic
extension UserShowViewController: UserShowDisplayLogic {
    func userSavePresent(fromViewModel viewModel: UserShowModels.User.ViewModel) {
        // Display the result from the Presenter
        self.navigationController?.popViewController(animated: true)
    }
    
    func userCreatePresent(fromViewModel viewModel: UserShowModels.User.ViewModel) {
        // Display the result from the Presenter
        self.navigationController?.popViewController(animated: true)
    }
}
