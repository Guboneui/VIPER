//
//  View.swift
//  VIPER
//
//  Created by 구본의 on 2023/04/05.
//

import UIKit

// ViewController
// protocol
// reference presenter

protocol AnyView {
  var presenter: AnyPresenter? { get set }
  func update(with users: [User])
  func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
  var presenter: AnyPresenter?
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isHidden = true
    return tableView
  }()
  
  var users: [User] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .orange
    self.setupViews()
  }
  
  private func setupViews() {
    self.view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  
  func update(with users: [User]) {
    print("Update")
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.users = users
      self.tableView.reloadData()
      self.tableView.isHidden = false
    }
  }
  
  func update(with error: String) {
    print(error)
  }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = users[indexPath.row].name
    return cell
  }
  
  
  
  
}
