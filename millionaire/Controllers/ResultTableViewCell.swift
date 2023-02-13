//
//  ResultTableViewCell.swift
//  millionaire
//
//  Created by Sergey on 12.02.2023.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

  
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
