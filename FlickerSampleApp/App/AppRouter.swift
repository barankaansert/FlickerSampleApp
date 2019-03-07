//
//  AppRouter.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import UIKit

final class AppRouter {
    
    /**
     Starting application with UIApplications window.
     */
    func start(window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = RecentPhotosRouter.createModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }
}

