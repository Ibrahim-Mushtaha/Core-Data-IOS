//
//  Note+CoreDataProperties.swift
//  Hadi-Note-App
//
//  Created by Ibrahim Mushtaha on 26/05/2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?

}

extension Note : Identifiable {

}
