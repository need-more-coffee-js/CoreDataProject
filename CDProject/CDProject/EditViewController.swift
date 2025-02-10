//
//  EditViewController.swift
//  CDProject
//
//  Created by Денис Ефименков on 10.02.2025.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let firstNameLabel = UITextField()
    let lastNameLabel = UITextField()
    let countryLabel = UITextField()
    let birthDateLabel = UITextField()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI(){
        let stackView = UIStackView(arrangedSubviews: [firstNameLabel,lastNameLabel,countryLabel,birthDateLabel,saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        firstNameLabel.placeholder = "Фамилия"
        lastNameLabel.placeholder = "Имя"
        countryLabel.placeholder = "Страна"
        birthDateLabel.placeholder = "dd.MM.YYYY"
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.tintColor = .black
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
        let time = DateFormatter()
        time.dateFormat = "dd-MM-yyyy"
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    @objc func saveData(){
        print("savedata")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Artist", in: context) else {return}
//        
//        let artistObject = Artist(entity: entity, insertInto: context)
//        artistObject.lastName = lastNameLabel.text
//        artistObject.firstName = firstNameLabel.text
//        artistObject.country = countryLabel.text
//        let formatter = DateFormatter()
//        artistObject.birthDate = formatter.date(from: birthDateLabel.text ?? "03.08.1997")
//        
//        
//        do{
//            try context.save()
//            
//        }catch let error as NSError{
//            print(error)
//        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
