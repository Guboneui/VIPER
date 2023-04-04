//
//  Interactor.swift
//  VIPER
//
//  Created by 구본의 on 2023/04/05.
//

import Foundation

// object
// protocol
// ref to presenter

protocol AnyInteractor {
  var presenter: AnyPresenter? { get set }
  
  func getUsers()
}

class UserInteractor: AnyInteractor {
  var presenter: AnyPresenter?
  
  func getUsers() {
    print("start fetch")
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard let self else { return }
      guard let data = data, error == nil else {
        self.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
        return
      }
      
      do {
        let entities = try JSONDecoder().decode([User].self, from: data)
        self.presenter?.interactorDidFetchUsers(with: .success(entities))
      } catch {
        self.presenter?.interactorDidFetchUsers(with: .failure(error))
      }
    }
    
    task.resume()
  }
}
