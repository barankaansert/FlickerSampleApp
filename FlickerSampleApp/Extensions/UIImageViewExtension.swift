//
//  UIImageViewExtension.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func imageFromURL(_ urlString: String?) {
        if let urlStr = urlString, let url = URL(string: urlStr) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                guard let imgData = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: imgData)
                }
            }
        }
    }
}
