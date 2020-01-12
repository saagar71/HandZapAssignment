//
//  FormDataMO+CoreDataProperties.swift
//  
//
//  Created by Sagar Shinde on 12/01/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FormDataMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FormDataMO> {
        return NSFetchRequest<FormDataMO>(entityName: "FormDataMO")
    }

    @NSManaged public var attachment: String?
    @NSManaged public var budget: Int32
    @NSManaged public var formDescription: String?
    @NSManaged public var jobTerm: String?
    @NSManaged public var paymentMethod: String?
    @NSManaged public var rate: String?
    @NSManaged public var startDate: String?
    @NSManaged public var title: String?

}
