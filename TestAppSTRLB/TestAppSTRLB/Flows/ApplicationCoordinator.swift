//
//  ApplicationCoordinator.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit

final class ApplicationCoordinator {
  
  let window: UIWindow
  
  private weak var presentedViewController: UIViewController?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let networkService = NetworkService()
    let adapter = NetworkServiceAdapter(service: networkService)
    let model = MainModel(dataProvider: adapter, navigationHandler: self)
    let viewModel = MainViewModel(model: model)
    let mainController = MainViewController(viewModel: viewModel)
    mainController.tabBarItem = .init(title: nil, image: UIImage(systemName: "network"), selectedImage: nil)
    let navigationController = UINavigationController(rootViewController: mainController)
    
    let favouritesImagesController = UIViewController()
    favouritesImagesController.tabBarItem = .init(title: nil, image: UIImage(systemName: "star.fill"), selectedImage: nil)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [navigationController, favouritesImagesController]
    setWindowRootViewController(with: tabBarController)
    
    presentedViewController = mainController
  }
  
  private func setWindowRootViewController(with viewController: UIViewController) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
}

extension ApplicationCoordinator: MainModelNavigationHandler {
  
  func mainModel(_ model: MainModel, didShowDetailsForSelected item: ImageItem) {
    let model = ImageItemDetailsModel(item: item)
    let viewModel = ImageItemDetailsViewModel(model: model)
    let controller = ImageItemDetailsViewController(viewModel: viewModel)
    
    presentedViewController?.navigationController?.pushViewController(controller, animated: true)
  }
  
  func mainModelDidShowFavouritesImages(_ model: MainModel) {
    
  }
  
}
