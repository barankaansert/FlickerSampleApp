//
//  AppContainer.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import Foundation

/**
 Container of app, holds app's persistent contents.
 */
let App = AppContainer()

final class AppContainer {
    /**
     Preventing initialize another instances
     */
    fileprivate init() { }
    
    let router = AppRouter()
}
