//
//  ListingViewController.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

import UIKit

protocol ListingView: AnyObject {
    func showItems(_ items: [University])
    func showError(_ message: String)
}

class ListingViewController: UIViewController, ListingView {
    var presenter: ListingPresenter?
    private var items: [University] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshListing), name: .refreshListing, object: nil)
    }

    @objc private func refreshListing() {
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
    }

    func showItems(_ items: [University]) {
        self.items = items
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = "\(item.name), \(item.state ?? ""), \(item.country) [\(item.alpha_two_code)] - \(item.web_pages)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
    }
}

extension Notification.Name {
    static let refreshListing = Notification.Name("refreshListing")
}
