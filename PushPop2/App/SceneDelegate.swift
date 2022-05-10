//
//  SceneDelegate.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    let rootViewController = SubscriptionViewController()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
  }
}

