//
//  HomeScreenTableViewCell.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 12/11/21.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {
    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var TranName: UILabel!
    @IBOutlet weak var TranShortCode: UILabel!
    
    @IBOutlet weak var TranDate: UILabel!
    @IBOutlet weak var TranAmount: UILabel!
    

    
    func shapeContraint(){
        //circleImage.frame = CGRect(x: 20, y: 40, width: 60, height: 50)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
