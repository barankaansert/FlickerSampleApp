//
//  PhotoCell.swift
//  FlickerSampleApp
//
//  Created by Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UITableViewCell {
    
    static let identifier = "PhotoCell"
    static let height: CGFloat = 400

    @IBOutlet private var imageViewPhoto: UIImageView!
    @IBOutlet private var imageViewProfilePicture: UIImageView!
    @IBOutlet private var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        imageViewProfilePicture.layer.cornerRadius = imageViewProfilePicture.bounds.width / 2
        imageViewProfilePicture.layer.borderWidth = 1
        imageViewProfilePicture.layer.borderColor = UIColor.lightGray.cgColor
        imageViewProfilePicture.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewPhoto.image = nil
        imageViewProfilePicture.image = nil
    }
    
    func configure(photo: Photo) {
        setProfilePicture(photo: photo)
        labelTitle.text = photo.title
        if let url = photo.photoUrl {
            setImage(url)
        }
    }
    
    private func setImage(_ url: String) {
        imageViewPhoto.kf.indicatorType = .activity
        imageViewPhoto.kf.setImage(
            with: URL(string: url),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    private func setProfilePicture(photo: Photo) {
        var url: String = AppConstants.Endpoint.Base.ppUrl
        url = url.replacingOccurrences(of: "{icon-farm}", with: "\(photo.iconfarm)")
        url = url.replacingOccurrences(of: "{icon-server}", with: photo.iconserver)
        url = url.replacingOccurrences(of: "{nsid}", with: photo.owner)
        let photoUrl = URL(string: url)
        imageViewProfilePicture.kf.indicatorType = .activity
        imageViewProfilePicture.kf.setImage(
            with: photoUrl,
            placeholder: UIImage(named: "buddyicon"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
        
}
