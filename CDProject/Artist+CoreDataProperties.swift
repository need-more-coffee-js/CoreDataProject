//
//  Artist+CoreDataProperties.swift
//  CDProject
//
//  Created by Денис Ефименков on 10.02.2025.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var birthDate: Date?
    @NSManaged public var country: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}

extension Artist : Identifiable {

}
