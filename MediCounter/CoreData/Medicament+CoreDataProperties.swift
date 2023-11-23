//
//  Medicament+CoreDataProperties.swift
//  MediCounter
//

import Foundation
import CoreData


extension Medicament {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medicament> {
        return NSFetchRequest<Medicament>(entityName: "Medicament")
    }

    @NSManaged public var medicament: String?
    @NSManaged public var shots: NSSet?

}

// MARK: Generated accessors for shots
extension Medicament {

    @objc(addShotsObject:)
    @NSManaged public func addToShots(_ value: Shot)

    @objc(removeShotsObject:)
    @NSManaged public func removeFromShots(_ value: Shot)

    @objc(addShots:)
    @NSManaged public func addToShots(_ values: NSSet)

    @objc(removeShots:)
    @NSManaged public func removeFromShots(_ values: NSSet)

}

extension Medicament : Identifiable {

}
