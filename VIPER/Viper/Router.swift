//
//  Router.swift
//  VIPER
//
//  Created by 구본의 on 2023/04/05.
//

import UIKit

// Object
// Entry Point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
  var entry: EntryPoint? { get }
  static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
  
  var entry: EntryPoint?
  
  static func start() -> AnyRouter {
    let router = UserRouter()
    
    // Assign VIP
    var view: AnyView = UserViewController()
    var presenter: AnyPresenter = UserPresenter()
    var interactor: AnyInteractor = UserInteractor()
    
    view.presenter = presenter
    interactor.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    
    router.entry = view as? EntryPoint
    
    return router
  }
}
