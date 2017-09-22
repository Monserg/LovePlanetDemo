//
//  UsersListShowViewController.swift
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
protocol UsersListShowDisplayLogic: class {
    func usersListPresent(fromViewModel viewModel: UsersListShowModels.Users.ViewModel)
    func userDeletePresent(fromViewModel viewModel: UsersListShowModels.Users.ViewModel)
}

class UsersListShowViewController: UITableViewController {
    // MARK: - Properties
    var interactor: UsersListShowBusinessLogic?
    var router: (NSObjectProtocol & UsersListShowRoutingLogic & UsersListShowDataPassing)?
    
    var sortSegmentedControl: UISegmentedControl!
    var usersList: [User] = []
    var selectedIndex = 0

    
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
        let interactor      =   UsersListShowInteractor()
        let presenter       =   UsersListShowPresenter()
        let router          =   UsersListShowRouter()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check users list
        let requestModel = UsersListShowModels.Users.RequestModel(sortIndex: selectedIndex)
        interactor?.usersListLoad(withRequestModel: requestModel)
    }
    
    
    // MARK: - Custom Functions
    func viewSettingsDidLoad() {
        // Create title
        self.navigationItem.title = NSLocalizedString("Users List", comment: "Users list title")
        
        // Create Close bar button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: NSLocalizedString("Close", comment: "Back button"),
                                                                            style: .done,
                                                                            target: self,
                                                                            action: #selector(handlerCloseButtonTap(_:)))

        // Create Add button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add,
                                                                      target: self,
                                                                      action: #selector(handlerAddButtonTap(_:)))
    }
    
    
    // MARK: - Actions
    @objc func handlerCloseButtonTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @objc func handlerAddButtonTap(_ sender: UIBarButtonItem) {
        router?.routeToUserShowScene()
    }
    
    @objc func handlerSegmentedValueChanged(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        let requestModel = UsersListShowModels.Users.RequestModel(sortIndex: selectedIndex)
        interactor?.usersListLoad(withRequestModel: requestModel)
    }
}


// MARK: - UITableViewDataSource
extension UsersListShowViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let user = usersList[indexPath.row]
        
        cell.textLabel?.text = user.lastName
        cell.detailTextLabel?.text = user.firstName
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension UsersListShowViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: tableView.frame.width, height: 54)))
        
        // Create sort segmented control
        sortSegmentedControl = UISegmentedControl.init(items: [NSLocalizedString("A-Z", comment: "Acs"), NSLocalizedString("Z-A", comment: "Desc")])
        sortSegmentedControl.frame = CGRect.init(origin: .zero, size: .zero)
        sortSegmentedControl.selectedSegmentIndex = selectedIndex
        sortSegmentedControl.addTarget(self, action: #selector(handlerSegmentedValueChanged(_:)), for: .valueChanged)
       
        headerView.addSubview(sortSegmentedControl)

        sortSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        sortSegmentedControl.widthAnchor.constraint(equalToConstant: 250).isActive = true
        sortSegmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        sortSegmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        sortSegmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToUserShowScene()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedUser = usersList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let requestModel = UsersListShowModels.Users.RequestModel(sortIndex: Int(removedUser.codeID))
            interactor?.userDelete(withRequestModel: requestModel)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}


// MARK: - UsersListShowDisplayLogic
extension UsersListShowViewController: UsersListShowDisplayLogic {
    func usersListPresent(fromViewModel viewModel: UsersListShowModels.Users.ViewModel) {
        // Display the result from the Presenter
        usersList = viewModel.dataSource!
        tableView.reloadData()
    }
    
    func userDeletePresent(fromViewModel viewModel: UsersListShowModels.Users.ViewModel) {
        // Display the result from the Presenter
    }
}
