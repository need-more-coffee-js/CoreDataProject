import UIKit
import CoreData
import SnapKit

class RootViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate {
    var artists: [Artist] = []
    // Таблица
    private var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController<Artist>!
    private let sortKey = "lastName" // Ключ сортировки
    private var sortAscending = true // Направление сортировки

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Artists"

        // Инициализация таблицы
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        // Верстка с помощью SnapKit
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // Таблица занимает весь экран
        }

        // Кнопка добавления
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addArtist))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addArtist() {
        print("tap +")
        print(artists)
        let editVC = EditViewController()
        present(editVC,animated: true,completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count // Примерное количество строк
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let res = artists[indexPath.row]
        cell.textLabel?.text = res.firstName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Логика перехода на другой экран
    }
}

