//
//  DetailsPresenter.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

class DetailsPresenter {
    weak var view: DetailsView?
    var item: University?

    func viewDidLoad() {
        if let item = item {
            view?.showItemDetails(item)
        }
    }

    func refreshListing() {
    }
}
