//
//  LabelWithTextfieldTableViewCell.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import UIKit

class LabelWithTextfieldTableViewCell: UITableViewCell {
    
    //MARK:
    //MARK: Property
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK:
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
