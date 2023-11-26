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
    
    func medicament(name: String, expiration: Date?) -> Medicament {
        let medicament = Medicament(context: persistentContainer.viewContext)
        medicament.medicament = name
        if let exp = expiration {
            medicament.expiration = exp
        }
        return medicament
    }
    
    func shot(amount: NSDecimalNumber, date: Date, medicament: Medicament) -> Shot {
        let shot = Shot(context: persistentContainer.viewContext)
        shot.amount = amount
        shot.date = date
        medicament.addToShots(shot)
        return shot
    }
    
    func history(amount: NSDecimalNumber, dateTook: Date, dateEffective: Date, medicament: String) -> History {
        let hist = History(context: persistentContainer.viewContext)
        hist.amount = amount
        hist.dateTook = dateTook
        hist.dateEffective = dateEffective
        hist.medicament = medicament
        return hist
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
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]

        var fetchedShots: [Shot] = []
        do {
            fetchedShots = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedShots
    }
    
    func historys() -> [History] {
        let request: NSFetchRequest<History> = History.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateEffective", ascending: false)]

        var fetchedHistorys: [History] = []
        do {
            fetchedHistorys = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return fetchedHistorys
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
