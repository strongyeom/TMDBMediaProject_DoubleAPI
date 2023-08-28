//
//  SceneDelegate.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // OnBoarding 실행을 위해 테스트 false ㄷ
       // UserDefaults.standard.set(false, forKey: "isLanuched")
        
        
        let isLanuched = UserDefaults.standard.bool(forKey: "isLanuched")
        
        if isLanuched {
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
           // guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController else { return }


            //let vc = CodeMainViewController()
            let vc = CodeAllPreViewController()
            
            // 네비게이션 타이틀을 사용하려면 UINavigationController를 사용해야한다.
            let nav = UINavigationController(rootViewController: vc)
            
            // 루트 뷰에 대한 지정해주기 : 시작화면을 셋팅해주자!
            // window : 사용자가 직접적으로 보는 뷰!
            window?.rootViewController = nav
            
            
        } else {
            
            let vc = OnBoardingViewController()
         
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            window?.rootViewController = nav
            
        }
        
        window?.makeKeyAndVisible()
        
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

