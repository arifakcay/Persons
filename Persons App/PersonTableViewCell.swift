//
//  PersonTableViewCell.swift
//  Persons App
//
//  Created by admin on 20.08.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPersonWrite: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
