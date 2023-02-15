//
//  TableViewCellSubclass.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/9/23.
//

import UIKit

class TableViewCellSubclass: UITableViewCell {
    
    
    
    @IBOutlet weak var typeOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var locationOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(e: Events){
        
        typeOutlet.text = e.type
        if e.here{
            typeOutlet.text! += " (H)"
        }else{
            typeOutlet.text! += " (A)"
        }
        dateOutlet.text = e.date
        locationOutlet.text = "@ \(e.loc)"
        
    }

}
