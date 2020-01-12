//
//  FormsListViewController.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 11/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import UIKit

class FormsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var formListViewModel:FormListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Form Listing"
        self.formListViewModel = FormListViewModel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    func refreshData() {
        self.formListViewModel.getAllForms()
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.formListViewModel.formDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormCell") as! FormDataTableViewCell
        if formListViewModel.formDataList.count > indexPath.row {
            cell.cellIndex = indexPath.row
            cell.delegate = self
            let form = formListViewModel.formDataList[indexPath.row]
            cell.title.text = form.formTitle
            cell.dateLbl.text = form.startDate
            cell.rateLbl.text = form.rate.rawValue
            cell.jobTermLbl.text = form.jobTerm.rawValue
            //Views is taken random no considering it should be reflected from server
            let views = Int.random(in: 0 ..< 500)
            cell.viewsLbl.text = "\(views) Views"
        }
        return cell
    }

    @IBAction func showNewFormViewController(_ sender: Any) {
        let newFormVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewForm") as! NewFormViewController
        self.navigationController?.pushViewController(newFormVC, animated: true)
    }
}

extension FormsListViewController: FormDataCellDelegate{
    func deleteForm(index: Int) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete Form", style: .destructive) { action -> Void in
            if self.formListViewModel.formDataList.count > index {
                let formObj = self.formListViewModel.formDataList[index]
                self.formListViewModel.deleteForm(formID: formObj.formID)
                self.refreshData()
            }
        }
        let image = UIImage(named: "Trash_icon")
        deleteAction.setValue(image, forKey: "image")

        actionSheetController.addAction(deleteAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
}

