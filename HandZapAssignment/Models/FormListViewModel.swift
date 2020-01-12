//
//  FormListViewModel.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 11/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import Foundation
import CoreData

class FormListViewModel {
    var formDataList:[FormData] = []
    
    init() {
        //Load Data from DB
    }
    
    func getAllForms()  {
        if let formMOs = fetchFormsFromDB() {
            self.createForDataObjs(formDataMOArr: formMOs)
        }
    }
    private func fetchFormsFromDB(formID:String? = nil) -> [FormDataMO]? {
        self.formDataList.removeAll()
        let fetchRequest = NSFetchRequest<FormDataMO>(entityName: "FormDataMO")
        if formID != nil {
            let predicate = NSPredicate(format: "formID like %@", formID!)
            fetchRequest.predicate = predicate
        }
        do {
            let context = AppDelegate.appDelegate.persistentContainer.viewContext
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        return nil
    }
    
    private func createForDataObjs(formDataMOArr:[FormDataMO]) {
        for obj in formDataMOArr {
            let formDataObj = FormData(formTitle: obj.title!, description: obj.formDescription, budget: Int(obj.budget), rate: Rate(rawValue: obj.rate!) ?? .noPreference, payment: PaymentMethod(rawValue: obj.paymentMethod!) ?? .noPreference, jobTerm: JobTerm(rawValue: obj.jobTerm!) ?? .noPreference, startDate: obj.startDate ?? " ", attachmentPath: obj.attachment)
            if obj.formID != nil {
                formDataObj.formID = obj.formID!
            }
            self.formDataList.append(formDataObj)
        }
    }
    
    func deleteForm(formID:String)  {
        if let formMos = fetchFormsFromDB(formID: formID), formMos.count > 0 {
            let context = AppDelegate.appDelegate.persistentContainer.viewContext
            context.delete(formMos[0])
        }
        AppDelegate.appDelegate.saveContext()
    }
    
}

