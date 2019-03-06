//
//  PhotoCell.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    static let identifier = "PhotoCell"
    static let height: CGFloat = 300

    @IBOutlet private var imageViewPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(photo: Photo) {
        imageView?.imageFromURL(photo.url_l)
    }
}
