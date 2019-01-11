//
//  RestaurantCell.swift
//  cse335project
//
//  Created by cballen3 on 11/18/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var beforeLineDuration: UILabel!
    @IBOutlet weak var beforeLineTimePosted: UILabel!
    @IBOutlet weak var beforeLineDescription: UILabel!
    @IBOutlet weak var beforeIsImage: UILabel!
    @IBOutlet weak var beforeLineName: UILabel!
    @IBOutlet weak var isAuthorLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
