//
//  EmployeeListViewController.swift
//  EmpDir
//
//  Created by Mike Saradeth on 6/17/23.
//

import UIKit

class EmployeeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var viewModel: EmployeeViewModelType
    var coordinator: EmployeeCoordinator
    
    init(viewModel: EmployeeViewModelType, coordinator: EmployeeCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employee List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.setupTableView()
        self.fetchData()
    }
    
    @objc func refresh() {
        self.fetchData()
    }
    
    private func fetchData() {
        showSpinner()
        viewModel.fetchData { [weak self] errorMsg in
            DispatchQueue.main.async {
                self?.hideSpinner()
                if let errorMsg = errorMsg {
                    self?.showError(errorMsg: errorMsg)
                } else {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    private func showError(errorMsg: String) {
        let alertViewController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Continue", style: .default))
        self.present(alertViewController, animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: .main), forCellReuseIdentifier: EmployeeTableViewCell.reuseID)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    // Show/Hide Spinner
    private func showSpinner() {
        spinner.startAnimating()
        spinner.isHidden = false
        view.bringSubviewToFront(spinner)
    }
    
    private func hideSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseID) as! EmployeeTableViewCell
        cell.configure(emp: viewModel.employees[indexPath.item])
        return cell
    }
}
