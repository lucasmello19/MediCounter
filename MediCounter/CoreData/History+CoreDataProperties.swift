//
//  History+CoreDataProperties.swift
//  MediCounter
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var medicament: String?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var dateTook: Date?
    @NSManaged public var dateEffective: Date?

}

extension History : Identifiable {

}
