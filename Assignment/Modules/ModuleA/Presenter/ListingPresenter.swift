//
//  ListingPresenter.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

class ListingPresenter {
    weak var view: ListingView?
    var interactor: ListingInteractor?
    var router: ListingRouter?

    func viewDidLoad() {
        interactor?.fetchItems()
    }

    func didSelectItem(at index: Int) {
        guard let item = interactor?.items[index] else { return }
        router?.navigateToDetails(with: item)
    }

    func didFetchItems(_ items: [University]) {
        view?.showItems(items)
    }

    func didFailToFetchItems(with error: Error) {
        view?.showError(error.localizedDescription)
    }
}
