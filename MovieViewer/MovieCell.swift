//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Sandeep Raghunandhan on 1/31/17.
//  Copyright © 2017 Sandeep Raghunandhan. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
