//
//  ImagesCell.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import UIKit

class ImagesCell: UITableViewCell {

    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorName.addshadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
