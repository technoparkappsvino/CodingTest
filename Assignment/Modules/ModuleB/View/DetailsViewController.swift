//
//  DetailsViewController.swift
//  Assignment
//
//  Created by Vinoth Kumar GIRI on 27/05/24.
//

import UIKit

protocol DetailsView: AnyObject {
    func showItemDetails(_ item: University)
}

class DetailsViewController: UIViewController, DetailsView {
    var presenter: DetailsPresenter?
    private let nameLabel = UILabel()
    private let stateLabel = UILabel()
    private let countryLabel = UILabel()
    private let codeLabel = UILabel()
    private let websiteLabel = UILabel()
    private let refreshButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshListing), name: .refreshListing, object: nil)
    }
    
    @objc private func refreshListing() {
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [nameLabel, stateLabel, countryLabel, codeLabel, websiteLabel, refreshButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.setTitleColor(.blue, for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }

    @objc private func refreshButtonTapped() {
        presenter?.refreshListing()
    }

    func showItemDetails(_ item: University) {
        nameLabel.text = "Name: \(item.name)"
        stateLabel.text = "State: \(item.state ?? "")"
        countryLabel.text = "Country: \(item.country)"
        codeLabel.text = "Code: \(item.alpha_two_code)"
        websiteLabel.text = "Website: \(item.web_pages)"
    }
}
