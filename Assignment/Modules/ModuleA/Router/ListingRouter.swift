//
//  ListingRouter.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

import UIKit

class ListingRouter {
    weak var viewController: UIViewController?

    func navigateToDetails(with item: University) {
        let detailsVC = DetailsViewController()
        let detailsPresenter = DetailsPresenter()
        detailsPresenter.item = item
        detailsPresenter.view = detailsVC
        detailsVC.presenter = detailsPresenter

        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}



