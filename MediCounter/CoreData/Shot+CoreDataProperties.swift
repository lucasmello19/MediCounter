//
//  Shot+CoreDataProperties.swift
//  MediCounter
//

import Foundation
import CoreData


extension Shot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shot> {
        return NSFetchRequest<Shot>(entityName: "Shot")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var date: Date?
    @NSManaged public var took: Bool
    @NSManaged public var medicament: Medicament?

}

extension Shot : Identifiable {

}
