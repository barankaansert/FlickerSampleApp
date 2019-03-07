//
//  RecentPhotosRouter.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import UIKit

class RecentPhotosRouter: RecentPhotosWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = RecentPhotosViewController(nibName: nil, bundle: nil)
        let service = RecentPhotosService()
        let interactor = RecentPhotosInteractor(service: service)
        let router = RecentPhotosRouter()
        let presenter = RecentPhotosPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    /**
     Handling Route in RecentPhotosRouter
     - parameter output: navigation option of router
     */
    func navigate(to route: RecentPhotosRoute) {
        switch route {
        case .detail:
            (viewController as! RecentPhotosViewController).presentPhoto()
        }
    }
    
    
    
    
    
}
