//
//  ArtistListViewController.swift
//  CDProject
//
//  Created by Денис Ефименков on 10.02.2025.
//

import UIKit
import CoreData
import SnapKit

class ArtistListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    private let tableView = UITableView()
    private var fetchedResultsController: NSFetchedResultsController<Artist>!
    private let sortKey = "lastName" // Ключ сортировки
    private var sortAscending = true // Направление сортировки

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFetchedResultsController()
        loadSortSettings()
        addTestData()
    }
    
    @objc private func changeSortOrder() {
        sortAscending.toggle()
        saveSortSettings()
        setupFetchedResultsController()
        tableView.reloadData()
    }
    

    private func setupUI() {
        title = "Исполнители"
        view.backgroundColor = .red

        // Настройка таблицы
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Кнопка добавления
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addArtist))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сортировка", style: .plain, target: self, action: #selector(changeSortOrder))
    }

    private func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Artist> = Artist.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: sortAscending)
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataStack.shared.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to fetch artists: \(error)")
        }
    }
    
    private func addTestData() {
        let context = CoreDataStack.shared.context

        let artist1 = Artist(context: context)
        artist1.firstName = "John"
        artist1.lastName = "Doe"
        artist1.birthDate = Date()
        artist1.country = "USA"

        let artist2 = Artist(context: context)
        artist2.firstName = "Jane"
        artist2.lastName = "Smith"
        artist2.birthDate = Date()
        artist2.country = "Canada"

        CoreDataStack.shared.saveContext()
    }

    private func loadSortSettings() {
        let defaults = UserDefaults.standard
        sortAscending = defaults.bool(forKey: "sortAscending")
    }

    private func saveSortSettings() {
        let defaults = UserDefaults.standard
        defaults.set(sortAscending, forKey: "sortAscending")
    }

    @objc private func addArtist() {
        let editVC = ArtistEditViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let artist = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(artist.lastName ?? "") \(artist.firstName ?? "")"
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = fetchedResultsController.object(at: indexPath)
        let editVC = ArtistEditViewController(artist: artist)
        navigationController?.pushViewController(editVC, animated: true)
    }

    // MARK: - NSFetchedResultsControllerDelegate

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
