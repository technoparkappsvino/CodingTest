//
//  ListingInteractor.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

import RealmSwift

class ListingInteractor {
    var presenter: ListingPresenter?
    var items: [University] = []

    func fetchItems() {
        let url = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.fetchItemsFromDatabase()
                self?.presenter?.didFailToFetchItems(with: error)
                return
            }
            guard let data = data else { return }
            do {
                let items = try JSONDecoder().decode([University].self, from: data)
                self?.items = items
                self?.saveItemsToDatabase(items)
                self?.presenter?.didFetchItems(items)
            } catch {
                self?.fetchItemsFromDatabase()
                self?.presenter?.didFailToFetchItems(with: error)
            }
        }.resume()
    }

    private func fetchItemsFromDatabase() {
        let realm = try! Realm()
        let items = realm.objects(University.self)
        self.items = Array(items)
        presenter?.didFetchItems(self.items)
    }

    private func saveItemsToDatabase(_ items: [University]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(items, update: .modified)
        }
    }
}



