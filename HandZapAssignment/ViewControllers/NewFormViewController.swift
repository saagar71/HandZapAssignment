//
//  NewFormViewController.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 11/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import UIKit

enum PickerViewType: Int{
    case rate = 997
    case payment = 998
    case jobTerm = 999
}

class NewFormViewController: UIViewController {

    @IBOutlet weak var formTitleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var budgetTF: UITextField!
    @IBOutlet weak var paymentTF: UITextField!
    @IBOutlet weak var rateTF: UITextField!
    @IBOutlet weak var startDateTF: UITextField!
    @IBOutlet weak var jobTermTF: UITextField!
    @IBOutlet weak var currencyView: UIView!
    
    @IBOutlet weak var textViewBGView: UIView!
    @IBOutlet weak var descriptionReqLabel: UILabel!
    @IBOutlet weak var titleReqLbl: UILabel!
    @IBOutlet weak var budgetReqLbl: UILabel!
    @IBOutlet weak var startDateReqLbl: UILabel!
    
    static let maxCharacterCountForDescription = 330
    static let macCharacterCountForTitle = 65
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    var activeTextField:UITextField?
    var pickerSelectionIndex = 0
    var formViewModel:FormViewModel = FormViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorderToViews()
        showDatePicker()
        createPickerView()
        self.descriptionTV.layer.masksToBounds = true
        self.navigationItem.title = "New Form"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back_Button"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: UIBarButtonItem.Style.plain, target: self, action: #selector(sendButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func createPickerView()  {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.rateTF.inputAccessoryView = toolbar
        self.rateTF.inputView = self.pickerView
        self.paymentTF.inputAccessoryView = toolbar
        self.paymentTF.inputView = self.pickerView
        self.jobTermTF.inputAccessoryView = toolbar
        self.jobTermTF.inputView = self.pickerView
    }

    func addBorderToViews() {
        self.formTitleTF.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.textViewBGView.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.budgetTF.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.paymentTF.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.rateTF.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.startDateTF.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.jobTermTF.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        self.currencyView.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
    }
    
    func addBorder(view:UIView, color:UIColor , hideReqLbl:Bool = false) {
        if let textField = view as? UITextField {
            switch textField {
            case self.formTitleTF:
                self.titleReqLbl.textColor = (color == UIColor.red) ? color : UIColor.gray
                self.titleReqLbl.isHidden = hideReqLbl
            case self.budgetTF:
                self.budgetReqLbl.textColor = (color == UIColor.red) ? color : UIColor.gray
                self.budgetReqLbl.isHidden = hideReqLbl
            case self.startDateTF:
                self.startDateReqLbl.textColor = (color == UIColor.red) ? color : UIColor.gray
                self.startDateReqLbl.isHidden = hideReqLbl
            default:
                break
            }
        }
        if  view is UITextView {
            textViewBGView.layer.addBorder(edge: .bottom, color: color, thickness: 1.0)
        }
        else {
            view.layer.addBorder(edge: .bottom, color: color, thickness: 1.0)
        }
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        self.startDateTF.inputAccessoryView = toolbar
        self.startDateTF.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        if self.activeTextField == self.startDateTF {
            self.activeTextField?.text = formatter.string(from: datePicker.date)
        }
        else {
            if let activeTF = activeTextField, activeTF.isEmpty() {
                switch activeTextField {
                case self.rateTF:
                    self.activeTextField?.text = Rate.allCases[pickerSelectionIndex].rawValue
                case self.paymentTF:
                    self.activeTextField?.text = PaymentMethod.allCases[pickerSelectionIndex].rawValue
                case self.jobTermTF:
                    self.activeTextField?.text = JobTerm.allCases[pickerSelectionIndex].rawValue
                default:
                    self.activeTextField?.text = ""
                }

            }
        }
        self.view.endEditing(true)
        self.validateRequiredFields()
    }
    
    func validateRequiredFields() {
        if (!self.formTitleTF.isEmpty() && !self.budgetTF.isEmpty() && !self.startDateTF.isEmpty()) {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func sendButtonTapped() {
        self.formViewModel.saveFormData(formTitle: self.formTitleTF.text!, description: self.descriptionTV.text, budget: Int(self.budgetTF!.text!)! , rate: (!self.rateTF.isEmpty() ? Rate(rawValue: self.rateTF!.text!) ?? .noPreference : .noPreference), payment: (!self.paymentTF.isEmpty() ? PaymentMethod(rawValue: self.paymentTF!.text!) ?? .noPreference: .noPreference), jobTerm: (!self.jobTermTF.isEmpty() ? JobTerm(rawValue: self.jobTermTF!.text!) ?? .noPreference: .noPreference), startDate: self.startDateTF.text!, attachmentPath: nil)
        self.navigationController?.popViewController(animated: true)
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewFormViewController:UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.updateRequiredFields(currentField: textField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        self.pickerView.reloadAllComponents()
        pickerSelectionIndex = 0
        self.pickerView.selectRow(pickerSelectionIndex, inComponent: 0, animated: true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.addBorder(view: textField, color: UIColor.gray, hideReqLbl: !textField.isEmpty())
        self.validateRequiredFields()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.formTitleTF {
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let numberOfChars = newText.count
            if numberOfChars < NewFormViewController.macCharacterCountForTitle {
                self.titleReqLbl.text = "\(NewFormViewController.macCharacterCountForTitle - numberOfChars) characters left"
            }
            return numberOfChars < NewFormViewController.macCharacterCountForTitle
        }
        else if textField == self.budgetTF {
            return true
        }
        textField.resignFirstResponder()
        return false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewFormViewController:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.formTitleTF.text?.count == 0 {
            self.addBorder(view: self.formTitleTF, color: UIColor.red)
        }
        self.addBorder(view: textView, color: UIColor.darkGray)
        if textView.text == "Form Description" {
            textView.text = ""
            textView.textColor = UIColor.init(displayP3Red: 51/255.0, green: 78/255.0, blue: 102/255.0, alpha: 1.0)
        }
        self.descriptionReqLabel.isHidden = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.addBorder(view: textView, color: UIColor.gray)
        textView.resignFirstResponder()
        if textView.text.isEmpty {
            textView.text = "Form Description"
            textView.textColor = UIColor.lightGray
        }
        self.descriptionReqLabel.isHidden = true
        self.validateRequiredFields()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if numberOfChars < NewFormViewController.maxCharacterCountForDescription {
            self.descriptionReqLabel.text = "\(NewFormViewController.maxCharacterCountForDescription - numberOfChars) characters left"
        }

        return numberOfChars < NewFormViewController.maxCharacterCountForDescription

    }
    
    func updateRequiredFields(currentField:UITextField) {
        self.addBorder(view: currentField, color: UIColor.darkGray)

        switch currentField {
        case self.budgetTF:
            if self.formTitleTF.isEmpty() {
                self.addBorder(view: self.formTitleTF, color: UIColor.red)
            }
        case self.rateTF:
            if self.formTitleTF.isEmpty() {
                self.addBorder(view: self.formTitleTF, color: UIColor.red)
            }
            if self.budgetTF.isEmpty() {
                self.addBorder(view: self.budgetTF, color: UIColor.red)
            }
        case self.paymentTF:
            if self.formTitleTF.isEmpty() {
                self.addBorder(view: self.formTitleTF, color: UIColor.red)
            }
            if self.budgetTF.isEmpty() {
                self.addBorder(view: self.budgetTF, color: UIColor.red)
            }

        case self.startDateTF:
            if self.formTitleTF.isEmpty() {
                self.addBorder(view: self.formTitleTF, color: UIColor.red)
            }
            if self.budgetTF.isEmpty() {
                self.addBorder(view: self.budgetTF, color: UIColor.red)
            }
        case self.jobTermTF:
            if self.formTitleTF.isEmpty() {
                self.addBorder(view: self.formTitleTF, color: UIColor.red)
            }
            if self.budgetTF.isEmpty() {
                self.addBorder(view: self.budgetTF, color: UIColor.red)
            }
            if self.startDateTF.isEmpty() {
                self.addBorder(view: self.startDateTF, color: UIColor.red)
            }

        default:
            break
        }
    }
}

extension NewFormViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch activeTextField {
        case self.rateTF:
            return Rate.allCases.count
        case self.paymentTF:
            return PaymentMethod.allCases.count
        case self.jobTermTF:
            return JobTerm.allCases.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch activeTextField {
        case self.rateTF:
            return Rate.allCases[row].rawValue
        case self.paymentTF:
            return PaymentMethod.allCases[row].rawValue
        case self.jobTermTF:
            return JobTerm.allCases[row].rawValue
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerSelectionIndex = row
//        switch activeTextField {
//        case self.rateTF:
//            self.activeTextField?.text = Rate.allCases[row].rawValue
//        case self.paymentTF:
//            self.activeTextField?.text = PaymentMethod.allCases[row].rawValue
//        case self.jobTermTF:
//            self.activeTextField?.text = JobTerm.allCases[row].rawValue
//        default:
//            self.activeTextField?.text = ""
//        }
    }
    
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
}

extension UITextField {
    func isEmpty() -> Bool {
        return self.text?.count == 0
    }
}
