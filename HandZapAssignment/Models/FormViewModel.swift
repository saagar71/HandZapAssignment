//
//  FormViewModel.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 12/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import Foundation
import CoreData

class FormViewModel {
    var formData:FormData?
    
    func saveFormData(formTitle: String, description: String?, budget: Int, rate: Rate, payment: PaymentMethod, jobTerm: JobTerm, startDate: String, attachmentPath: String?) {
        self.formData = FormData(formTitle: formTitle, description: description, budget: budget, rate: rate, payment: payment, jobTerm: jobTerm, startDate: startDate, attachmentPath: attachmentPath)
        self.saveToDB()
    }
    
    private func saveToDB() {
        let context = AppDelegate.appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "FormDataMO", in:context)
        let item = NSManagedObject(entity: entity!, insertInto:context)
        item.setValue(formData?.formID, forKey: "formID")
        item.setValue(formData?.formTitle, forKey: "title")
        item.setValue(formData?.formDescription, forKey: "formDescription")
        item.setValue(formData?.budget, forKey: "budget")
        item.setValue(formData?.rate.rawValue, forKey: "rate")
        item.setValue(formData?.payment.rawValue, forKey: "paymentMethod")
        item.setValue(formData?.startDate, forKey: "startDate")
        item.setValue(formData?.jobTerm.rawValue, forKey: "jobTerm")
        item.setValue(formData?.attachmentPath, forKey: "attachment")
        AppDelegate.appDelegate.saveContext()
    }
}
