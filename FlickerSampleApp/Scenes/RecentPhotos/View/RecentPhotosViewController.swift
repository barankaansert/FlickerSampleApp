//
//  RecentPhotosViewController.swift
//  FlickerSampleApp
//
//  Created Baran Kaan Sert on 6.03.2019.
//  Copyright © 2019 Baran Kaan Sert. All rights reserved.
//


import UIKit

class RecentPhotosViewController: UIViewController {
    
	var presenter: RecentPhotosPresenterProtocol!

    @IBOutlet private var tableView: UITableView!
    
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

extension RecentPhotosViewController: RecentPhotosViewProtocol {
    func handleOutput(_ output: RecentPhotosPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .updateTitle(let title):
            self.title = title
        case .showPhotos:
            self.tableView.reloadData()
        }
    }
}

extension RecentPhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        cell.configure(photo: presenter.photos[indexPath.row])
        return cell
    }
    
}

extension RecentPhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PhotoCell.height
    }
}
