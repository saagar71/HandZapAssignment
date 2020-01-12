//
//  FormData.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 11/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import Foundation

enum Rate: String, CaseIterable {
    case noPreference = "No Preference"
    case fixedBudget = "Fixed Budget"
    case hourlyBudget = "Hourly Budget"
}

enum PaymentMethod: String, CaseIterable {
    case noPreference = "No Preference"
    case ePayment = "E-Payment"
    case cash = "Cash"
}

enum JobTerm:String, CaseIterable {
    case noPreference = "No Preference"
    case recurringJob = "Recurring Job"
    case sameDayJob = "Same Day Job"
    case multiDayJob = "Multi Days Job"
}

class FormData {
    var formID:String = UUID().uuidString
    var formTitle:String!
    var formDescription:String?
    var budget:Int!
    var rate:Rate = .noPreference
    var payment:PaymentMethod = .noPreference
    var jobTerm:JobTerm = .noPreference
    var startDate:String!
    var attachmentPath:String?
    
    init(formTitle:String, description:String? = nil, budget:Int, rate:Rate = .noPreference, payment:PaymentMethod = .noPreference, jobTerm:JobTerm = .noPreference, startDate:String, attachmentPath:String? = nil) {
        self.formTitle = formTitle
        self.formDescription = description
        self.budget = budget
        self.rate = rate
        self.payment = payment
        self.jobTerm = jobTerm
        self.startDate = startDate
        self.attachmentPath = attachmentPath
    }
    
}
