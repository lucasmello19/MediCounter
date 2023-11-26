//
//  History+CoreDataProperties.swift
//  MediCounter
//
//  Created by Lucas Mello on 25/11/23.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var medicament: String?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var date: Date?

}

extension History : Identifiable {

}
