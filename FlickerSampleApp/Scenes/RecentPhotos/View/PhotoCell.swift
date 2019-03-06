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
    @IBOutlet private var labelOwner: UILabel!
    @IBOutlet private var labelDescription: UILabel!
    @IBOutlet private var labelTitle: UILabel!
    private let ppTag = 7238
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        imageViewProfilePicture.layer.cornerRadius = imageViewProfilePicture.bounds.width / 2
        imageViewProfilePicture.layer.borderWidth = 1
        imageViewProfilePicture.layer.borderColor = UIColor.orange.cgColor
        imageViewProfilePicture.clipsToBounds = true
        imageViewProfilePicture.tag = ppTag
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewPhoto.image = nil
        imageViewProfilePicture.image = nil
    }
    
    func configure(photo: Photo) {
        setImage(photo.profilePictureUrl ?? "", imageView: &imageViewProfilePicture)
        labelTitle.text = photo.title
        labelOwner.text = photo.ownerName
        labelDescription.text = photo.date
        if let url = photo.photoUrl {
            setImage(url,imageView: &imageViewPhoto)
        }
    }
    
    private func setImage(_ url: String, imageView: inout UIImageView) {
        let isPpImage: Bool = imageView.tag == ppTag
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: url),
            placeholder: isPpImage ? UIImage(named: "buddyicon") : nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
        
}
