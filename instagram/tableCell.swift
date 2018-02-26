//
//  tableCell.swift
//  instagram
//
//  Created by Michael Fletes on 2/26/18.
//  Copyright © 2018 Michael Fletes. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class tableCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
