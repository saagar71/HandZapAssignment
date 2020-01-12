//
//  FormDataMO+CoreDataProperties.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 12/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//
//

import Foundation
import CoreData


extension FormDataMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FormDataMO> {
        return NSFetchRequest<FormDataMO>(entityName: "FormDataMO")
    }

    @NSManaged public var title: String?
    @NSManaged public var formDescription: String?
    @NSManaged public var budget: Int32
    @NSManaged public var rate: String?
    @NSManaged public var paymentMethod: String?
    @NSManaged public var startDate: String?
    @NSManaged public var jobTerm: String?
    @NSManaged public var attachment: String?
    @NSManaged public var formID: String?

}
