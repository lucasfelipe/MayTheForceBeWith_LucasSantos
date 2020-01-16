//
//  AbstractPeopleTableViewController.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 15/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import UIKit

private let reuseIdentifier = "peopleCell"
private let personDetailSegueIdentifier = "PersonDetailSegue"

class AbstractPeopleTableViewController: UITableViewController {

    var activityIndicatorView: UIActivityIndicatorView!
    var apiPeopleGateway: PeopleGateway!
    var apiClient: ApiClient = ApiClientImpl(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
    var nextPage: Int = 1
    var people = [ApiPeople]()
    var peopleCount: Int {
        return people.count
    }
    var peopleSelectedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        self.configureApiPeopleGateway()
        self.configureActivityIndicatorView()
    }
    
    func configureActivityIndicatorView() {
        self.activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.tableView.backgroundView = activityIndicatorView
    }
    
    func configureApiPeopleGateway() {
        self.apiPeopleGateway = ApiPeopleGateway(apiClient: apiClient)
    }
    
    func handlePeopleReceived(response: ApiPeopleResponse) {
        self.nextPage = response.nextPage
        self.people.append(contentsOf: response.people)
        self.activityIndicatorView.stopAnimating()
        self.tableView.reloadData()
    }
    
    func handlePeopleError(_ error: Error) {
        self.activityIndicatorView.stopAnimating()
        showAlert(title: "Error", message: error.localizedDescription)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PeopleTableViewCell

        configure(cell: cell, at: indexPath.row)

        return cell
    }
    
    private func configure(cell: PeopleTableViewCell, at row: Int) {
        let person = people[row]
        
        cell.display(name: person.name ?? "")
        cell.display(height: person.height ?? 0, mass: person.mass ?? 0)
        cell.display(birthYear: person.birthYear ?? "")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.peopleSelectedIndex = indexPath.row
        self.performSegue(withIdentifier: personDetailSegueIdentifier, sender: nil)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PersonDetailViewController else { return }
        let person = people[self.peopleSelectedIndex]
        destination.person = person
    }

}
