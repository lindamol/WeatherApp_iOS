//
//  City+CoreDataProperties.swift
//  MYProjectios
//
//  Created by user203935 on 10/26/21.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityname: String?

}

extension City : Identifiable {

}
