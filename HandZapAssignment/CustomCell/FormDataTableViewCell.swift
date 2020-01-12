//
//  FormDataCellTableViewCell.swift
//  HandZapAssignment
//
//  Created by Sagar Shinde on 11/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import UIKit

protocol FormDataCellDelegate {
    func deleteForm(index:Int)
}
class FormDataTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var jobTermLbl: UILabel!
    var delegate:FormDataCellDelegate?
    var cellIndex:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func jobPostingSettingsButtonTapped(_ sender: Any) {
        delegate?.deleteForm(index: cellIndex)
    }
    
}
