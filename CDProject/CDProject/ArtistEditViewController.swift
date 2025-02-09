//
//  ArtistEditViewController.swift
//  CDProject
//
//  Created by Денис Ефименков on 10.02.2025.
//

import UIKit
import SnapKit

class ArtistEditViewController: UIViewController {

    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let birthDatePicker = UIDatePicker()
    private let countryTextField = UITextField()
    private var artist: Artist?

    init(artist: Artist? = nil) {
        self.artist = artist
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadArtistData()
    }

    private func setupUI() {
        title = artist == nil ? "Новый исполнитель" : "Редактирование"
        view.backgroundColor = .white

        // Настройка текстовых полей
        firstNameTextField.placeholder = "Имя"
        lastNameTextField.placeholder = "Фамилия"
        countryTextField.placeholder = "Страна"
        birthDatePicker.datePickerMode = .date

        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, birthDatePicker, countryTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        // Кнопка сохранения
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveArtist))
    }

    private func loadArtistData() {
        guard let artist = artist else { return }
        firstNameTextField.text = artist.firstName
        lastNameTextField.text = artist.lastName
        birthDatePicker.date = artist.birthDate ?? Date()
        countryTextField.text = artist.country
    }

    @objc private func saveArtist() {
        let context = CoreDataStack.shared.context
        let artist = self.artist ?? Artist(context: context)

        artist.firstName = firstNameTextField.text
        artist.lastName = lastNameTextField.text
        artist.birthDate = birthDatePicker.date
        artist.country = countryTextField.text

        CoreDataStack.shared.saveContext()
        navigationController?.popViewController(animated: true)
    }
}
