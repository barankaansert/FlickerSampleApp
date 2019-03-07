//
//  RecentPhotosViewController.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import UIKit
import ImageViewer

class RecentPhotosViewController: UIViewController {
    
	var presenter: RecentPhotosPresenterProtocol!

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    private var imageViewPhoto: UIImageView?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.load()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: PhotoCell.identifier, bundle: nil), forCellReuseIdentifier: PhotoCell.identifier)
    }
}

// MARK: Handling Output
extension RecentPhotosViewController: RecentPhotosViewProtocol {
    func handleOutput(_ output: RecentPhotosPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        case .updateTitle(let title):
            self.title = title
        case .showPhotos:
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableView DataSources
extension RecentPhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        cell.configure(photo: presenter.photos[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

// MARK: UITableView Delegates
extension RecentPhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PhotoCell.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.photos.count-1 {
            presenter.load()
        }
    }
}

// MARK: PhotoCell Delegates
extension RecentPhotosViewController: PhotoCellDelegate {
    func cellDidTapped(cell: PhotoCell) {
        imageViewPhoto = cell.imageViewPhoto
        presenter.selectPhoto()
    }
}

// MARK: Gallery Items Data Sources
extension RecentPhotosViewController: GalleryItemsDataSource {
    func itemCount() -> Int {
        return 1
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        return GalleryItem.image { $0( self.imageViewPhoto?.image) }
    }
}


// MARK: Route to gallery
extension RecentPhotosViewController {
    func presentPhoto() {
        let controller = GalleryViewController(startIndex: 0,
                                               itemsDataSource: self,
                                               configuration: [GalleryConfigurationItem.deleteButtonMode(.none),
                                                               GalleryConfigurationItem.thumbnailsButtonMode(.none)])
        self.presentImageGallery(controller)
    }
}
