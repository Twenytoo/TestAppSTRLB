//
//  SceneDelegate.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var applicationCoordinator: ApplicationCoordinator!


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    
    applicationCoordinator = ApplicationCoordinator(window: window)
    applicationCoordinator.start()
    
    self.window = window
  }

}

