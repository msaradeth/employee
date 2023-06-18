//
//  EmployeeCoordinator.swift
//  EmpDir
//
//  Created by Mike Saradeth on 6/17/23.
//

import UIKit

final class EmployeeCoordinator {
    private let window: UIWindow
    private let navController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navController = UINavigationController()
        self.window.rootViewController = navController
    }
    
    func start() {
        let viewModel = EmployeeViewModel(service: EmployeeService())
        let viewController = EmployeeListViewController(viewModel: viewModel, coordinator: self)
        self.navController.pushViewController(viewController, animated: true)
    }
}
