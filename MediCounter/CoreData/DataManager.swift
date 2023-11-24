//
//  DataMAnager.swift
//  MediCounter
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MediCounter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func medicament(name: String) -> Medicament {
        let medicament = Medicament(context: persistentContainer.viewContext)
        medicament.medicament = name
        return medicament
    }
    
    func shot(amount: Int16, date: Date, medicament: Medicament) -> Shot {
        let shot = Shot(context: persistentContainer.viewContext)
        shot.amount = amount
        shot.date = date
        medicament.addToShots(shot)
        return shot
    }
    
    func medicaments() -> [Medicament] {
        let request: NSFetchRequest<Medicament> = Medicament.fetchRequest()
        var fetchedMedicaments: [Medicament] = []
        do {
            fetchedMedicaments = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return fetchedMedicaments
    }
    
    func shots(medicament: Medicament) -> [Shot] {
        let request: NSFetchRequest<Shot> = Shot.fetchRequest()
        request.predicate = NSPredicate(format: "medicament = %@", medicament)
        //      request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedShots: [Shot] = []
        do {
            fetchedShots = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedShots
    }
    
    func deleteShot(shot: Shot) {
        let context = persistentContainer.viewContext
        context.delete(shot)
        save()
    }
    func deleteMedicament(medicament: Medicament) {
        let context = persistentContainer.viewContext
        context.delete(medicament)
        save()
    }
}
