//
//  HistoricoTableViewCell.swift
//  InSight
//
//  Created by Student on 2/14/17.
//  Copyright © 2017 Ramon Lima. All rights reserved.
//

import UIKit

class HistoricoTableViewCell: UITableViewCell {

    @IBOutlet weak var localLabel: UILabel!
    
    @IBOutlet weak var descricaoLocalLabel: UILabel!
    @IBOutlet weak var direcaoImage: UIImageView!
   
    @IBOutlet weak var distanciaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
